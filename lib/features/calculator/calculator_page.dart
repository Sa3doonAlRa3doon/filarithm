import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:file_selector/file_selector.dart';
import 'package:material_ui/material_ui.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart'
    hide MaterialProfile, PrinterProfile;
import '../../core/domain/pricing_models.dart';
import '../../core/domain/print_project.dart';
import '../../core/parser/slicer_parser.dart';
import '../../core/pricing/pricing_engine.dart';
import '../../core/quote/pdf_quote_service.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({required this.database, super.key});

  final AppDatabase database;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _weight = TextEditingController();
  final _hours = TextEditingController();
  final _spoolPrice = TextEditingController();
  final _electricity = TextEditingController();
  final _machineRate = TextEditingController();
  final _laborRate = TextEditingController();
  final _printerWatts = TextEditingController();
  final _failurePercent = TextEditingController();
  final _minimum = TextEditingController();
  final _platformPercent = TextEditingController();
  final _platformFixed = TextEditingController();
  final _taxPercent = TextEditingController(text: '5');
  final _setupMinutes = TextEditingController();
  final _perPlateMinutes = TextEditingController();
  final _perUnitMinutes = TextEditingController();
  final _orderPackaging = TextEditingController();
  final _shipping = TextEditingController();
  final _customerName = TextEditingController();
  final _turnaround = TextEditingController();
  ParsedPrintProject? _imported;
  final Map<String, bool> _plateSelected = {};
  final Map<String, int> _plateRuns = {};
  final Map<String, int> _unitsPerRun = {};
  final Map<int, int> _toolPriceMicros = {};
  final Set<int> _confirmedToolPrices = {};
  PriceBreakdown? _result;
  String? _error;
  var _marginBps = 0;
  var _runs = 1;
  var _minimumEnabled = false;
  var _taxEnabled = false;
  late final String _previewQuoteNumber;
  BusinessProfile? _businessProfile;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _previewQuoteNumber =
        'AVX-${now.year}-DRAFT-${now.millisecondsSinceEpoch.toString().substring(8)}';
    _loadBusinessProfile();
  }

  @override
  void dispose() {
    for (final controller in [
      _weight,
      _hours,
      _spoolPrice,
      _electricity,
      _machineRate,
      _laborRate,
      _printerWatts,
      _failurePercent,
      _minimum,
      _platformPercent,
      _platformFixed,
      _taxPercent,
      _setupMinutes,
      _perPlateMinutes,
      _perUnitMinutes,
      _orderPackaging,
      _shipping,
      _customerName,
      _turnaround,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Price calculator',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        const Text(
          'Import accurate slicer statistics or enter a quick manual estimate. All money and measurements are calculated as integers.',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: _importFile,
              icon: const Icon(Icons.upload_file),
              label: const Text('Import .gcode / .3mf'),
            ),
            OutlinedButton.icon(
              onPressed: () => setState(() {
                _imported = null;
                _calculate();
              }),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Manual entry'),
            ),
          ],
        ),
        if (_imported != null) ...[
          const SizedBox(height: 18),
          _ImportSummary(project: _imported!),
          const SizedBox(height: 12),
          _PlateControls(
            project: _imported!,
            selected: _plateSelected,
            runs: _plateRuns,
            units: _unitsPerRun,
            onChanged: _calculate,
          ),
        ],
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            final inputs = _buildInputs(context);
            final result = _buildResult(context);
            return wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: inputs),
                      const SizedBox(width: 24),
                      SizedBox(width: 390, child: result),
                    ],
                  )
                : Column(
                    children: [inputs, const SizedBox(height: 24), result],
                  );
          },
        ),
      ],
    );
  }

  Widget _buildInputs(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Production inputs',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 18),
            if (_imported == null)
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _field(_weight, 'Total filament', 'g'),
                  _field(_hours, 'Print time', 'hours'),
                ],
              ),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                if (_imported == null)
                  _field(_spoolPrice, 'Spool price', 'AED / kg'),
                _field(_electricity, 'Electricity', 'AED / kWh'),
                _field(_machineRate, 'Machine rate', 'AED / hour'),
                _field(_laborRate, 'Labour rate', 'AED / hour'),
                _field(_printerWatts, 'Printer power', 'W'),
                _field(_failurePercent, 'Failure allowance', '%'),
                _field(_platformPercent, 'Marketplace fee', '%'),
                _field(_platformFixed, 'Fixed platform fee', 'AED'),
                _field(_setupMinutes, 'Setup labour', 'minutes'),
                _field(_perPlateMinutes, 'Labour per plate run', 'minutes'),
                _field(_perUnitMinutes, 'Finishing per unit', 'minutes'),
                _field(_orderPackaging, 'Order packaging', 'AED'),
                _field(_shipping, 'Shipping', 'AED'),
                if (_imported == null)
                  SizedBox(
                    width: 190,
                    child: DropdownButtonFormField<int>(
                      initialValue: _runs,
                      decoration: const InputDecoration(
                        labelText: 'Plate runs',
                      ),
                      items: [1, 2, 3, 4, 5, 10]
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text('$value'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _runs = value ?? 1);
                        _calculate();
                      },
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                _textField(_customerName, 'Customer name'),
                _textField(
                  _turnaround,
                  'Turnaround date or lead time',
                  hint: '2026-12-01 or 3 working days',
                ),
              ],
            ),
            if (_imported != null) ...[
              const SizedBox(height: 16),
              Text(
                'Material prices',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  for (final tool in _toolPriceMicros.keys)
                    SizedBox(
                      width: 190,
                      child: TextFormField(
                        key: ValueKey('tool-price-$tool'),
                        initialValue: _confirmedToolPrices.contains(tool)
                            ? (_toolPriceMicros[tool]! / 1000000)
                                  .toStringAsFixed(2)
                            : '',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Tool ${tool + 1} spool',
                          suffixText: 'AED / kg',
                        ),
                        onChanged: (value) {
                          _toolPriceMicros[tool] = _aed(value);
                          if (value.trim().isEmpty) {
                            _confirmedToolPrices.remove(tool);
                          } else {
                            _confirmedToolPrices.add(tool);
                          }
                          _calculate();
                        },
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _minimumEnabled,
              title: const Text('Minimum order floor'),
              subtitle: const Text('Disabled until you explicitly enable it'),
              onChanged: (value) {
                setState(() => _minimumEnabled = value);
                _calculate();
              },
            ),
            if (_minimumEnabled) _field(_minimum, 'Minimum order', 'AED'),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _taxEnabled,
              title: const Text('Tax / VAT'),
              subtitle: const Text('Disabled by default · UAE preset is 5%'),
              onChanged: (value) {
                setState(() => _taxEnabled = value);
                _calculate();
              },
            ),
            if (_taxEnabled)
              Row(
                children: [
                  _field(_taxPercent, 'Tax rate', '%'),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      _taxPercent.text = '5';
                      _calculate();
                    },
                    child: const Text('Use UAE 5% preset'),
                  ),
                ],
              ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Text('Target net margin'),
                const Spacer(),
                Text(
                  '${(_marginBps / 100).round()}%',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Slider(
              value: _marginBps.toDouble(),
              min: 0,
              max: 7000,
              divisions: 70,
              label: '${(_marginBps / 100).round()}%',
              onChanged: (value) {
                setState(() => _marginBps = value.round());
                _calculate();
              },
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _calculate,
              icon: const Icon(Icons.calculate),
              label: const Text('Recalculate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, String suffix) {
    return SizedBox(
      width: 190,
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label, suffixText: suffix),
        onChanged: (_) => _calculate(),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    String? hint,
  }) {
    return SizedBox(
      width: 260,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, hintText: hint),
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    if (_error != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(_error!, style: const TextStyle(color: Colors.redAccent)),
        ),
      );
    }
    final result = _result;
    if (result == null) return const SizedBox.shrink();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'RECOMMENDED PRICE',
              style: TextStyle(color: Colors.white60, letterSpacing: 1.2),
            ),
            const SizedBox(height: 6),
            Text(
              '${_money(result.finalPriceMicros)} AED',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              _taxEnabled
                  ? 'includes ${_taxPercent.text.trim()}% tax'
                  : 'tax disabled',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(height: 32),
            _row('Material', result.materialMicros),
            _row('Electricity', result.electricityMicros),
            _row('Machine', result.machineMicros),
            _row('Failure allowance', result.failureReserveMicros),
            _row('Labour & extras', result.laborMicros + result.extrasMicros),
            _row('Total cost', result.totalCostMicros, strong: true),
            const Divider(height: 28),
            _row(
              'Net profit',
              result.netProfitMicros,
              strong: true,
              positive: true,
            ),
            Text(
              '${result.finishedUnits} units · ${(result.totalDurationSeconds / 3600).toStringAsFixed(1)} printer-hours',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60),
            ),
            if (result.minimumFloorApplied)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Minimum order floor applied',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _shareQuote,
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('Share PDF / WhatsApp'),
            ),
            if (Platform.isLinux) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _runPdfAction(
                      (service, data) async => service.save(data),
                      'PDF saved.',
                    ),
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('Save PDF'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _runPdfAction(
                      (service, data) => service.open(data),
                      'PDF opened.',
                    ),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _runPdfAction(
                      (service, data) => service.copySummary(data),
                      'Summary copied.',
                    ),
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy summary'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _saveQuote,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save quote & job'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
    String label,
    int micros, {
    bool strong = false,
    bool positive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: strong
                  ? const TextStyle(fontWeight: FontWeight.w700)
                  : null,
            ),
          ),
          Text(
            '${_money(micros)} AED',
            style: TextStyle(
              fontWeight: strong ? FontWeight.w800 : FontWeight.w400,
              color: positive ? const Color(0xFF27D3C2) : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _importFile() async {
    try {
      const group = XTypeGroup(
        label: 'Slicer files',
        extensions: ['gcode', '3mf'],
      );
      final file = await openFile(acceptedTypeGroups: [group]);
      if (file == null) return;
      final parsed = await const SlicerParser().parseFile(File(file.path));
      if (!mounted) return;
      setState(() {
        _imported = parsed;
        _plateSelected
          ..clear()
          ..addEntries(parsed.plates.map((plate) => MapEntry(plate.id, true)));
        _plateRuns
          ..clear()
          ..addEntries(parsed.plates.map((plate) => MapEntry(plate.id, 1)));
        _unitsPerRun
          ..clear()
          ..addEntries(
            parsed.plates.map((plate) => MapEntry(plate.id, plate.unitsPerRun)),
          );
        _toolPriceMicros.clear();
        _confirmedToolPrices.clear();
        for (final material in parsed.plates.expand(
          (plate) => plate.materials,
        )) {
          _toolPriceMicros.putIfAbsent(material.toolIndex, () => 0);
        }
      });
      _calculate();
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = error.toString());
    }
  }

  Future<void> _shareQuote() async {
    final result = _result;
    if (result == null) return;
    try {
      await const PdfQuoteService().share(_quoteData(result));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not share quote: $error')));
    }
  }

  Future<void> _runPdfAction(
    Future<Object?> Function(PdfQuoteService, QuoteDocumentData) action,
    String success,
  ) async {
    final result = _result;
    if (result == null) return;
    try {
      await action(const PdfQuoteService(), _quoteData(result));
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(success)));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('PDF action failed: $error')));
    }
  }

  QuoteDocumentData _quoteData(PriceBreakdown result) => QuoteDocumentData(
    quoteNumber: _previewQuoteNumber,
    project: _mappedProject(),
    price: result,
    customerName: _requiredText(_customerName.text, 'Customer name'),
    turnaround: _requiredText(_turnaround.text, 'Turnaround'),
    taxBasisPoints: _taxEnabled ? _basisPoints(_taxPercent.text) : 0,
    businessName: _businessProfile?.businessName ?? 'AVEONEX',
    trn: _businessProfile?.trn,
    termsEnglish:
        _businessProfile?.termsEnglish ??
        'Quotation validity and payment terms to be agreed.',
    termsArabic:
        _businessProfile?.termsArabic ??
        'تُحدد صلاحية العرض وشروط الدفع بالاتفاق.',
  );

  Future<void> _loadBusinessProfile() async {
    final rows = await widget.database
        .select(widget.database.businessProfiles)
        .get();
    if (rows.isEmpty || !mounted) return;
    final profile = rows.first;
    setState(() {
      _businessProfile = profile;
      if (profile.vatBasisPoints > 0) {
        _taxEnabled = true;
        _taxPercent.text = (profile.vatBasisPoints / 100).toStringAsFixed(
          profile.vatBasisPoints % 100 == 0 ? 0 : 2,
        );
      }
    });
  }

  Future<void> _saveQuote() async {
    final result = _result;
    if (result == null) return;
    try {
      final now = DateTime.now();
      final sequence = await widget.database.nextQuoteSequence(now.year);
      final quoteNumber =
          'AVX-${now.year}-${sequence.toString().padLeft(4, '0')}';
      final quoteId = const Uuid().v4();
      final revisionId = const Uuid().v4();
      final jobId = const Uuid().v4();
      final project = _mappedProject();
      final snapshot = jsonEncode({
        'schemaVersion': 1,
        'quoteNumber': quoteNumber,
        'customerName': _requiredText(_customerName.text, 'Customer name'),
        'turnaround': _requiredText(_turnaround.text, 'Turnaround'),
        'project': project.toJson(),
        'rates': {
          'spoolPriceMicrosByTool': _imported == null
              ? {'0': _aed(_spoolPrice.text)}
              : _toolPriceMicros.map(
                  (tool, price) => MapEntry(tool.toString(), price),
                ),
          'electricityRateMicrosPerKwh': _aed(_electricity.text),
          'machineRateMicrosPerHour': _aed(_machineRate.text),
          'laborRateMicrosPerHour': _aed(_laborRate.text),
          'printerWatts': _number(_printerWatts.text).round(),
          'targetMarginBasisPoints': _marginBps,
          'failureAllowanceBasisPoints': _basisPoints(_failurePercent.text),
          'platformFeeBasisPoints': _basisPoints(_platformPercent.text),
          'platformFixedFeeMicros': _aed(_platformFixed.text),
          'taxBasisPoints': _taxEnabled ? _basisPoints(_taxPercent.text) : 0,
          'minimumOrderMicros': _minimumEnabled ? _aed(_minimum.text) : 0,
        },
        'totals': {
          'costMicros': result.totalCostMicros,
          'preTaxMicros': result.preTaxPriceMicros,
          'taxMicros': result.taxMicros,
          'finalMicros': result.finalPriceMicros,
          'netProfitMicros': result.netProfitMicros,
        },
      });
      await widget.database.transaction(() async {
        await widget.database
            .into(widget.database.quotes)
            .insert(
              QuotesCompanion.insert(
                id: quoteId,
                quoteNumber: quoteNumber,
                subtotalMicros: result.preTaxPriceMicros,
                taxMicros: result.taxMicros,
                totalMicros: result.finalPriceMicros,
                snapshotJson: snapshot,
              ),
            );
        await widget.database
            .into(widget.database.quoteRevisions)
            .insert(
              QuoteRevisionsCompanion.insert(
                id: revisionId,
                quoteId: quoteId,
                revisionNumber: 1,
                snapshotJson: snapshot,
                subtotalMicros: result.preTaxPriceMicros,
                taxMicros: result.taxMicros,
                totalMicros: result.finalPriceMicros,
                reason: const Value('Initial issued snapshot'),
              ),
            );
        await widget.database
            .into(widget.database.jobs)
            .insert(
              JobsCompanion.insert(
                id: jobId,
                quoteId: Value(quoteId),
                sourceName: Value(project.sourceName),
                projectJson: jsonEncode(project.toJson()),
              ),
            );
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$quoteNumber saved with immutable rates.')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save quote: $error')));
    }
  }

  void _calculate() {
    try {
      final project = _mappedProject();
      if (_imported != null) {
        final missing = _toolPriceMicros.keys.where(
          (tool) => !_confirmedToolPrices.contains(tool),
        );
        if (missing.isNotEmpty) {
          throw FormatException(
            'Enter and confirm the spool price for tool ${missing.first + 1}.',
          );
        }
      }
      final profiles = <String, MaterialProfile>{};
      for (final plate in project.plates) {
        for (final material in plate.materials) {
          final id = material.materialProfileId!;
          profiles[id] = MaterialProfile(
            id: id,
            name:
                material.colorName ??
                material.colorHex ??
                'Tool ${material.toolIndex + 1}',
            materialType: material.materialType ?? 'PLA',
            colorHex: material.colorHex ?? '#888888',
            spoolPriceMicros: _imported == null
                ? _aedRequired(_spoolPrice.text, 'Spool price')
                : _toolPriceMicros[material.toolIndex]!,
            nominalMassMg: 1000000,
          );
        }
      }
      final result = const PricingEngine().calculate(
        PricingInput(
          project: project,
          materialProfiles: profiles,
          printer: PrinterProfile(
            id: 'default',
            name: 'Workshop printer',
            watts: _integerRequired(_printerWatts.text, 'Printer power'),
            machineRateMicrosPerHour: _aedRequired(
              _machineRate.text,
              'Machine rate',
            ),
          ),
          settings: PricingSettings(
            electricityRateMicrosPerKwh: _aedRequired(
              _electricity.text,
              'Electricity rate',
            ),
            laborRateMicrosPerHour: _aedRequired(
              _laborRate.text,
              'Labour rate',
            ),
            failureAllowanceBasisPoints: _basisPointsRequired(
              _failurePercent.text,
              'Failure allowance',
            ),
            targetMarginBasisPoints: _marginBps,
            platformFeeBasisPoints: _basisPointsRequired(
              _platformPercent.text,
              'Marketplace fee',
            ),
            platformFixedFeeMicros: _aedRequired(
              _platformFixed.text,
              'Fixed platform fee',
            ),
            taxBasisPoints: _taxEnabled
                ? _basisPointsRequired(_taxPercent.text, 'Tax rate')
                : 0,
            minimumOrderMicros: _minimumEnabled
                ? _aedRequired(_minimum.text, 'Minimum order')
                : 0,
          ),
          setupLaborMinutes: _integerRequired(
            _setupMinutes.text,
            'Setup labour',
          ),
          perPlateLaborMinutes: _integerRequired(
            _perPlateMinutes.text,
            'Labour per plate run',
          ),
          perUnitFinishingMinutes: _integerRequired(
            _perUnitMinutes.text,
            'Finishing per unit',
          ),
          orderPackagingMicros: _aedRequired(
            _orderPackaging.text,
            'Order packaging',
          ),
          shippingMicros: _aedRequired(_shipping.text, 'Shipping'),
        ),
      );
      if (mounted) {
        setState(() {
          _result = result;
          _error = null;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _result = null;
          _error = error.toString();
        });
      }
    }
  }

  ParsedPrintProject _mappedProject() {
    final source =
        _imported ??
        ParsedPrintProject(
          sourceName: 'Manual estimate',
          slicer: SlicerKind.unknown,
          plates: [
            PlateEstimate(
              id: 'manual',
              name: 'Manual plate',
              durationSeconds:
                  (_requiredNumber(_hours.text, 'Print time') * 3600).round(),
              materials: [
                MaterialConsumption(
                  toolIndex: 0,
                  reportedTotalMassMg:
                      (_requiredNumber(_weight.text, 'Total filament') * 1000)
                          .round(),
                  source: ValueSource.manual,
                ),
              ],
            ),
          ],
        );
    return ParsedPrintProject(
      sourceName: source.sourceName,
      slicer: source.slicer,
      slicerVersion: source.slicerVersion,
      warnings: source.warnings,
      confidenceBasisPoints: source.confidenceBasisPoints,
      plates: [
        for (final plate in source.plates)
          plate.copyWith(
            selected: _plateSelected[plate.id] ?? plate.selected,
            plateRuns: _imported == null
                ? _runs
                : (_plateRuns[plate.id] ?? plate.plateRuns),
            unitsPerRun: _unitsPerRun[plate.id] ?? plate.unitsPerRun,
            materials: [
              for (final material in plate.materials)
                material.copyWith(
                  materialProfileId: 'tool-${material.toolIndex}',
                ),
            ],
          ),
      ],
    );
  }

  int _aed(String value) => (_number(value) * 1000000).round();
  int _aedRequired(String value, String label) =>
      (_requiredNumber(value, label) * 1000000).round();
  int _basisPoints(String value) => (_number(value) * 100).round();
  int _basisPointsRequired(String value, String label) =>
      (_requiredNumber(value, label) * 100).round();
  int _integerRequired(String value, String label) =>
      _requiredNumber(value, label).round();
  double _requiredNumber(String value, String label) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw FormatException('$label is required. Enter 0 if it is free.');
    }
    final parsed = double.tryParse(trimmed);
    if (parsed == null || parsed < 0) {
      throw FormatException('$label must be a non-negative number.');
    }
    return parsed;
  }

  String _requiredText(String value, String label) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) throw FormatException('$label is required.');
    return trimmed;
  }

  double _number(String value) => double.tryParse(value.trim()) ?? 0;
  String _money(int micros) => (micros / 1000000).toStringAsFixed(2);
}

