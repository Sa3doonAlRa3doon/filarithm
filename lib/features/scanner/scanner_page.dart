import 'dart:io';

import 'package:camera/camera.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pasteboard/pasteboard.dart';

import '../../core/ocr/ocr_post_processor.dart';
import '../../core/ocr/offline_ocr_service.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final _service = const OfflineOcrService();
  final _postProcessor = const OcrPostProcessor();
  CameraController? _camera;
  OcrEstimate? _estimate;
  bool _busy = false;
  bool _confirmed = false;
  String? _error;
  int _rotationDegrees = 0;
  double _cropPercent = 0;
  double _perspectiveInset = 0;
  double _contrast = 1.25;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) _initializeCamera();
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Offline slicer scanner',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          '${_service.engineName} · images stay on this device',
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 22),
        if (Platform.isAndroid && _camera?.value.isInitialized == true)
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AspectRatio(
              aspectRatio: _camera!.value.aspectRatio,
              child: CameraPreview(_camera!),
            ),
          )
        else
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFF151F33),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white12),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image_search, size: 52, color: Colors.white38),
                  SizedBox(height: 12),
                  Text('Choose a slicer screenshot or image'),
                ],
              ),
            ),
          ),
        const SizedBox(height: 16),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: const Text('Image correction'),
          subtitle: const Text(
            'Crop, rotate, perspective, scale, grayscale and contrast run offline',
          ),
          children: [
            DropdownButtonFormField<int>(
              initialValue: _rotationDegrees,
              decoration: const InputDecoration(labelText: 'Rotation'),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Automatic / 0°')),
                DropdownMenuItem(value: 90, child: Text('90°')),
                DropdownMenuItem(value: 180, child: Text('180°')),
                DropdownMenuItem(value: 270, child: Text('270°')),
              ],
              onChanged: (value) =>
                  setState(() => _rotationDegrees = value ?? _rotationDegrees),
            ),
            _correctionSlider(
              'Crop each edge',
              _cropPercent,
              0,
              0.25,
              (value) => setState(() => _cropPercent = value),
              '${(_cropPercent * 100).round()}%',
            ),
            _correctionSlider(
              'Perspective top inset',
              _perspectiveInset,
              -0.25,
              0.25,
              (value) => setState(() => _perspectiveInset = value),
              '${(_perspectiveInset * 100).round()}%',
            ),
            _correctionSlider(
              'Contrast',
              _contrast,
              0.8,
              2,
              (value) => setState(() => _contrast = value),
              _contrast.toStringAsFixed(2),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (Platform.isAndroid && _camera?.value.isInitialized == true)
              FilledButton.icon(
                onPressed: _busy ? null : _capture,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture result'),
              ),
            OutlinedButton.icon(
              onPressed: _busy ? null : _chooseImage,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Choose image'),
            ),
            if (Platform.isLinux)
              OutlinedButton.icon(
                onPressed: _busy ? null : _pasteImage,
                icon: const Icon(Icons.content_paste),
                label: const Text('Paste clipboard image'),
              ),
            if (_busy) const CircularProgressIndicator(),
          ],
        ),
        if (_error != null) ...[
          const SizedBox(height: 16),
          Text(_error!, style: const TextStyle(color: Colors.redAccent)),
        ],
        if (_estimate != null) ...[
          const SizedBox(height: 24),
          _ResultCard(
            key: ValueKey(_estimate),
            estimate: _estimate!,
            confirmed: _confirmed,
            onConfirmed: () {
              setState(() => _confirmed = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OCR values confirmed and ready for pricing.'),
                ),
              );
            },
          ),
        ],
      ],
    );
    if (!Platform.isLinux) return content;
    return DropTarget(
      onDragDone: (detail) async {
        if (detail.files.isNotEmpty) await _process(detail.files.first.path);
      },
      child: content,
    );
  }

  Future<void> _initializeCamera() async {
    try {
      final devices = await availableCameras();
      if (devices.isEmpty) return;
      final controller = CameraController(
        devices.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() => _camera = controller);
    } catch (error) {
      if (mounted) setState(() => _error = 'Camera unavailable: $error');
    }
  }

  Future<void> _capture() async {
    final camera = _camera;
    if (camera == null) return;
    final image = await camera.takePicture();
    try {
      await _process(image.path);
    } finally {
      final temporary = File(image.path);
      if (await temporary.exists()) await temporary.delete();
    }
  }

  Future<void> _chooseImage() async {
    const images = XTypeGroup(
      label: 'Images',
      extensions: ['png', 'jpg', 'jpeg', 'webp', 'bmp'],
    );
    final file = await openFile(acceptedTypeGroups: [images]);
    if (file != null) await _process(file.path);
  }

  Future<void> _pasteImage() async {
    final bytes = await Pasteboard.image;
    if (bytes == null || bytes.isEmpty) {
      if (mounted) {
        setState(() => _error = 'The clipboard does not contain an image.');
      }
      return;
    }
    final temporary = File(
      '${Directory.systemTemp.path}${Platform.pathSeparator}filarithm_clipboard_${DateTime.now().microsecondsSinceEpoch}.png',
    );
    await temporary.writeAsBytes(bytes, flush: true);
    try {
      await _process(temporary.path);
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }

  Future<void> _process(String path) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final result = await _service.recognizeDetailed(
        path,
        options: OcrPreprocessOptions(
          rotationDegrees: _rotationDegrees.toDouble(),
          cropLeft: _cropPercent,
          cropTop: _cropPercent,
          cropRight: _cropPercent,
          cropBottom: _cropPercent,
          perspectiveTopInset: _perspectiveInset,
          contrast: _contrast,
        ),
      );
      if (!mounted) return;
      setState(() {
        _estimate = _postProcessor.parse(
          result.text,
          sampledHexColors: result.sampledHexColors,
        );
        _confirmed = false;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _correctionSlider(
    String label,
    double value,
    double minimum,
    double maximum,
    ValueChanged<double> onChanged,
    String valueLabel,
  ) {
    return Row(
      children: [
        SizedBox(width: 150, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: minimum,
            max: maximum,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 52, child: Text(valueLabel)),
      ],
    );
  }
}

class _ResultCard extends StatefulWidget {
  const _ResultCard({
    required this.estimate,
    required this.confirmed,
    required this.onConfirmed,
    super.key,
  });

  final OcrEstimate estimate;
  final bool confirmed;
  final VoidCallback onConfirmed;

  @override
  State<_ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<_ResultCard> {
  late final TextEditingController _duration;
  late final List<TextEditingController> _weights;
  late final List<TextEditingController> _colors;
  String? _validation;

  @override
  void initState() {
    super.initState();
    final seconds = widget.estimate.durationSeconds;
    _duration = TextEditingController(
      text: seconds == null
          ? ''
          : '${(seconds ~/ 3600).toString().padLeft(2, '0')}:${((seconds % 3600) ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',
    );
    _weights = [
      for (final weight in widget.estimate.weightsMg)
        TextEditingController(text: (weight / 1000).toStringAsFixed(2)),
    ];
    _colors = [
      for (var index = 0; index < _weights.length; index++)
        TextEditingController(
          text: index < widget.estimate.materials.length
              ? widget.estimate.materials[index].colorHex ??
                    widget.estimate.materials[index].colorName ??
                    ''
              : '',
        ),
    ];
  }

  @override
  void dispose() {
    _duration.dispose();
    for (final controller in [..._weights, ..._colors]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Confirm detected values',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Chip(
                  avatar: Icon(
                    widget.confirmed
                        ? Icons.verified_outlined
                        : Icons.warning_amber,
                    size: 17,
                  ),
                  label: Text(
                    widget.confirmed ? 'Confirmed' : 'Confirmation required',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _duration,
              decoration: const InputDecoration(
                labelText: 'Confirmed print time',
                hintText: 'HH:MM:SS',
              ),
            ),
            const SizedBox(height: 12),
            for (var index = 0; index < _weights.length; index++) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _weights[index],
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Tool ${index + 1} filament',
                        suffixText: 'g',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _colors[index],
                      decoration: const InputDecoration(
                        labelText: 'Color / hex (required)',
                        hintText: 'Black or #101010',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
            if (_weights.isEmpty)
              const Text(
                'No filament weight was recognized. Scan again or use manual entry.',
                style: TextStyle(color: Colors.redAccent),
              ),
            if (widget.estimate.sampledHexColors.isNotEmpty)
              Text(
                'Sampled swatches: ${widget.estimate.sampledHexColors.join(', ')}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            if (_validation != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _validation!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: widget.confirmed ? null : _confirm,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirm time, grams and colors'),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: const Text('Recognized text'),
              children: [
                SelectableText(
                  widget.estimate.rawText,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirm() {
    final validClock = RegExp(r'^\d{1,3}:\d{2}:\d{2}$')
        .hasMatch(_duration.text.trim());
    if (!validClock || _weights.isEmpty) {
      setState(
        () => _validation = 'Enter a valid time and at least one weight.',
      );
      return;
    }
    for (var index = 0; index < _weights.length; index++) {
      final weight = double.tryParse(_weights[index].text.trim());
      if (weight == null || weight < 0 || _colors[index].text.trim().isEmpty) {
        setState(
          () => _validation =
              'Tool ${index + 1} needs a valid weight and a confirmed color.',
        );
        return;
      }
    }
    setState(() => _validation = null);
    widget.onConfirmed();
  }
}
