import 'dart:async';
import 'dart:io';

import 'package:flutter_sceneview/flutter_sceneview.dart';
import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/viewer/glb_exporter.dart';
import '../../core/viewer/mesh_model.dart';

class ArViewerPage extends StatefulWidget {
  const ArViewerPage({required this.mesh, required this.transform, super.key});

  final MeshModel mesh;
  final ObjectTransform transform;

  @override
  State<ArViewerPage> createState() => _ArViewerPageState();
}

class _ArViewerPageState extends State<ArViewerPage> {
  final _controller = SceneViewController();
  final _sizeMillimeters = TextEditingController();
  HttpServer? _server;
  StreamSubscription<HttpRequest>? _serverSubscription;
  String? _modelUrl;
  String? _message;
  String? _plane;
  PlacedModel? _placed;
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    final dimensions = widget.mesh.dimensionsMillimeters;
    final scale = widget.transform.scaleX.abs();
    final largest = [
      dimensions.x * scale,
      dimensions.y * scale,
      dimensions.z * scale,
    ].reduce((left, right) => left > right ? left : right);
    _sizeMillimeters.text = largest.toStringAsFixed(2);
    _prepare();
  }

  @override
  void dispose() {
    _sizeMillimeters.dispose();
    _controller.dispose();
    _serverSubscription?.cancel();
    _server?.close(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelUrl = _modelUrl;
    return Scaffold(
      appBar: AppBar(title: const Text('Real-world AR placement')),
      body: modelUrl == null
          ? Center(
              child: _message == null
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(_message!),
                    ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: ARSceneView(
                    controller: _controller,
                    planeDetection: true,
                    onPlaneDetected: (value) => setState(() => _plane = value),
                    onPlaneTap: _place,
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  top: 12,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _placed == null
                                ? 'Move the phone to detect a floor, desk or wall, then tap it.'
                                : 'Drag to move · twist to rotate · pinch to resize',
                          ),
                          if (_plane != null) Text('Detected: $_plane'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _sizeMillimeters,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  decoration: const InputDecoration(
                                    labelText: 'Largest dimension at placement',
                                    suffixText: 'mm',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              FilterChip(
                                selected: _locked,
                                onSelected: (value) => setState(() {
                                  _locked = value;
                                  _message = value
                                      ? 'Lock applies to the next placement. Reset and tap again to freeze the model.'
                                      : null;
                                }),
                                avatar: Icon(
                                  _locked ? Icons.lock : Icons.lock_open,
                                ),
                                label: const Text('Lock'),
                              ),
                              IconButton(
                                onPressed: _placed == null ? null : _reset,
                                tooltip: 'Remove and reposition',
                                icon: const Icon(Icons.restart_alt),
                              ),
                            ],
                          ),
                          if (_message != null)
                            Text(
                              _message!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _prepare() async {
    final permission = await Permission.camera.request();
    if (!permission.isGranted) {
      if (mounted) {
        setState(() => _message = 'Camera permission is required for AR.');
      }
      return;
    }
    try {
      final bytes = const GlbExporter().export(
        widget.mesh,
        transform: widget.transform,
      );
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      _server = server;
      _serverSubscription = server.listen((request) async {
        if (request.uri.path != '/model.glb') {
          request.response.statusCode = HttpStatus.notFound;
        } else {
          request.response.headers
            ..contentType = ContentType('model', 'gltf-binary')
            ..set(HttpHeaders.contentLengthHeader, bytes.length)
            ..set(HttpHeaders.accessControlAllowOriginHeader, '*');
          request.response.add(bytes);
        }
        await request.response.close();
      });
      if (mounted) {
        setState(() {
          _modelUrl = 'http://127.0.0.1:${server.port}/model.glb';
          _message = null;
        });
      }
    } catch (error) {
      if (mounted) setState(() => _message = 'AR preparation failed: $error');
    }
  }

  Future<void> _place(ARHitResult hit) async {
    final url = _modelUrl;
    if (url == null) return;
    final millimeters = double.tryParse(_sizeMillimeters.text.trim());
    if (millimeters == null || millimeters <= 0) {
      setState(() => _message = 'Enter a positive millimetre size.');
      return;
    }
    try {
      if (_placed != null) await _controller.removePlacedModel(_placed!);
      final placed = await _controller.placeModel(
        hit,
        ModelNode(modelPath: url, scale: millimeters / 1000),
        editable: !_locked,
        draggable: !_locked,
        rotatable: !_locked,
        scalable: !_locked,
      );
      if (mounted) {
        setState(() {
          _placed = placed;
          _message = _locked
              ? 'Placed and locked at real-world scale.'
              : 'Placed. Use gestures or reset to reposition.';
        });
      }
    } catch (error) {
      if (mounted) setState(() => _message = 'Could not place model: $error');
    }
  }

  Future<void> _reset() async {
    final placed = _placed;
    if (placed != null) await _controller.removePlacedModel(placed);
    if (mounted) {
      setState(() {
        _placed = null;
        _message = 'Tap a detected surface to place the model again.';
      });
    }
  }
}
