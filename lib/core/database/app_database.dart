import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class MaterialProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get materialType => text()();
  TextColumn get brand => text().nullable()();
  TextColumn get colorHex => text()();
  IntColumn get spoolPriceMicros => integer()();
  IntColumn get nominalMassMg => integer()();
  IntColumn get densityMicrogramsPerCubicMillimeter =>
      integer().withDefault(const Constant(1240))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Spools extends Table {
  TextColumn get id => text()();
  TextColumn get materialProfileId =>
      text().references(MaterialProfiles, #id)();
  TextColumn get lotCode => text().nullable()();
  IntColumn get remainingMassMg => integer()();
  DateTimeColumn get openedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PrinterProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get watts => integer()();
  IntColumn get machineRateMicrosPerHour => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Quotes extends Table {
  TextColumn get id => text()();
  TextColumn get quoteNumber => text().unique()();
  TextColumn get customerId => text().nullable().references(Customers, #id)();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get currencyCode => text().withDefault(const Constant('AED'))();
  IntColumn get subtotalMicros => integer()();
  IntColumn get taxMicros => integer()();
  IntColumn get totalMicros => integer()();
  TextColumn get snapshotJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class QuoteRevisions extends Table {
  TextColumn get id => text()();
  TextColumn get quoteId => text().references(Quotes, #id)();
  IntColumn get revisionNumber => integer()();
  TextColumn get snapshotJson => text()();
  IntColumn get subtotalMicros => integer()();
  IntColumn get taxMicros => integer()();
  IntColumn get totalMicros => integer()();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {quoteId, revisionNumber},
  ];
}

class Jobs extends Table {
  TextColumn get id => text()();
  TextColumn get quoteId => text().nullable().references(Quotes, #id)();
  TextColumn get state => text().withDefault(const Constant('draft'))();
  TextColumn get sourceName => text().nullable()();
  TextColumn get projectJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PrintAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get jobId => text().references(Jobs, #id)();
  IntColumn get sequence => integer()();
  TextColumn get state => text().withDefault(const Constant('planned'))();
  IntColumn get estimatedMassMg => integer().withDefault(const Constant(0))();
  IntColumn get actualMassMg => integer().nullable()();
  IntColumn get elapsedSeconds => integer().withDefault(const Constant(0))();
  TextColumn get failureReason => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {jobId, sequence},
  ];
}

class InventoryTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get spoolId => text().references(Spools, #id)();
  TextColumn get jobId => text().nullable().references(Jobs, #id)();
  TextColumn get attemptId =>
      text().nullable().references(PrintAttempts, #id)();
  TextColumn get kind => text()();
  IntColumn get deltaMassMg => integer()();
  TextColumn get note => text().nullable()();
  TextColumn get reversalOfTransactionId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MarketplacePresets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get percentageBasisPoints => integer()();
  IntColumn get fixedFeeMicros => integer()();
  TextColumn get currencyCode => text().withDefault(const Constant('AED'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BusinessProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get businessName => text()();
  TextColumn get logoPath => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get addressEnglish => text().nullable()();
  TextColumn get addressArabic => text().nullable()();
  TextColumn get trn => text().nullable()();
  IntColumn get vatBasisPoints => integer().withDefault(const Constant(0))();
  TextColumn get termsEnglish => text().nullable()();
  TextColumn get termsArabic => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BackupMetadata extends Table {
  TextColumn get id => text()();
  IntColumn get schemaVersion => integer()();
  TextColumn get sha256Hex => text()();
  TextColumn get fileName => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get restoredAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get valueJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    MaterialProfiles,
    Spools,
    PrinterProfiles,
    Customers,
    Quotes,
    QuoteRevisions,
    Jobs,
    PrintAttempts,
    InventoryTransactions,
    MarketplacePresets,
    BusinessProfiles,
    BackupMetadata,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'filarithm'));

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(quoteRevisions);
        await migrator.createTable(printAttempts);
        await migrator.addColumn(
          inventoryTransactions,
          inventoryTransactions.attemptId,
        );
        await migrator.addColumn(
          inventoryTransactions,
          inventoryTransactions.reversalOfTransactionId,
        );
        await migrator.createTable(marketplacePresets);
        await migrator.createTable(businessProfiles);
        await migrator.createTable(backupMetadata);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Stream<List<MaterialProfile>> watchMaterials() =>
      select(materialProfiles).watch();

  Stream<List<Spool>> watchAvailableSpools() =>
      (select(spools)..where((row) => row.archived.equals(false))).watch();

  Stream<List<Job>> watchJobs() => (select(
    jobs,
  )..orderBy([(row) => OrderingTerm.desc(row.updatedAt)])).watch();

  Future<int> nextQuoteSequence(int year) async {
    final prefix = 'AVX-$year-';
    final rows = await (select(
      quotes,
    )..where((row) => row.quoteNumber.like('$prefix%'))).get();
    var maximum = 0;
    for (final row in rows) {
      final value = int.tryParse(row.quoteNumber.split('-').last) ?? 0;
      if (value > maximum) maximum = value;
    }
    return maximum + 1;
  }
}
