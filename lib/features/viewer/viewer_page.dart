import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

import '../../core/viewer/immersive_service.dart';
import '../../core/viewer/mesh_importer.dart';
import '../../core/viewer/mesh_model.dart';
import 'ar_viewer_page.dart';
import 'vr_viewer_page.dart';

class ViewerPage extends StatefulWidget {
  const ViewerPage({super.key});

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

enum _TransformMode { move, rotate, scale }

enum _ViewPreset { isometric, front, back, left, right, top, bottom }

class _SceneItem {
  const _SceneItem({
    required this.id,
    required this.mesh,
    required this.transform,
    this.visible = true,
    this.lockPosition = false,
    this.lockRotation = false,
    this.lockScale = false,
    this.uniformScale = true,
    this.sourcePath,
  });

  final String id;
  final MeshModel mesh;
  final ObjectTransform transform;
  final bool visible;
  final bool lockPosition;
  final bool lockRotation;
  final bool lockScale;
  final bool uniformScale;
  final String? sourcePath;

  bool get locked => lockPosition && lockRotation && lockScale;

  _SceneItem copyWith({
    ObjectTransform? transform,
    bool? visible,
    bool? lockPosition,
    bool? lockRotation,
    bool? lockScale,
    bool? uniformScale,
  }) => _SceneItem(
    id: id,
    mesh: mesh,
    transform: transform ?? this.transform,
    visible: visible ?? this.visible,
    lockPosition: lockPosition ?? this.lockPosition,
    lockRotation: lockRotation ?? this.lockRotation,
    lockScale: lockScale ?? this.lockScale,
    uniformScale: uniformScale ?? this.uniformScale,
    sourcePath: sourcePath,
  );
}

class _ViewerPageState extends State<ViewerPage> {
  final _importer = const MeshImporter();
  final _immersive = const ImmersiveService();
  final _undo = <List<_SceneItem>>[];
  final _redo = <List<_SceneItem>>[];
  final _items = <_SceneItem>[];
  String? _selectedId;
  String? _message;
  bool _busy = false;
  bool _snap = true;
  _TransformMode _mode = _TransformMode.rotate;
  _ViewPreset _view = _ViewPreset.isometric;
  ImmersiveCapability? _capability;
  double _cameraZoom = 1;
  Offset _cameraPan = Offset.zero;
  final FocusNode _canvasFocus = FocusNode();
  double _gestureZoomStart = 1;

  @override
  void dispose() {
    _canvasFocus.dispose();
    super.dispose();
  }