class _ImportSummary extends StatelessWidget {
  const _ImportSummary({required this.project});

  final ParsedPrintProject project;

  @override
  Widget build(BuildContext context) {
    final grams =
        project.plates
            .expand((plate) => plate.materials)
            .fold<int>(
              0,
              (sum, material) => sum + material.totalConsumedMassMg,
            ) /
        1000;
    final seconds = project.plates.fold<int>(
      0,
      (sum, plate) => sum + plate.durationSeconds,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Wrap(
          spacing: 24,
          runSpacing: 10,
          children: [
            Text(
              project.sourceName,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(project.slicer.name),
            Text('${project.plates.length} plate(s)'),
            Text('${(seconds / 3600).toStringAsFixed(1)} h'),
            Text('${grams.toStringAsFixed(1)} g'),
            if (project.needsConfirmation)
              const Chip(
                avatar: Icon(Icons.warning_amber, size: 16),
                label: Text('Review required'),
              ),
          ],
        ),
      ),
    );
  }
}

class _PlateControls extends StatefulWidget {
  const _PlateControls({
    required this.project,
    required this.selected,
    required this.runs,
    required this.units,
    required this.onChanged,
  });

  final ParsedPrintProject project;
  final Map<String, bool> selected;
  final Map<String, int> runs;
  final Map<String, int> units;
  final VoidCallback onChanged;

  @override
  State<_PlateControls> createState() => _PlateControlsState();
}

class _PlateControlsState extends State<_PlateControls> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plates & quantity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            for (final plate in widget.project.plates)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Checkbox(
                      value: widget.selected[plate.id] ?? true,
                      onChanged: (value) {
                        setState(
                          () => widget.selected[plate.id] = value ?? true,
                        );
                        widget.onChanged();
                      },
                    ),
                    Expanded(child: Text(plate.name)),
                    const Text('units/run'),
                    const SizedBox(width: 6),
                    _smallStepper(
                      widget.units[plate.id] ?? plate.unitsPerRun,
                      (value) => widget.units[plate.id] = value,
                    ),
                    const SizedBox(width: 12),
                    const Text('runs'),
                    const SizedBox(width: 6),
                    _smallStepper(
                      widget.runs[plate.id] ?? 1,
                      (value) => widget.runs[plate.id] = value,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _smallStepper(int value, ValueChanged<int> update) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: value <= 1
              ? null
              : () {
                  setState(() => update(value - 1));
                  widget.onChanged();
                },
          icon: const Icon(Icons.remove, size: 18),
        ),
        Text('$value'),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            setState(() => update(value + 1));
            widget.onChanged();
          },
          icon: const Icon(Icons.add, size: 18),
        ),
      ],
    );
  }
}