  _SceneItem? get _selected {
    for (final item in _items) {
      if (item.id == _selectedId) return item;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadCapability();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    return Column(
      children: [
        _toolbar(context, selected),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 960;
              final canvas = _canvas(context, selected);
              final inspector = _inspector(context, selected);
              return wide
                  ? Row(
                      children: [
                        SizedBox(width: 220, child: _hierarchy(context)),
                        const VerticalDivider(width: 1),
                        Expanded(child: canvas),
                        const VerticalDivider(width: 1),
                        SizedBox(width: 310, child: inspector),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(child: canvas),
                        SizedBox(height: 255, child: inspector),
                      ],
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _toolbar(BuildContext context, _SceneItem? selected) {
    return Material(
      color: const Color(0xFF10192B),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            FilledButton.icon(
              onPressed: _busy ? null : _import,
              icon: const Icon(Icons.add_box_outlined),
              label: const Text('Import model'),
            ),
            const SizedBox(width: 10),
            SegmentedButton<_TransformMode>(
              segments: const [
                ButtonSegment(
                  value: _TransformMode.move,
                  icon: Icon(Icons.open_with),
                  label: Text('Move'),
                ),
                ButtonSegment(
                  value: _TransformMode.rotate,
                  icon: Icon(Icons.threed_rotation),
                  label: Text('Rotate'),
                ),
                ButtonSegment(
                  value: _TransformMode.scale,
                  icon: Icon(Icons.zoom_out_map),
                  label: Text('Scale'),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (value) =>
                  setState(() => _mode = value.first),
            ),
            IconButton(
              onPressed: _undo.isEmpty ? null : _undoChange,
              tooltip: 'Undo',
              icon: const Icon(Icons.undo),
            ),
            IconButton(
              onPressed: _redo.isEmpty ? null : _redoChange,
              tooltip: 'Redo',
              icon: const Icon(Icons.redo),
            ),
            IconButton(
              onPressed: selected == null ? null : _reset,
              tooltip: 'Reset transform',
              icon: const Icon(Icons.restart_alt),
            ),
            IconButton(
              onPressed: selected == null ? null : _duplicate,
              tooltip: 'Duplicate',
              icon: const Icon(Icons.copy),
            ),
            IconButton(
              onPressed: selected == null ? null : _delete,
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
            ),
            FilterChip(
              selected: _snap,
              onSelected: (value) => setState(() => _snap = value),
              avatar: const Icon(Icons.grid_4x4, size: 17),
              label: const Text('Snap'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: _items.isEmpty ? null : _saveScene,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save scene'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: _busy ? null : _openScene,
              icon: const Icon(Icons.folder_open),
              label: const Text('Open scene'),
            ),
            IconButton(
              onPressed: () => setState(() {
                _cameraZoom = 1;
                _cameraPan = Offset.zero;
              }),
              tooltip: 'Reset camera zoom and pan',
              icon: const Icon(Icons.center_focus_strong),
            ),
            const SizedBox(width: 8),
            _ImmersiveButton(
              label: 'AR',
              icon: Icons.view_in_ar,
              available: _capability?.arAvailable == true,
              onPressed: () => _enterImmersive(ar: true),
            ),
            const SizedBox(width: 6),
            _ImmersiveButton(
              label: 'VR',
              icon: Icons.vrpano,
              available: _capability?.vrAvailable == true,
              onPressed: () => _enterImmersive(ar: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hierarchy(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(14),
          child: Text(
            'COMPONENTS',
            style: TextStyle(color: Colors.white54, letterSpacing: 1.2),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (final item in _items)
                ListTile(
                  selected: item.id == _selectedId,
                  leading: const Icon(Icons.widgets_outlined),
                  title: Text(
                    item.mesh.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${item.mesh.format} · ${item.mesh.triangles.length} faces',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: item.visible
                            ? 'Hide component'
                            : 'Show component',
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          _snapshot();
                          _replaceItem(item.copyWith(visible: !item.visible));
                        },
                        icon: Icon(
                          item.visible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 17,
                        ),
                      ),
                      if (item.locked) const Icon(Icons.lock, size: 17),
                    ],
                  ),
                  onTap: () => setState(() => _selectedId = item.id),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _canvas(BuildContext context, _SceneItem? selected) {
    return Container(
      color: const Color(0xFF070C16),
      child: Stack(
        children: [
          Positioned.fill(
            child: KeyboardListener(
              focusNode: _canvasFocus,
              onKeyEvent: _handleKey,
              child: Listener(
                onPointerDown: (_) => _canvasFocus.requestFocus(),
                onPointerSignal: (event) {
                  if (event is PointerScrollEvent) {
                    setState(() {
                      _cameraZoom =
                          (_cameraZoom * (event.scrollDelta.dy > 0 ? 0.9 : 1.1))
                              .clamp(0.1, 12);
                    });
                  }
                },
                child: GestureDetector(
                  onScaleStart: (details) {
                    _gestureZoomStart = _cameraZoom;
                    if (selected != null && !_isModeLocked(selected)) {
                      _snapshot();
                    }
                  },
                  onScaleUpdate: (details) {
                    if (details.pointerCount > 1) {
                      setState(() {
                        _cameraZoom = (_gestureZoomStart * details.scale).clamp(
                          0.1,
                          12,
                        );
                        _cameraPan += details.focalPointDelta;
                      });
                      return;
                    }
                    if (selected == null) {
                      setState(() => _cameraPan += details.focalPointDelta);
                      return;
                    }
                    if (_isModeLocked(selected)) return;
                    final transform = selected.transform;
                    if (_mode == _TransformMode.rotate) {
                      _replaceSelected(
                        transform.copyWith(
                          rotationX:
                              transform.rotationX + details.focalPointDelta.dy,
                          rotationY:
                              transform.rotationY + details.focalPointDelta.dx,
                        ),
                        record: false,
                      );
                    } else if (_mode == _TransformMode.move) {
                      _replaceSelected(
                        transform.copyWith(
                          positionX:
                              transform.positionX +
                              details.focalPointDelta.dx / 4,
                          positionY:
                              transform.positionY -
                              details.focalPointDelta.dy / 4,
                        ),
                        record: false,
                      );
                    } else if (_mode == _TransformMode.scale) {
                      final delta = details.focalPointDelta.dx / 200;
                      _applyUniformScale(
                        (transform.scaleX + delta).clamp(0.01, 100),
                        record: false,
                      );
                    }
                  },
                  child: CustomPaint(
                    painter: _MeshPainter(
                      items: _items,
                      selectedId: _selectedId,
                      view: _view,
                      cameraZoom: _cameraZoom,
                      cameraPan: _cameraPan,
                      mode: _mode,
                    ),
                    child: _items.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.view_in_ar_outlined,
                                  size: 72,
                                  color: Colors.white24,
                                ),
                                SizedBox(height: 14),
                                Text(
                                  'Import STL, OBJ, 3MF, GLTF, GLB or STEP',
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ],
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: DropdownButton<_ViewPreset>(
              value: _view,
              items: [
                for (final value in _ViewPreset.values)
                  DropdownMenuItem(
                    value: value,
                    child: Text(value.name.toUpperCase()),
                  ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _view = value);
              },
            ),
          ),
          if (selected != null && !_isModeLocked(selected))
            Center(
              child: _GizmoControls(
                mode: _mode,
                onStart: _snapshot,
                onDelta: _dragGizmoAxis,
              ),
            ),
          if (_busy) const Center(child: CircularProgressIndicator()),
          if (_message != null)
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Material(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(_message!),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _inspector(BuildContext context, _SceneItem? item) {
    if (item == null) return const Center(child: Text('Select a component'));
    final transform = item.transform;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                item.mesh.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              onPressed: () {
                _snapshot();
                final lock = !item.locked;
                _replaceItem(
                  item.copyWith(
                    lockPosition: lock,
                    lockRotation: lock,
                    lockScale: lock,
                  ),
                );
              },
              icon: Icon(item.locked ? Icons.lock : Icons.lock_open),
              tooltip: item.locked ? 'Unlock object' : 'Lock object',
            ),
          ],
        ),
        Text(
          '${item.mesh.format} · ${item.mesh.vertices.length} vertices · ${item.mesh.triangles.length} faces',
          style: const TextStyle(color: Colors.white60),
        ),
        Builder(
          builder: (context) {
            final dimensions = item.mesh.dimensionsMillimeters;
            return Text(
              'Dimensions: ${(dimensions.x * transform.scaleX).abs().toStringAsFixed(2)} × ${(dimensions.y * transform.scaleY).abs().toStringAsFixed(2)} × ${(dimensions.z * transform.scaleZ).abs().toStringAsFixed(2)} mm',
              style: const TextStyle(color: Color(0xFF27D3C2)),
            );
          },
        ),
        if (item.mesh.notice != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              item.mesh.notice!,
              style: const TextStyle(color: Colors.amber),
            ),
          ),
        const Divider(height: 28),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            FilterChip(
              selected: item.lockPosition,
              onSelected: (value) {
                _snapshot();
                _replaceItem(item.copyWith(lockPosition: value));
              },
              label: const Text('Lock position'),
            ),
            FilterChip(
              selected: item.lockRotation,
              onSelected: (value) {
                _snapshot();
                _replaceItem(item.copyWith(lockRotation: value));
              },
              label: const Text('Lock rotation'),
            ),
            FilterChip(
              selected: item.lockScale,
              onSelected: (value) {
                _snapshot();
                _replaceItem(item.copyWith(lockScale: value));
              },
              label: const Text('Lock scale'),
            ),
          ],
        ),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          value: item.uniformScale,
          title: const Text('Uniform scale / preserve proportions'),
          onChanged: item.lockScale
              ? null
              : (value) {
                  _snapshot();
                  _replaceItem(item.copyWith(uniformScale: value));
                },
        ),
        _section(
          'POSITION (mm)',
          [transform.positionX, transform.positionY, transform.positionZ],
          -100,
          100,
          (axis, value) {
            _applyAxis(axis, value, _TransformMode.move);
          },
          item.lockPosition,
        ),
        _section(
          'ROTATION (deg)',
          [transform.rotationX, transform.rotationY, transform.rotationZ],
          -180,
          180,
          (axis, value) {
            _applyAxis(axis, value, _TransformMode.rotate);
          },
          item.lockRotation,
        ),
        _section(
          'SCALE',
          [transform.scaleX, transform.scaleY, transform.scaleZ],
          0.1,
          3,
          (axis, value) {
            if (item.uniformScale) {
              _applyUniformScale(value, record: false);
            } else {
              _applyAxis(axis, value, _TransformMode.scale);
            }
          },
          item.lockScale,
        ),
      ],
    );
  }

  Widget _section(
    String title,
    List<double> values,
    double minimum,
    double maximum,
    void Function(int axis, double value) onChanged,
    bool locked,
  ) {
    const labels = ['X', 'Y', 'Z'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        for (var axis = 0; axis < 3; axis++)
          Row(
            children: [
              SizedBox(width: 18, child: Text(labels[axis])),
              Expanded(
                child: Slider(
                  value: values[axis].clamp(minimum, maximum),
                  min: minimum,
                  max: maximum,
                  onChangeStart: locked ? null : (_) => _snapshot(),
                  onChanged: locked ? null : (value) => onChanged(axis, value),
                ),
              ),
              SizedBox(
                width: 52,
                child: Text(
                  values[axis].toStringAsFixed(1),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Future<void> _import() async {
    const group = XTypeGroup(
      label: '3D models',
      extensions: ['stl', 'obj', '3mf', 'gltf', 'glb', 'step', 'stp'],
    );
    final selected = await openFile(acceptedTypeGroups: [group]);
    if (selected == null) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final mesh = await _importer.importFile(File(selected.path));
      if (!mounted) return;
      _snapshot();
      final id = '${DateTime.now().microsecondsSinceEpoch}';
      setState(() {
        _items.add(
          _SceneItem(
            id: id,
            mesh: mesh,
            transform: const ObjectTransform(),
            sourcePath: selected.path,
          ),
        );
        _selectedId = id;
        _message = mesh.notice;
      });
    } catch (error) {
      if (mounted) setState(() => _message = error.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _applyAxis(int axis, double raw, _TransformMode mode) {
    final item = _selected;
    if (item == null || _isModeLocked(item)) return;
    final step = mode == _TransformMode.rotate
        ? 5.0
        : mode == _TransformMode.scale
        ? 0.1
        : 1.0;
    final value = _snap ? (raw / step).round() * step : raw;
    final t = item.transform;
    final next = switch (mode) {
      _TransformMode.move => t.copyWith(
        positionX: axis == 0 ? value : null,
        positionY: axis == 1 ? value : null,
        positionZ: axis == 2 ? value : null,
      ),
      _TransformMode.rotate => t.copyWith(
        rotationX: axis == 0 ? value : null,
        rotationY: axis == 1 ? value : null,
        rotationZ: axis == 2 ? value : null,
      ),
      _TransformMode.scale => t.copyWith(
        scaleX: axis == 0 ? value : null,
        scaleY: axis == 1 ? value : null,
        scaleZ: axis == 2 ? value : null,
      ),
    };
    _replaceSelected(next, record: false);
  }

  bool _isModeLocked(_SceneItem item) => switch (_mode) {
    _TransformMode.move => item.lockPosition,
    _TransformMode.rotate => item.lockRotation,
    _TransformMode.scale => item.lockScale,
  };

  void _applyUniformScale(double raw, {required bool record}) {
    final item = _selected;
    if (item == null || item.lockScale) return;
    final value = _snap ? (raw / 0.1).round() * 0.1 : raw;
    _replaceSelected(
      item.transform.copyWith(scaleX: value, scaleY: value, scaleZ: value),
      record: record,
    );
  }

  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final item = _selected;
    if (item == null || item.lockPosition) return;
    final step = _snap ? 1.0 : 0.1;
    final transform = item.transform;
    ObjectTransform? next;
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      next = transform.copyWith(positionX: transform.positionX - step);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      next = transform.copyWith(positionX: transform.positionX + step);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      next = transform.copyWith(positionY: transform.positionY + step);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      next = transform.copyWith(positionY: transform.positionY - step);
    } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
      next = transform.copyWith(positionZ: transform.positionZ + step);
    } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
      next = transform.copyWith(positionZ: transform.positionZ - step);
    }
    if (next != null) _replaceSelected(next, record: true);
  }

  void _dragGizmoAxis(int axis, double delta) {
    final item = _selected;
    if (item == null || _isModeLocked(item)) return;
    final transform = item.transform;
    if (_mode == _TransformMode.move) {
      final values = [
        transform.positionX,
        transform.positionY,
        transform.positionZ,
      ];
      _applyAxis(axis, values[axis] + delta / 2, _TransformMode.move);
    } else if (_mode == _TransformMode.rotate) {
      final values = [
        transform.rotationX,
        transform.rotationY,
        transform.rotationZ,
      ];
      _applyAxis(axis, values[axis] + delta, _TransformMode.rotate);
    } else if (item.uniformScale) {
      _applyUniformScale(
        (transform.scaleX + delta / 100).clamp(0.01, 100),
        record: false,
      );
    } else {
      final values = [transform.scaleX, transform.scaleY, transform.scaleZ];
      _applyAxis(
        axis,
        (values[axis] + delta / 100).clamp(0.01, 100),
        _TransformMode.scale,
      );
    }
  }

  void _replaceSelected(ObjectTransform transform, {required bool record}) {
    final item = _selected;
    if (item == null) return;
    if (record) _snapshot();
    _replaceItem(item.copyWith(transform: transform));
  }

  void _replaceItem(_SceneItem next) {
    final index = _items.indexWhere((item) => item.id == next.id);
    if (index >= 0) setState(() => _items[index] = next);
  }

  void _snapshot() {
    _undo.add(List<_SceneItem>.from(_items));
    if (_undo.length > 100) _undo.removeAt(0);
    _redo.clear();
  }

  void _undoChange() {
    if (_undo.isEmpty) return;
    _redo.add(List<_SceneItem>.from(_items));
    setState(() {
      _items
        ..clear()
        ..addAll(_undo.removeLast());
      if (_items.every((item) => item.id != _selectedId)) {
        _selectedId = _items.isEmpty ? null : _items.last.id;
      }
    });
  }

  void _redoChange() {
    if (_redo.isEmpty) return;
    _undo.add(List<_SceneItem>.from(_items));
    setState(() {
      _items
        ..clear()
        ..addAll(_redo.removeLast());
    });
  }

  void _reset() => _replaceSelected(const ObjectTransform(), record: true);

  void _duplicate() {
    final item = _selected;
    if (item == null) return;
    _snapshot();
    final id = '${DateTime.now().microsecondsSinceEpoch}';
    setState(() {
      _items.add(
        _SceneItem(
          id: id,
          mesh: item.mesh,
          transform: item.transform.copyWith(
            positionX: item.transform.positionX + 10,
          ),
          visible: item.visible,
          lockPosition: item.lockPosition,
          lockRotation: item.lockRotation,
          lockScale: item.lockScale,
          uniformScale: item.uniformScale,
          sourcePath: item.sourcePath,
        ),
      );
      _selectedId = id;
    });
  }

  void _delete() {
    final item = _selected;
    if (item == null) return;
    _snapshot();
    setState(() {
      _items.removeWhere((value) => value.id == item.id);
      _selectedId = _items.isEmpty ? null : _items.last.id;
    });
  }

  Future<void> _saveScene() async {
    final location = await getSaveLocation(
      suggestedName: 'filarithm_scene.json',
    );
    if (location == null) return;
    final data = {
      'schemaVersion': 1,
      'savedAt': DateTime.now().toUtc().toIso8601String(),
      'objects': [
        for (final item in _items)
          {
            'id': item.id,
            'name': item.mesh.name,
            'format': item.mesh.format,
            'sourcePath': item.sourcePath,
            'visible': item.visible,
            'lockPosition': item.lockPosition,
            'lockRotation': item.lockRotation,
            'lockScale': item.lockScale,
            'uniformScale': item.uniformScale,
            'transform': item.transform.toJson(),
          },
      ],
    };
    await File(location.path)
        .writeAsString(const JsonEncoder.withIndent('  ').convert(data));
    if (mounted) setState(() => _message = 'Scene saved to ${location.path}');
  }

  Future<void> _openScene() async {
    const group = XTypeGroup(label: 'Filarithm scene', extensions: ['json']);
    final selected = await openFile(acceptedTypeGroups: [group]);
    if (selected == null) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final root = jsonDecode(await File(selected.path).readAsString());
      if (root is! Map<String, dynamic> || root['schemaVersion'] != 1) {
        throw const FormatException('Unsupported Filarithm scene file.');
      }
      final rows = (root['objects'] as List<dynamic>? ?? const []);
      final loaded = <_SceneItem>[];
      for (final raw in rows) {
        final row = (raw as Map).cast<String, dynamic>();
        final sourcePath = row['sourcePath'] as String?;
        if (sourcePath == null || !await File(sourcePath).exists()) {
          throw FormatException(
            'Model source is missing: ${sourcePath ?? row['name']}',
          );
        }
        final mesh = await _importer.importFile(File(sourcePath));
        loaded.add(
          _SceneItem(
            id:
                row['id'] as String? ??
                '${DateTime.now().microsecondsSinceEpoch}-${loaded.length}',
            mesh: mesh,
            transform: ObjectTransform.fromJson(
              (row['transform'] as Map).cast<String, dynamic>(),
            ),
            visible: row['visible'] as bool? ?? true,
            lockPosition:
                row['lockPosition'] as bool? ?? row['locked'] as bool? ?? false,
            lockRotation:
                row['lockRotation'] as bool? ?? row['locked'] as bool? ?? false,
            lockScale:
                row['lockScale'] as bool? ?? row['locked'] as bool? ?? false,
            uniformScale: row['uniformScale'] as bool? ?? true,
            sourcePath: sourcePath,
          ),
        );
      }
      if (!mounted) return;
      _snapshot();
      setState(() {
        _items
          ..clear()
          ..addAll(loaded);
        _selectedId = loaded.isEmpty ? null : loaded.first.id;
        _message = 'Scene reopened with ${loaded.length} component(s).';
      });
    } catch (error) {
      if (mounted) setState(() => _message = 'Could not open scene: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _loadCapability() async {
    final capability = await _immersive.capability();
    if (mounted) setState(() => _capability = capability);
  }

  Future<void> _enterImmersive({required bool ar}) async {
    final selected = _selected;
    if (selected == null) {
      setState(() => _message = 'Select a model before opening AR or VR.');
      return;
    }
    final available = ar
        ? _capability?.arAvailable == true
        : _capability?.vrAvailable == true;
    if (!available) {
      setState(
        () => _message =
            _capability?.message ??
            '${ar ? 'AR' : 'VR'} is not supported on this device.',
      );
      return;
    }
    try {
      final updatedTransform = await Navigator.of(context)
          .push<ObjectTransform>(
            MaterialPageRoute<ObjectTransform>(
              builder: (_) => ar
                  ? ArViewerPage(
                      mesh: selected.mesh,
                      transform: selected.transform,
                    )
                  : VrViewerPage(
                      mesh: selected.mesh,
                      transform: selected.transform,
                    ),
            ),
          );
      if (!ar && updatedTransform != null && mounted) {
        _snapshot();
        _replaceItem(selected.copyWith(transform: updatedTransform));
        setState(() {
          _message =
              'VR movement, rotation, and scale were applied to the scene.';
        });
      }
    } catch (error) {
      if (mounted) setState(() => _message = error.toString());
    }
  }
}

class _ImmersiveButton extends StatelessWidget {
  const _ImmersiveButton({
    required this.label,
    required this.icon,
    required this.available,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool available;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    label: Text('$label ${available ? 'READY' : 'UNAVAILABLE'}'),
  );
}

class _GizmoControls extends StatelessWidget {
  const _GizmoControls({
    required this.mode,
    required this.onStart,
    required this.onDelta,
  });

  final _TransformMode mode;
  final VoidCallback onStart;
  final void Function(int axis, double delta) onDelta;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 138,
    height: 138,
    child: Stack(
      children: [
        _handle(0, const Color(0xFFFF5B5B), 68, 110, horizontal: true),
        _handle(1, const Color(0xFF55DD77), 12, 62),
        _handle(2, const Color(0xFF55A8FF), 92, 92, horizontal: true),
        const Positioned(
          left: 62,
          top: 62,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SizedBox(width: 12, height: 12),
          ),
        ),
      ],
    ),
  );

  Widget _handle(
    int axis,
    Color color,
    double top,
    double left, {
    bool horizontal = false,
  }) => Positioned(
    top: top,
    left: left,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (_) => onStart(),
      onPanUpdate: (details) =>
          onDelta(axis, horizontal ? details.delta.dx : -details.delta.dy),
      child: Container(
        width: horizontal ? 28 : 16,
        height: horizontal ? 16 : 28,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black54),
        ),
        alignment: Alignment.center,
        child: Text(
          '${mode == _TransformMode.rotate ? 'R' : ''}${['X', 'Y', 'Z'][axis]}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

class _MeshPainter extends CustomPainter {
  const _MeshPainter({
    required this.items,
    required this.selectedId,
    required this.view,
    required this.cameraZoom,
    required this.cameraPan,
    required this.mode,
  });

  final List<_SceneItem> items;
  final String? selectedId;
  final _ViewPreset view;
  final double cameraZoom;
  final Offset cameraPan;
  final _TransformMode mode;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = const Color(0x1827D3C2)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (var y = 0.0; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (final item in items) {
      if (!item.visible) continue;
      _paintItem(canvas, size, item, item.id == selectedId);
    }
  }

  void _paintItem(Canvas canvas, Size size, _SceneItem item, bool selected) {
    final mesh = item.mesh;
    final t = item.transform;
    final matrix = Matrix4.identity()
      ..rotateX(t.rotationX * math.pi / 180)
      ..rotateY(t.rotationY * math.pi / 180)
      ..rotateZ(t.rotationZ * math.pi / 180)
      ..scaleByVector3(Vector3(t.scaleX, t.scaleY, t.scaleZ));
    final viewMatrix = switch (view) {
      _ViewPreset.isometric =>
        (Matrix4.identity()
          ..rotateX(-30 * math.pi / 180)
          ..rotateY(45 * math.pi / 180)),
      _ViewPreset.front => Matrix4.identity(),
      _ViewPreset.back => (Matrix4.identity()..rotateY(math.pi)),
      _ViewPreset.left => (Matrix4.identity()..rotateY(-math.pi / 2)),
      _ViewPreset.top => (Matrix4.identity()..rotateX(-math.pi / 2)),
      _ViewPreset.right => (Matrix4.identity()..rotateY(math.pi / 2)),
      _ViewPreset.bottom => (Matrix4.identity()..rotateX(math.pi / 2)),
    };
    final center = mesh.center;
    final factor =
        math.min(size.width, size.height) * 0.65 / mesh.diagonal * cameraZoom;
    Offset project(Vector3 source) {
      final local = Vector3.copy(source)..sub(center);
      matrix.transform3(local);
      local
        ..x += t.positionX
        ..y += t.positionY
        ..z += t.positionZ;
      viewMatrix.transform3(local);
      return Offset(
        size.width / 2 + cameraPan.dx + local.x * factor,
        size.height / 2 + cameraPan.dy - local.y * factor,
      );
    }

    final line = Paint()
      ..color = selected ? const Color(0xFF27D3C2) : const Color(0xA8FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = selected ? 1.35 : 0.8;
    if (mesh.triangles.isNotEmpty) {
      final stride = math.max(1, (mesh.triangles.length / 2500).ceil());
      for (
        var faceIndex = 0;
        faceIndex < mesh.triangles.length;
        faceIndex += stride
      ) {
        final face = mesh.triangles[faceIndex];
        final path = Path()
          ..moveTo(
            project(mesh.vertices[face[0]]).dx,
            project(mesh.vertices[face[0]]).dy,
          );
        for (final index in face.skip(1)) {
          final point = project(mesh.vertices[index]);
          path.lineTo(point.dx, point.dy);
        }
        path.close();
        canvas.drawPath(path, line);
      }
    } else {
      final pointPaint = Paint()..color = line.color;
      final stride = math.max(1, (mesh.vertices.length / 3000).ceil());
      for (var index = 0; index < mesh.vertices.length; index += stride) {
        canvas.drawCircle(project(mesh.vertices[index]), 1.5, pointPaint);
      }
    }
    if (selected) {
      final origin = project(mesh.center);
      if (mode == _TransformMode.rotate) {
        for (final entry in const [
          (Color(0xFFFF5B5B), 22.0),
          (Color(0xFF55DD77), 29.0),
          (Color(0xFF55A8FF), 36.0),
        ]) {
          canvas.drawCircle(
            origin,
            entry.$2,
            Paint()
              ..color = entry.$1
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2,
          );
        }
      } else {
        final axes = [
          (const Offset(46, 0), const Color(0xFFFF5B5B)),
          (const Offset(0, -46), const Color(0xFF55DD77)),
          (const Offset(32, 32), const Color(0xFF55A8FF)),
        ];
        for (final axis in axes) {
          final paint = Paint()
            ..color = axis.$2
            ..strokeWidth = 3;
          canvas.drawLine(origin, origin + axis.$1, paint);
          canvas.drawCircle(origin + axis.$1, 5, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) => true;
}
