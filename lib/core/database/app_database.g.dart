// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MaterialProfilesTable extends MaterialProfiles
    with TableInfo<$MaterialProfilesTable, MaterialProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaterialProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialTypeMeta = const VerificationMeta(
    'materialType',
  );
  @override
  late final GeneratedColumn<String> materialType = GeneratedColumn<String>(
    'material_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spoolPriceMicrosMeta = const VerificationMeta(
    'spoolPriceMicros',
  );
  @override
  late final GeneratedColumn<int> spoolPriceMicros = GeneratedColumn<int>(
    'spool_price_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMassMgMeta = const VerificationMeta(
    'nominalMassMg',
  );
  @override
  late final GeneratedColumn<int> nominalMassMg = GeneratedColumn<int>(
    'nominal_mass_mg',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _densityMicrogramsPerCubicMillimeterMeta =
      const VerificationMeta('densityMicrogramsPerCubicMillimeter');
  @override
  late final GeneratedColumn<int> densityMicrogramsPerCubicMillimeter =
      GeneratedColumn<int>(
        'density_micrograms_per_cubic_millimeter',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(1240),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    materialType,
    brand,
    colorHex,
    spoolPriceMicros,
    nominalMassMg,
    densityMicrogramsPerCubicMillimeter,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'material_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaterialProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('material_type')) {
      context.handle(
        _materialTypeMeta,
        materialType.isAcceptableOrUnknown(
          data['material_type']!,
          _materialTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_materialTypeMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    if (data.containsKey('spool_price_micros')) {
      context.handle(
        _spoolPriceMicrosMeta,
        spoolPriceMicros.isAcceptableOrUnknown(
          data['spool_price_micros']!,
          _spoolPriceMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_spoolPriceMicrosMeta);
    }
    if (data.containsKey('nominal_mass_mg')) {
      context.handle(
        _nominalMassMgMeta,
        nominalMassMg.isAcceptableOrUnknown(
          data['nominal_mass_mg']!,
          _nominalMassMgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nominalMassMgMeta);
    }
    if (data.containsKey('density_micrograms_per_cubic_millimeter')) {
      context.handle(
        _densityMicrogramsPerCubicMillimeterMeta,
        densityMicrogramsPerCubicMillimeter.isAcceptableOrUnknown(
          data['density_micrograms_per_cubic_millimeter']!,
          _densityMicrogramsPerCubicMillimeterMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaterialProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaterialProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      materialType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_type'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
      spoolPriceMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spool_price_micros'],
      )!,
      nominalMassMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal_mass_mg'],
      )!,
      densityMicrogramsPerCubicMillimeter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}density_micrograms_per_cubic_millimeter'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MaterialProfilesTable createAlias(String alias) {
    return $MaterialProfilesTable(attachedDatabase, alias);
  }
}

class MaterialProfile extends DataClass implements Insertable<MaterialProfile> {
  final String id;
  final String name;
  final String materialType;
  final String? brand;
  final String colorHex;
  final int spoolPriceMicros;
  final int nominalMassMg;
  final int densityMicrogramsPerCubicMillimeter;
  final DateTime createdAt;
  const MaterialProfile({
    required this.id,
    required this.name,
    required this.materialType,
    this.brand,
    required this.colorHex,
    required this.spoolPriceMicros,
    required this.nominalMassMg,
    required this.densityMicrogramsPerCubicMillimeter,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['material_type'] = Variable<String>(materialType);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    map['color_hex'] = Variable<String>(colorHex);
    map['spool_price_micros'] = Variable<int>(spoolPriceMicros);
    map['nominal_mass_mg'] = Variable<int>(nominalMassMg);
    map['density_micrograms_per_cubic_millimeter'] = Variable<int>(
      densityMicrogramsPerCubicMillimeter,
    );
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaterialProfilesCompanion toCompanion(bool nullToAbsent) {
    return MaterialProfilesCompanion(
      id: Value(id),
      name: Value(name),
      materialType: Value(materialType),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      colorHex: Value(colorHex),
      spoolPriceMicros: Value(spoolPriceMicros),
      nominalMassMg: Value(nominalMassMg),
      densityMicrogramsPerCubicMillimeter: Value(
        densityMicrogramsPerCubicMillimeter,
      ),
      createdAt: Value(createdAt),
    );
  }

  factory MaterialProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaterialProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      materialType: serializer.fromJson<String>(json['materialType']),
      brand: serializer.fromJson<String?>(json['brand']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      spoolPriceMicros: serializer.fromJson<int>(json['spoolPriceMicros']),
      nominalMassMg: serializer.fromJson<int>(json['nominalMassMg']),
      densityMicrogramsPerCubicMillimeter: serializer.fromJson<int>(
        json['densityMicrogramsPerCubicMillimeter'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'materialType': serializer.toJson<String>(materialType),
      'brand': serializer.toJson<String?>(brand),
      'colorHex': serializer.toJson<String>(colorHex),
      'spoolPriceMicros': serializer.toJson<int>(spoolPriceMicros),
      'nominalMassMg': serializer.toJson<int>(nominalMassMg),
      'densityMicrogramsPerCubicMillimeter': serializer.toJson<int>(
        densityMicrogramsPerCubicMillimeter,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaterialProfile copyWith({
    String? id,
    String? name,
    String? materialType,
    Value<String?> brand = const Value.absent(),
    String? colorHex,
    int? spoolPriceMicros,
    int? nominalMassMg,
    int? densityMicrogramsPerCubicMillimeter,
    DateTime? createdAt,
  }) => MaterialProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    materialType: materialType ?? this.materialType,
    brand: brand.present ? brand.value : this.brand,
    colorHex: colorHex ?? this.colorHex,
    spoolPriceMicros: spoolPriceMicros ?? this.spoolPriceMicros,
    nominalMassMg: nominalMassMg ?? this.nominalMassMg,
    densityMicrogramsPerCubicMillimeter:
        densityMicrogramsPerCubicMillimeter ??
        this.densityMicrogramsPerCubicMillimeter,
    createdAt: createdAt ?? this.createdAt,
  );
  MaterialProfile copyWithCompanion(MaterialProfilesCompanion data) {
    return MaterialProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      materialType: data.materialType.present
          ? data.materialType.value
          : this.materialType,
      brand: data.brand.present ? data.brand.value : this.brand,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      spoolPriceMicros: data.spoolPriceMicros.present
          ? data.spoolPriceMicros.value
          : this.spoolPriceMicros,
      nominalMassMg: data.nominalMassMg.present
          ? data.nominalMassMg.value
          : this.nominalMassMg,
      densityMicrogramsPerCubicMillimeter:
          data.densityMicrogramsPerCubicMillimeter.present
          ? data.densityMicrogramsPerCubicMillimeter.value
          : this.densityMicrogramsPerCubicMillimeter,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaterialProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('materialType: $materialType, ')
          ..write('brand: $brand, ')
          ..write('colorHex: $colorHex, ')
          ..write('spoolPriceMicros: $spoolPriceMicros, ')
          ..write('nominalMassMg: $nominalMassMg, ')
          ..write(
            'densityMicrogramsPerCubicMillimeter: $densityMicrogramsPerCubicMillimeter, ',
          )
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    materialType,
    brand,
    colorHex,
    spoolPriceMicros,
    nominalMassMg,
    densityMicrogramsPerCubicMillimeter,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaterialProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.materialType == this.materialType &&
          other.brand == this.brand &&
          other.colorHex == this.colorHex &&
          other.spoolPriceMicros == this.spoolPriceMicros &&
          other.nominalMassMg == this.nominalMassMg &&
          other.densityMicrogramsPerCubicMillimeter ==
              this.densityMicrogramsPerCubicMillimeter &&
          other.createdAt == this.createdAt);
}

class MaterialProfilesCompanion extends UpdateCompanion<MaterialProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> materialType;
  final Value<String?> brand;
  final Value<String> colorHex;
  final Value<int> spoolPriceMicros;
  final Value<int> nominalMassMg;
  final Value<int> densityMicrogramsPerCubicMillimeter;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MaterialProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.materialType = const Value.absent(),
    this.brand = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.spoolPriceMicros = const Value.absent(),
    this.nominalMassMg = const Value.absent(),
    this.densityMicrogramsPerCubicMillimeter = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaterialProfilesCompanion.insert({
    required String id,
    required String name,
    required String materialType,
    this.brand = const Value.absent(),
    required String colorHex,
    required int spoolPriceMicros,
    required int nominalMassMg,
    this.densityMicrogramsPerCubicMillimeter = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       materialType = Value(materialType),
       colorHex = Value(colorHex),
       spoolPriceMicros = Value(spoolPriceMicros),
       nominalMassMg = Value(nominalMassMg);
  static Insertable<MaterialProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? materialType,
    Expression<String>? brand,
    Expression<String>? colorHex,
    Expression<int>? spoolPriceMicros,
    Expression<int>? nominalMassMg,
    Expression<int>? densityMicrogramsPerCubicMillimeter,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (materialType != null) 'material_type': materialType,
      if (brand != null) 'brand': brand,
      if (colorHex != null) 'color_hex': colorHex,
      if (spoolPriceMicros != null) 'spool_price_micros': spoolPriceMicros,
      if (nominalMassMg != null) 'nominal_mass_mg': nominalMassMg,
      if (densityMicrogramsPerCubicMillimeter != null)
        'density_micrograms_per_cubic_millimeter':
            densityMicrogramsPerCubicMillimeter,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaterialProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? materialType,
    Value<String?>? brand,
    Value<String>? colorHex,
    Value<int>? spoolPriceMicros,
    Value<int>? nominalMassMg,
    Value<int>? densityMicrogramsPerCubicMillimeter,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MaterialProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      materialType: materialType ?? this.materialType,
      brand: brand ?? this.brand,
      colorHex: colorHex ?? this.colorHex,
      spoolPriceMicros: spoolPriceMicros ?? this.spoolPriceMicros,
      nominalMassMg: nominalMassMg ?? this.nominalMassMg,
      densityMicrogramsPerCubicMillimeter:
          densityMicrogramsPerCubicMillimeter ??
          this.densityMicrogramsPerCubicMillimeter,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (materialType.present) {
      map['material_type'] = Variable<String>(materialType.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (spoolPriceMicros.present) {
      map['spool_price_micros'] = Variable<int>(spoolPriceMicros.value);
    }
    if (nominalMassMg.present) {
      map['nominal_mass_mg'] = Variable<int>(nominalMassMg.value);
    }
    if (densityMicrogramsPerCubicMillimeter.present) {
      map['density_micrograms_per_cubic_millimeter'] = Variable<int>(
        densityMicrogramsPerCubicMillimeter.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaterialProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('materialType: $materialType, ')
          ..write('brand: $brand, ')
          ..write('colorHex: $colorHex, ')
          ..write('spoolPriceMicros: $spoolPriceMicros, ')
          ..write('nominalMassMg: $nominalMassMg, ')
          ..write(
            'densityMicrogramsPerCubicMillimeter: $densityMicrogramsPerCubicMillimeter, ',
          )
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpoolsTable extends Spools with TableInfo<$SpoolsTable, Spool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpoolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialProfileIdMeta = const VerificationMeta(
    'materialProfileId',
  );
  @override
  late final GeneratedColumn<String> materialProfileId =
      GeneratedColumn<String>(
        'material_profile_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES material_profiles (id)',
        ),
      );
  static const VerificationMeta _lotCodeMeta = const VerificationMeta(
    'lotCode',
  );
  @override
  late final GeneratedColumn<String> lotCode = GeneratedColumn<String>(
    'lot_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remainingMassMgMeta = const VerificationMeta(
    'remainingMassMg',
  );
  @override
  late final GeneratedColumn<int> remainingMassMg = GeneratedColumn<int>(
    'remaining_mass_mg',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    materialProfileId,
    lotCode,
    remainingMassMg,
    openedAt,
    createdAt,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spools';
  @override
  VerificationContext validateIntegrity(
    Insertable<Spool> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('material_profile_id')) {
      context.handle(
        _materialProfileIdMeta,
        materialProfileId.isAcceptableOrUnknown(
          data['material_profile_id']!,
          _materialProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_materialProfileIdMeta);
    }
    if (data.containsKey('lot_code')) {
      context.handle(
        _lotCodeMeta,
        lotCode.isAcceptableOrUnknown(data['lot_code']!, _lotCodeMeta),
      );
    }
    if (data.containsKey('remaining_mass_mg')) {
      context.handle(
        _remainingMassMgMeta,
        remainingMassMg.isAcceptableOrUnknown(
          data['remaining_mass_mg']!,
          _remainingMassMgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingMassMgMeta);
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Spool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Spool(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      materialProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_profile_id'],
      )!,
      lotCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_code'],
      ),
      remainingMassMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_mass_mg'],
      )!,
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $SpoolsTable createAlias(String alias) {
    return $SpoolsTable(attachedDatabase, alias);
  }
}

class Spool extends DataClass implements Insertable<Spool> {
  final String id;
  final String materialProfileId;
  final String? lotCode;
  final int remainingMassMg;
  final DateTime? openedAt;
  final DateTime createdAt;
  final bool archived;
  const Spool({
    required this.id,
    required this.materialProfileId,
    this.lotCode,
    required this.remainingMassMg,
    this.openedAt,
    required this.createdAt,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['material_profile_id'] = Variable<String>(materialProfileId);
    if (!nullToAbsent || lotCode != null) {
      map['lot_code'] = Variable<String>(lotCode);
    }
    map['remaining_mass_mg'] = Variable<int>(remainingMassMg);
    if (!nullToAbsent || openedAt != null) {
      map['opened_at'] = Variable<DateTime>(openedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  SpoolsCompanion toCompanion(bool nullToAbsent) {
    return SpoolsCompanion(
      id: Value(id),
      materialProfileId: Value(materialProfileId),
      lotCode: lotCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lotCode),
      remainingMassMg: Value(remainingMassMg),
      openedAt: openedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(openedAt),
      createdAt: Value(createdAt),
      archived: Value(archived),
    );
  }

  factory Spool.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Spool(
      id: serializer.fromJson<String>(json['id']),
      materialProfileId: serializer.fromJson<String>(json['materialProfileId']),
      lotCode: serializer.fromJson<String?>(json['lotCode']),
      remainingMassMg: serializer.fromJson<int>(json['remainingMassMg']),
      openedAt: serializer.fromJson<DateTime?>(json['openedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'materialProfileId': serializer.toJson<String>(materialProfileId),
      'lotCode': serializer.toJson<String?>(lotCode),
      'remainingMassMg': serializer.toJson<int>(remainingMassMg),
      'openedAt': serializer.toJson<DateTime?>(openedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  Spool copyWith({
    String? id,
    String? materialProfileId,
    Value<String?> lotCode = const Value.absent(),
    int? remainingMassMg,
    Value<DateTime?> openedAt = const Value.absent(),
    DateTime? createdAt,
    bool? archived,
  }) => Spool(
    id: id ?? this.id,
    materialProfileId: materialProfileId ?? this.materialProfileId,
    lotCode: lotCode.present ? lotCode.value : this.lotCode,
    remainingMassMg: remainingMassMg ?? this.remainingMassMg,
    openedAt: openedAt.present ? openedAt.value : this.openedAt,
    createdAt: createdAt ?? this.createdAt,
    archived: archived ?? this.archived,
  );
  Spool copyWithCompanion(SpoolsCompanion data) {
    return Spool(
      id: data.id.present ? data.id.value : this.id,
      materialProfileId: data.materialProfileId.present
          ? data.materialProfileId.value
          : this.materialProfileId,
      lotCode: data.lotCode.present ? data.lotCode.value : this.lotCode,
      remainingMassMg: data.remainingMassMg.present
          ? data.remainingMassMg.value
          : this.remainingMassMg,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Spool(')
          ..write('id: $id, ')
          ..write('materialProfileId: $materialProfileId, ')
          ..write('lotCode: $lotCode, ')
          ..write('remainingMassMg: $remainingMassMg, ')
          ..write('openedAt: $openedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    materialProfileId,
    lotCode,
    remainingMassMg,
    openedAt,
    createdAt,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spool &&
          other.id == this.id &&
          other.materialProfileId == this.materialProfileId &&
          other.lotCode == this.lotCode &&
          other.remainingMassMg == this.remainingMassMg &&
          other.openedAt == this.openedAt &&
          other.createdAt == this.createdAt &&
          other.archived == this.archived);
}

class SpoolsCompanion extends UpdateCompanion<Spool> {
  final Value<String> id;
  final Value<String> materialProfileId;
  final Value<String?> lotCode;
  final Value<int> remainingMassMg;
  final Value<DateTime?> openedAt;
  final Value<DateTime> createdAt;
  final Value<bool> archived;
  final Value<int> rowid;
  const SpoolsCompanion({
    this.id = const Value.absent(),
    this.materialProfileId = const Value.absent(),
    this.lotCode = const Value.absent(),
    this.remainingMassMg = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpoolsCompanion.insert({
    required String id,
    required String materialProfileId,
    this.lotCode = const Value.absent(),
    required int remainingMassMg,
    this.openedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       materialProfileId = Value(materialProfileId),
       remainingMassMg = Value(remainingMassMg);
  static Insertable<Spool> custom({
    Expression<String>? id,
    Expression<String>? materialProfileId,
    Expression<String>? lotCode,
    Expression<int>? remainingMassMg,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? createdAt,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (materialProfileId != null) 'material_profile_id': materialProfileId,
      if (lotCode != null) 'lot_code': lotCode,
      if (remainingMassMg != null) 'remaining_mass_mg': remainingMassMg,
      if (openedAt != null) 'opened_at': openedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpoolsCompanion copyWith({
    Value<String>? id,
    Value<String>? materialProfileId,
    Value<String?>? lotCode,
    Value<int>? remainingMassMg,
    Value<DateTime?>? openedAt,
    Value<DateTime>? createdAt,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return SpoolsCompanion(
      id: id ?? this.id,
      materialProfileId: materialProfileId ?? this.materialProfileId,
      lotCode: lotCode ?? this.lotCode,
      remainingMassMg: remainingMassMg ?? this.remainingMassMg,
      openedAt: openedAt ?? this.openedAt,
      createdAt: createdAt ?? this.createdAt,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (materialProfileId.present) {
      map['material_profile_id'] = Variable<String>(materialProfileId.value);
    }
    if (lotCode.present) {
      map['lot_code'] = Variable<String>(lotCode.value);
    }
    if (remainingMassMg.present) {
      map['remaining_mass_mg'] = Variable<int>(remainingMassMg.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpoolsCompanion(')
          ..write('id: $id, ')
          ..write('materialProfileId: $materialProfileId, ')
          ..write('lotCode: $lotCode, ')
          ..write('remainingMassMg: $remainingMassMg, ')
          ..write('openedAt: $openedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrinterProfilesTable extends PrinterProfiles
    with TableInfo<$PrinterProfilesTable, PrinterProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrinterProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wattsMeta = const VerificationMeta('watts');
  @override
  late final GeneratedColumn<int> watts = GeneratedColumn<int>(
    'watts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _machineRateMicrosPerHourMeta =
      const VerificationMeta('machineRateMicrosPerHour');
  @override
  late final GeneratedColumn<int> machineRateMicrosPerHour =
      GeneratedColumn<int>(
        'machine_rate_micros_per_hour',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    watts,
    machineRateMicrosPerHour,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'printer_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrinterProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('watts')) {
      context.handle(
        _wattsMeta,
        watts.isAcceptableOrUnknown(data['watts']!, _wattsMeta),
      );
    } else if (isInserting) {
      context.missing(_wattsMeta);
    }
    if (data.containsKey('machine_rate_micros_per_hour')) {
      context.handle(
        _machineRateMicrosPerHourMeta,
        machineRateMicrosPerHour.isAcceptableOrUnknown(
          data['machine_rate_micros_per_hour']!,
          _machineRateMicrosPerHourMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_machineRateMicrosPerHourMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrinterProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrinterProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      watts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}watts'],
      )!,
      machineRateMicrosPerHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}machine_rate_micros_per_hour'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PrinterProfilesTable createAlias(String alias) {
    return $PrinterProfilesTable(attachedDatabase, alias);
  }
}

class PrinterProfile extends DataClass implements Insertable<PrinterProfile> {
  final String id;
  final String name;
  final int watts;
  final int machineRateMicrosPerHour;
  final DateTime createdAt;
  const PrinterProfile({
    required this.id,
    required this.name,
    required this.watts,
    required this.machineRateMicrosPerHour,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['watts'] = Variable<int>(watts);
    map['machine_rate_micros_per_hour'] = Variable<int>(
      machineRateMicrosPerHour,
    );
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrinterProfilesCompanion toCompanion(bool nullToAbsent) {
    return PrinterProfilesCompanion(
      id: Value(id),
      name: Value(name),
      watts: Value(watts),
      machineRateMicrosPerHour: Value(machineRateMicrosPerHour),
      createdAt: Value(createdAt),
    );
  }

  factory PrinterProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrinterProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      watts: serializer.fromJson<int>(json['watts']),
      machineRateMicrosPerHour: serializer.fromJson<int>(
        json['machineRateMicrosPerHour'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'watts': serializer.toJson<int>(watts),
      'machineRateMicrosPerHour': serializer.toJson<int>(
        machineRateMicrosPerHour,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PrinterProfile copyWith({
    String? id,
    String? name,
    int? watts,
    int? machineRateMicrosPerHour,
    DateTime? createdAt,
  }) => PrinterProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    watts: watts ?? this.watts,
    machineRateMicrosPerHour:
        machineRateMicrosPerHour ?? this.machineRateMicrosPerHour,
    createdAt: createdAt ?? this.createdAt,
  );
  PrinterProfile copyWithCompanion(PrinterProfilesCompanion data) {
    return PrinterProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      watts: data.watts.present ? data.watts.value : this.watts,
      machineRateMicrosPerHour: data.machineRateMicrosPerHour.present
          ? data.machineRateMicrosPerHour.value
          : this.machineRateMicrosPerHour,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrinterProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('watts: $watts, ')
          ..write('machineRateMicrosPerHour: $machineRateMicrosPerHour, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, watts, machineRateMicrosPerHour, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrinterProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.watts == this.watts &&
          other.machineRateMicrosPerHour == this.machineRateMicrosPerHour &&
          other.createdAt == this.createdAt);
}

class PrinterProfilesCompanion extends UpdateCompanion<PrinterProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> watts;
  final Value<int> machineRateMicrosPerHour;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PrinterProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.watts = const Value.absent(),
    this.machineRateMicrosPerHour = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrinterProfilesCompanion.insert({
    required String id,
    required String name,
    required int watts,
    required int machineRateMicrosPerHour,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       watts = Value(watts),
       machineRateMicrosPerHour = Value(machineRateMicrosPerHour);
  static Insertable<PrinterProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? watts,
    Expression<int>? machineRateMicrosPerHour,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (watts != null) 'watts': watts,
      if (machineRateMicrosPerHour != null)
        'machine_rate_micros_per_hour': machineRateMicrosPerHour,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrinterProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? watts,
    Value<int>? machineRateMicrosPerHour,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PrinterProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      watts: watts ?? this.watts,
      machineRateMicrosPerHour:
          machineRateMicrosPerHour ?? this.machineRateMicrosPerHour,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (watts.present) {
      map['watts'] = Variable<int>(watts.value);
    }
    if (machineRateMicrosPerHour.present) {
      map['machine_rate_micros_per_hour'] = Variable<int>(
        machineRateMicrosPerHour.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrinterProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('watts: $watts, ')
          ..write('machineRateMicrosPerHour: $machineRateMicrosPerHour, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    email,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? notes;
  final DateTime createdAt;
  const Customer({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith({
    String? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, email, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, Quote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteNumberMeta = const VerificationMeta(
    'quoteNumber',
  );
  @override
  late final GeneratedColumn<String> quoteNumber = GeneratedColumn<String>(
    'quote_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('AED'),
  );
  static const VerificationMeta _subtotalMicrosMeta = const VerificationMeta(
    'subtotalMicros',
  );
  @override
  late final GeneratedColumn<int> subtotalMicros = GeneratedColumn<int>(
    'subtotal_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMicrosMeta = const VerificationMeta(
    'taxMicros',
  );
  @override
  late final GeneratedColumn<int> taxMicros = GeneratedColumn<int>(
    'tax_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMicrosMeta = const VerificationMeta(
    'totalMicros',
  );
  @override
  late final GeneratedColumn<int> totalMicros = GeneratedColumn<int>(
    'total_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotJsonMeta = const VerificationMeta(
    'snapshotJson',
  );
  @override
  late final GeneratedColumn<String> snapshotJson = GeneratedColumn<String>(
    'snapshot_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quoteNumber,
    customerId,
    status,
    currencyCode,
    subtotalMicros,
    taxMicros,
    totalMicros,
    snapshotJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Quote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('quote_number')) {
      context.handle(
        _quoteNumberMeta,
        quoteNumber.isAcceptableOrUnknown(
          data['quote_number']!,
          _quoteNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quoteNumberMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('subtotal_micros')) {
      context.handle(
        _subtotalMicrosMeta,
        subtotalMicros.isAcceptableOrUnknown(
          data['subtotal_micros']!,
          _subtotalMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subtotalMicrosMeta);
    }
    if (data.containsKey('tax_micros')) {
      context.handle(
        _taxMicrosMeta,
        taxMicros.isAcceptableOrUnknown(data['tax_micros']!, _taxMicrosMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMicrosMeta);
    }
    if (data.containsKey('total_micros')) {
      context.handle(
        _totalMicrosMeta,
        totalMicros.isAcceptableOrUnknown(
          data['total_micros']!,
          _totalMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalMicrosMeta);
    }
    if (data.containsKey('snapshot_json')) {
      context.handle(
        _snapshotJsonMeta,
        snapshotJson.isAcceptableOrUnknown(
          data['snapshot_json']!,
          _snapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snapshotJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      quoteNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_number'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      subtotalMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_micros'],
      )!,
      taxMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_micros'],
      )!,
      totalMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_micros'],
      )!,
      snapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class Quote extends DataClass implements Insertable<Quote> {
  final String id;
  final String quoteNumber;
  final String? customerId;
  final String status;
  final String currencyCode;
  final int subtotalMicros;
  final int taxMicros;
  final int totalMicros;
  final String snapshotJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Quote({
    required this.id,
    required this.quoteNumber,
    this.customerId,
    required this.status,
    required this.currencyCode,
    required this.subtotalMicros,
    required this.taxMicros,
    required this.totalMicros,
    required this.snapshotJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['quote_number'] = Variable<String>(quoteNumber);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['status'] = Variable<String>(status);
    map['currency_code'] = Variable<String>(currencyCode);
    map['subtotal_micros'] = Variable<int>(subtotalMicros);
    map['tax_micros'] = Variable<int>(taxMicros);
    map['total_micros'] = Variable<int>(totalMicros);
    map['snapshot_json'] = Variable<String>(snapshotJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      quoteNumber: Value(quoteNumber),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      status: Value(status),
      currencyCode: Value(currencyCode),
      subtotalMicros: Value(subtotalMicros),
      taxMicros: Value(taxMicros),
      totalMicros: Value(totalMicros),
      snapshotJson: Value(snapshotJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Quote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quote(
      id: serializer.fromJson<String>(json['id']),
      quoteNumber: serializer.fromJson<String>(json['quoteNumber']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      status: serializer.fromJson<String>(json['status']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      subtotalMicros: serializer.fromJson<int>(json['subtotalMicros']),
      taxMicros: serializer.fromJson<int>(json['taxMicros']),
      totalMicros: serializer.fromJson<int>(json['totalMicros']),
      snapshotJson: serializer.fromJson<String>(json['snapshotJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'quoteNumber': serializer.toJson<String>(quoteNumber),
      'customerId': serializer.toJson<String?>(customerId),
      'status': serializer.toJson<String>(status),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'subtotalMicros': serializer.toJson<int>(subtotalMicros),
      'taxMicros': serializer.toJson<int>(taxMicros),
      'totalMicros': serializer.toJson<int>(totalMicros),
      'snapshotJson': serializer.toJson<String>(snapshotJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Quote copyWith({
    String? id,
    String? quoteNumber,
    Value<String?> customerId = const Value.absent(),
    String? status,
    String? currencyCode,
    int? subtotalMicros,
    int? taxMicros,
    int? totalMicros,
    String? snapshotJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Quote(
    id: id ?? this.id,
    quoteNumber: quoteNumber ?? this.quoteNumber,
    customerId: customerId.present ? customerId.value : this.customerId,
    status: status ?? this.status,
    currencyCode: currencyCode ?? this.currencyCode,
    subtotalMicros: subtotalMicros ?? this.subtotalMicros,
    taxMicros: taxMicros ?? this.taxMicros,
    totalMicros: totalMicros ?? this.totalMicros,
    snapshotJson: snapshotJson ?? this.snapshotJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Quote copyWithCompanion(QuotesCompanion data) {
    return Quote(
      id: data.id.present ? data.id.value : this.id,
      quoteNumber: data.quoteNumber.present
          ? data.quoteNumber.value
          : this.quoteNumber,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      status: data.status.present ? data.status.value : this.status,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      subtotalMicros: data.subtotalMicros.present
          ? data.subtotalMicros.value
          : this.subtotalMicros,
      taxMicros: data.taxMicros.present ? data.taxMicros.value : this.taxMicros,
      totalMicros: data.totalMicros.present
          ? data.totalMicros.value
          : this.totalMicros,
      snapshotJson: data.snapshotJson.present
          ? data.snapshotJson.value
          : this.snapshotJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quote(')
          ..write('id: $id, ')
          ..write('quoteNumber: $quoteNumber, ')
          ..write('customerId: $customerId, ')
          ..write('status: $status, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('subtotalMicros: $subtotalMicros, ')
          ..write('taxMicros: $taxMicros, ')
          ..write('totalMicros: $totalMicros, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    quoteNumber,
    customerId,
    status,
    currencyCode,
    subtotalMicros,
    taxMicros,
    totalMicros,
    snapshotJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          other.id == this.id &&
          other.quoteNumber == this.quoteNumber &&
          other.customerId == this.customerId &&
          other.status == this.status &&
          other.currencyCode == this.currencyCode &&
          other.subtotalMicros == this.subtotalMicros &&
          other.taxMicros == this.taxMicros &&
          other.totalMicros == this.totalMicros &&
          other.snapshotJson == this.snapshotJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class QuotesCompanion extends UpdateCompanion<Quote> {
  final Value<String> id;
  final Value<String> quoteNumber;
  final Value<String?> customerId;
  final Value<String> status;
  final Value<String> currencyCode;
  final Value<int> subtotalMicros;
  final Value<int> taxMicros;
  final Value<int> totalMicros;
  final Value<String> snapshotJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.quoteNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.status = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.subtotalMicros = const Value.absent(),
    this.taxMicros = const Value.absent(),
    this.totalMicros = const Value.absent(),
    this.snapshotJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuotesCompanion.insert({
    required String id,
    required String quoteNumber,
    this.customerId = const Value.absent(),
    this.status = const Value.absent(),
    this.currencyCode = const Value.absent(),
    required int subtotalMicros,
    required int taxMicros,
    required int totalMicros,
    required String snapshotJson,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       quoteNumber = Value(quoteNumber),
       subtotalMicros = Value(subtotalMicros),
       taxMicros = Value(taxMicros),
       totalMicros = Value(totalMicros),
       snapshotJson = Value(snapshotJson);
  static Insertable<Quote> custom({
    Expression<String>? id,
    Expression<String>? quoteNumber,
    Expression<String>? customerId,
    Expression<String>? status,
    Expression<String>? currencyCode,
    Expression<int>? subtotalMicros,
    Expression<int>? taxMicros,
    Expression<int>? totalMicros,
    Expression<String>? snapshotJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteNumber != null) 'quote_number': quoteNumber,
      if (customerId != null) 'customer_id': customerId,
      if (status != null) 'status': status,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (subtotalMicros != null) 'subtotal_micros': subtotalMicros,
      if (taxMicros != null) 'tax_micros': taxMicros,
      if (totalMicros != null) 'total_micros': totalMicros,
      if (snapshotJson != null) 'snapshot_json': snapshotJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuotesCompanion copyWith({
    Value<String>? id,
    Value<String>? quoteNumber,
    Value<String?>? customerId,
    Value<String>? status,
    Value<String>? currencyCode,
    Value<int>? subtotalMicros,
    Value<int>? taxMicros,
    Value<int>? totalMicros,
    Value<String>? snapshotJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return QuotesCompanion(
      id: id ?? this.id,
      quoteNumber: quoteNumber ?? this.quoteNumber,
      customerId: customerId ?? this.customerId,
      status: status ?? this.status,
      currencyCode: currencyCode ?? this.currencyCode,
      subtotalMicros: subtotalMicros ?? this.subtotalMicros,
      taxMicros: taxMicros ?? this.taxMicros,
      totalMicros: totalMicros ?? this.totalMicros,
      snapshotJson: snapshotJson ?? this.snapshotJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (quoteNumber.present) {
      map['quote_number'] = Variable<String>(quoteNumber.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (subtotalMicros.present) {
      map['subtotal_micros'] = Variable<int>(subtotalMicros.value);
    }
    if (taxMicros.present) {
      map['tax_micros'] = Variable<int>(taxMicros.value);
    }
    if (totalMicros.present) {
      map['total_micros'] = Variable<int>(totalMicros.value);
    }
    if (snapshotJson.present) {
      map['snapshot_json'] = Variable<String>(snapshotJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('quoteNumber: $quoteNumber, ')
          ..write('customerId: $customerId, ')
          ..write('status: $status, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('subtotalMicros: $subtotalMicros, ')
          ..write('taxMicros: $taxMicros, ')
          ..write('totalMicros: $totalMicros, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuoteRevisionsTable extends QuoteRevisions
    with TableInfo<$QuoteRevisionsTable, QuoteRevision> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuoteRevisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<String> quoteId = GeneratedColumn<String>(
    'quote_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quotes (id)',
    ),
  );
  static const VerificationMeta _revisionNumberMeta = const VerificationMeta(
    'revisionNumber',
  );
  @override
  late final GeneratedColumn<int> revisionNumber = GeneratedColumn<int>(
    'revision_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotJsonMeta = const VerificationMeta(
    'snapshotJson',
  );
  @override
  late final GeneratedColumn<String> snapshotJson = GeneratedColumn<String>(
    'snapshot_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMicrosMeta = const VerificationMeta(
    'subtotalMicros',
  );
  @override
  late final GeneratedColumn<int> subtotalMicros = GeneratedColumn<int>(
    'subtotal_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMicrosMeta = const VerificationMeta(
    'taxMicros',
  );
  @override
  late final GeneratedColumn<int> taxMicros = GeneratedColumn<int>(
    'tax_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMicrosMeta = const VerificationMeta(
    'totalMicros',
  );
  @override
  late final GeneratedColumn<int> totalMicros = GeneratedColumn<int>(
    'total_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quoteId,
    revisionNumber,
    snapshotJson,
    subtotalMicros,
    taxMicros,
    totalMicros,
    reason,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quote_revisions';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuoteRevision> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteIdMeta);
    }
    if (data.containsKey('revision_number')) {
      context.handle(
        _revisionNumberMeta,
        revisionNumber.isAcceptableOrUnknown(
          data['revision_number']!,
          _revisionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revisionNumberMeta);
    }
    if (data.containsKey('snapshot_json')) {
      context.handle(
        _snapshotJsonMeta,
        snapshotJson.isAcceptableOrUnknown(
          data['snapshot_json']!,
          _snapshotJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snapshotJsonMeta);
    }
    if (data.containsKey('subtotal_micros')) {
      context.handle(
        _subtotalMicrosMeta,
        subtotalMicros.isAcceptableOrUnknown(
          data['subtotal_micros']!,
          _subtotalMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subtotalMicrosMeta);
    }
    if (data.containsKey('tax_micros')) {
      context.handle(
        _taxMicrosMeta,
        taxMicros.isAcceptableOrUnknown(data['tax_micros']!, _taxMicrosMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMicrosMeta);
    }
    if (data.containsKey('total_micros')) {
      context.handle(
        _totalMicrosMeta,
        totalMicros.isAcceptableOrUnknown(
          data['total_micros']!,
          _totalMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalMicrosMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {quoteId, revisionNumber},
  ];
  @override
  QuoteRevision map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuoteRevision(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_id'],
      )!,
      revisionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_number'],
      )!,
      snapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot_json'],
      )!,
      subtotalMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_micros'],
      )!,
      taxMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_micros'],
      )!,
      totalMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_micros'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QuoteRevisionsTable createAlias(String alias) {
    return $QuoteRevisionsTable(attachedDatabase, alias);
  }
}

class QuoteRevision extends DataClass implements Insertable<QuoteRevision> {
  final String id;
  final String quoteId;
  final int revisionNumber;
  final String snapshotJson;
  final int subtotalMicros;
  final int taxMicros;
  final int totalMicros;
  final String? reason;
  final DateTime createdAt;
  const QuoteRevision({
    required this.id,
    required this.quoteId,
    required this.revisionNumber,
    required this.snapshotJson,
    required this.subtotalMicros,
    required this.taxMicros,
    required this.totalMicros,
    this.reason,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['quote_id'] = Variable<String>(quoteId);
    map['revision_number'] = Variable<int>(revisionNumber);
    map['snapshot_json'] = Variable<String>(snapshotJson);
    map['subtotal_micros'] = Variable<int>(subtotalMicros);
    map['tax_micros'] = Variable<int>(taxMicros);
    map['total_micros'] = Variable<int>(totalMicros);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuoteRevisionsCompanion toCompanion(bool nullToAbsent) {
    return QuoteRevisionsCompanion(
      id: Value(id),
      quoteId: Value(quoteId),
      revisionNumber: Value(revisionNumber),
      snapshotJson: Value(snapshotJson),
      subtotalMicros: Value(subtotalMicros),
      taxMicros: Value(taxMicros),
      totalMicros: Value(totalMicros),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAt: Value(createdAt),
    );
  }

  factory QuoteRevision.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuoteRevision(
      id: serializer.fromJson<String>(json['id']),
      quoteId: serializer.fromJson<String>(json['quoteId']),
      revisionNumber: serializer.fromJson<int>(json['revisionNumber']),
      snapshotJson: serializer.fromJson<String>(json['snapshotJson']),
      subtotalMicros: serializer.fromJson<int>(json['subtotalMicros']),
      taxMicros: serializer.fromJson<int>(json['taxMicros']),
      totalMicros: serializer.fromJson<int>(json['totalMicros']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'quoteId': serializer.toJson<String>(quoteId),
      'revisionNumber': serializer.toJson<int>(revisionNumber),
      'snapshotJson': serializer.toJson<String>(snapshotJson),
      'subtotalMicros': serializer.toJson<int>(subtotalMicros),
      'taxMicros': serializer.toJson<int>(taxMicros),
      'totalMicros': serializer.toJson<int>(totalMicros),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  QuoteRevision copyWith({
    String? id,
    String? quoteId,
    int? revisionNumber,
    String? snapshotJson,
    int? subtotalMicros,
    int? taxMicros,
    int? totalMicros,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAt,
  }) => QuoteRevision(
    id: id ?? this.id,
    quoteId: quoteId ?? this.quoteId,
    revisionNumber: revisionNumber ?? this.revisionNumber,
    snapshotJson: snapshotJson ?? this.snapshotJson,
    subtotalMicros: subtotalMicros ?? this.subtotalMicros,
    taxMicros: taxMicros ?? this.taxMicros,
    totalMicros: totalMicros ?? this.totalMicros,
    reason: reason.present ? reason.value : this.reason,
    createdAt: createdAt ?? this.createdAt,
  );
  QuoteRevision copyWithCompanion(QuoteRevisionsCompanion data) {
    return QuoteRevision(
      id: data.id.present ? data.id.value : this.id,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      revisionNumber: data.revisionNumber.present
          ? data.revisionNumber.value
          : this.revisionNumber,
      snapshotJson: data.snapshotJson.present
          ? data.snapshotJson.value
          : this.snapshotJson,
      subtotalMicros: data.subtotalMicros.present
          ? data.subtotalMicros.value
          : this.subtotalMicros,
      taxMicros: data.taxMicros.present ? data.taxMicros.value : this.taxMicros,
      totalMicros: data.totalMicros.present
          ? data.totalMicros.value
          : this.totalMicros,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuoteRevision(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('revisionNumber: $revisionNumber, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('subtotalMicros: $subtotalMicros, ')
          ..write('taxMicros: $taxMicros, ')
          ..write('totalMicros: $totalMicros, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    quoteId,
    revisionNumber,
    snapshotJson,
    subtotalMicros,
    taxMicros,
    totalMicros,
    reason,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuoteRevision &&
          other.id == this.id &&
          other.quoteId == this.quoteId &&
          other.revisionNumber == this.revisionNumber &&
          other.snapshotJson == this.snapshotJson &&
          other.subtotalMicros == this.subtotalMicros &&
          other.taxMicros == this.taxMicros &&
          other.totalMicros == this.totalMicros &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt);
}

class QuoteRevisionsCompanion extends UpdateCompanion<QuoteRevision> {
  final Value<String> id;
  final Value<String> quoteId;
  final Value<int> revisionNumber;
  final Value<String> snapshotJson;
  final Value<int> subtotalMicros;
  final Value<int> taxMicros;
  final Value<int> totalMicros;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const QuoteRevisionsCompanion({
    this.id = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.revisionNumber = const Value.absent(),
    this.snapshotJson = const Value.absent(),
    this.subtotalMicros = const Value.absent(),
    this.taxMicros = const Value.absent(),
    this.totalMicros = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuoteRevisionsCompanion.insert({
    required String id,
    required String quoteId,
    required int revisionNumber,
    required String snapshotJson,
    required int subtotalMicros,
    required int taxMicros,
    required int totalMicros,
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       quoteId = Value(quoteId),
       revisionNumber = Value(revisionNumber),
       snapshotJson = Value(snapshotJson),
       subtotalMicros = Value(subtotalMicros),
       taxMicros = Value(taxMicros),
       totalMicros = Value(totalMicros);
  static Insertable<QuoteRevision> custom({
    Expression<String>? id,
    Expression<String>? quoteId,
    Expression<int>? revisionNumber,
    Expression<String>? snapshotJson,
    Expression<int>? subtotalMicros,
    Expression<int>? taxMicros,
    Expression<int>? totalMicros,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteId != null) 'quote_id': quoteId,
      if (revisionNumber != null) 'revision_number': revisionNumber,
      if (snapshotJson != null) 'snapshot_json': snapshotJson,
      if (subtotalMicros != null) 'subtotal_micros': subtotalMicros,
      if (taxMicros != null) 'tax_micros': taxMicros,
      if (totalMicros != null) 'total_micros': totalMicros,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuoteRevisionsCompanion copyWith({
    Value<String>? id,
    Value<String>? quoteId,
    Value<int>? revisionNumber,
    Value<String>? snapshotJson,
    Value<int>? subtotalMicros,
    Value<int>? taxMicros,
    Value<int>? totalMicros,
    Value<String?>? reason,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return QuoteRevisionsCompanion(
      id: id ?? this.id,
      quoteId: quoteId ?? this.quoteId,
      revisionNumber: revisionNumber ?? this.revisionNumber,
      snapshotJson: snapshotJson ?? this.snapshotJson,
      subtotalMicros: subtotalMicros ?? this.subtotalMicros,
      taxMicros: taxMicros ?? this.taxMicros,
      totalMicros: totalMicros ?? this.totalMicros,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<String>(quoteId.value);
    }
    if (revisionNumber.present) {
      map['revision_number'] = Variable<int>(revisionNumber.value);
    }
    if (snapshotJson.present) {
      map['snapshot_json'] = Variable<String>(snapshotJson.value);
    }
    if (subtotalMicros.present) {
      map['subtotal_micros'] = Variable<int>(subtotalMicros.value);
    }
    if (taxMicros.present) {
      map['tax_micros'] = Variable<int>(taxMicros.value);
    }
    if (totalMicros.present) {
      map['total_micros'] = Variable<int>(totalMicros.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuoteRevisionsCompanion(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('revisionNumber: $revisionNumber, ')
          ..write('snapshotJson: $snapshotJson, ')
          ..write('subtotalMicros: $subtotalMicros, ')
          ..write('taxMicros: $taxMicros, ')
          ..write('totalMicros: $totalMicros, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JobsTable extends Jobs with TableInfo<$JobsTable, Job> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<String> quoteId = GeneratedColumn<String>(
    'quote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quotes (id)',
    ),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectJsonMeta = const VerificationMeta(
    'projectJson',
  );
  @override
  late final GeneratedColumn<String> projectJson = GeneratedColumn<String>(
    'project_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quoteId,
    state,
    sourceName,
    projectJson,
    createdAt,
    updatedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Job> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    }
    if (data.containsKey('project_json')) {
      context.handle(
        _projectJsonMeta,
        projectJson.isAcceptableOrUnknown(
          data['project_json']!,
          _projectJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_projectJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Job map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Job(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_id'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      ),
      projectJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }
}

class Job extends DataClass implements Insertable<Job> {
  final String id;
  final String? quoteId;
  final String state;
  final String? sourceName;
  final String projectJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  const Job({
    required this.id,
    this.quoteId,
    required this.state,
    this.sourceName,
    required this.projectJson,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || quoteId != null) {
      map['quote_id'] = Variable<String>(quoteId);
    }
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || sourceName != null) {
      map['source_name'] = Variable<String>(sourceName);
    }
    map['project_json'] = Variable<String>(projectJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      quoteId: quoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(quoteId),
      state: Value(state),
      sourceName: sourceName == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceName),
      projectJson: Value(projectJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Job.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Job(
      id: serializer.fromJson<String>(json['id']),
      quoteId: serializer.fromJson<String?>(json['quoteId']),
      state: serializer.fromJson<String>(json['state']),
      sourceName: serializer.fromJson<String?>(json['sourceName']),
      projectJson: serializer.fromJson<String>(json['projectJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'quoteId': serializer.toJson<String?>(quoteId),
      'state': serializer.toJson<String>(state),
      'sourceName': serializer.toJson<String?>(sourceName),
      'projectJson': serializer.toJson<String>(projectJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Job copyWith({
    String? id,
    Value<String?> quoteId = const Value.absent(),
    String? state,
    Value<String?> sourceName = const Value.absent(),
    String? projectJson,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => Job(
    id: id ?? this.id,
    quoteId: quoteId.present ? quoteId.value : this.quoteId,
    state: state ?? this.state,
    sourceName: sourceName.present ? sourceName.value : this.sourceName,
    projectJson: projectJson ?? this.projectJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  Job copyWithCompanion(JobsCompanion data) {
    return Job(
      id: data.id.present ? data.id.value : this.id,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      state: data.state.present ? data.state.value : this.state,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      projectJson: data.projectJson.present
          ? data.projectJson.value
          : this.projectJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Job(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('state: $state, ')
          ..write('sourceName: $sourceName, ')
          ..write('projectJson: $projectJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    quoteId,
    state,
    sourceName,
    projectJson,
    createdAt,
    updatedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Job &&
          other.id == this.id &&
          other.quoteId == this.quoteId &&
          other.state == this.state &&
          other.sourceName == this.sourceName &&
          other.projectJson == this.projectJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class JobsCompanion extends UpdateCompanion<Job> {
  final Value<String> id;
  final Value<String?> quoteId;
  final Value<String> state;
  final Value<String?> sourceName;
  final Value<String> projectJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.state = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.projectJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JobsCompanion.insert({
    required String id,
    this.quoteId = const Value.absent(),
    this.state = const Value.absent(),
    this.sourceName = const Value.absent(),
    required String projectJson,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       projectJson = Value(projectJson);
  static Insertable<Job> custom({
    Expression<String>? id,
    Expression<String>? quoteId,
    Expression<String>? state,
    Expression<String>? sourceName,
    Expression<String>? projectJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteId != null) 'quote_id': quoteId,
      if (state != null) 'state': state,
      if (sourceName != null) 'source_name': sourceName,
      if (projectJson != null) 'project_json': projectJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JobsCompanion copyWith({
    Value<String>? id,
    Value<String?>? quoteId,
    Value<String>? state,
    Value<String?>? sourceName,
    Value<String>? projectJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      quoteId: quoteId ?? this.quoteId,
      state: state ?? this.state,
      sourceName: sourceName ?? this.sourceName,
      projectJson: projectJson ?? this.projectJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<String>(quoteId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (projectJson.present) {
      map['project_json'] = Variable<String>(projectJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('quoteId: $quoteId, ')
          ..write('state: $state, ')
          ..write('sourceName: $sourceName, ')
          ..write('projectJson: $projectJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrintAttemptsTable extends PrintAttempts
    with TableInfo<$PrintAttemptsTable, PrintAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrintAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id)',
    ),
  );
  static const VerificationMeta _sequenceMeta = const VerificationMeta(
    'sequence',
  );
  @override
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
    'sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('planned'),
  );
  static const VerificationMeta _estimatedMassMgMeta = const VerificationMeta(
    'estimatedMassMg',
  );
  @override
  late final GeneratedColumn<int> estimatedMassMg = GeneratedColumn<int>(
    'estimated_mass_mg',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _actualMassMgMeta = const VerificationMeta(
    'actualMassMg',
  );
  @override
  late final GeneratedColumn<int> actualMassMg = GeneratedColumn<int>(
    'actual_mass_mg',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _elapsedSecondsMeta = const VerificationMeta(
    'elapsedSeconds',
  );
  @override
  late final GeneratedColumn<int> elapsedSeconds = GeneratedColumn<int>(
    'elapsed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failureReasonMeta = const VerificationMeta(
    'failureReason',
  );
  @override
  late final GeneratedColumn<String> failureReason = GeneratedColumn<String>(
    'failure_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobId,
    sequence,
    state,
    estimatedMassMg,
    actualMassMg,
    elapsedSeconds,
    failureReason,
    notes,
    startedAt,
    endedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'print_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrintAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('sequence')) {
      context.handle(
        _sequenceMeta,
        sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('estimated_mass_mg')) {
      context.handle(
        _estimatedMassMgMeta,
        estimatedMassMg.isAcceptableOrUnknown(
          data['estimated_mass_mg']!,
          _estimatedMassMgMeta,
        ),
      );
    }
    if (data.containsKey('actual_mass_mg')) {
      context.handle(
        _actualMassMgMeta,
        actualMassMg.isAcceptableOrUnknown(
          data['actual_mass_mg']!,
          _actualMassMgMeta,
        ),
      );
    }
    if (data.containsKey('elapsed_seconds')) {
      context.handle(
        _elapsedSecondsMeta,
        elapsedSeconds.isAcceptableOrUnknown(
          data['elapsed_seconds']!,
          _elapsedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('failure_reason')) {
      context.handle(
        _failureReasonMeta,
        failureReason.isAcceptableOrUnknown(
          data['failure_reason']!,
          _failureReasonMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {jobId, sequence},
  ];
  @override
  PrintAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrintAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      )!,
      sequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      estimatedMassMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_mass_mg'],
      )!,
      actualMassMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_mass_mg'],
      ),
      elapsedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_seconds'],
      )!,
      failureReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_reason'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PrintAttemptsTable createAlias(String alias) {
    return $PrintAttemptsTable(attachedDatabase, alias);
  }
}

class PrintAttempt extends DataClass implements Insertable<PrintAttempt> {
  final String id;
  final String jobId;
  final int sequence;
  final String state;
  final int estimatedMassMg;
  final int? actualMassMg;
  final int elapsedSeconds;
  final String? failureReason;
  final String? notes;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  const PrintAttempt({
    required this.id,
    required this.jobId,
    required this.sequence,
    required this.state,
    required this.estimatedMassMg,
    this.actualMassMg,
    required this.elapsedSeconds,
    this.failureReason,
    this.notes,
    this.startedAt,
    this.endedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['job_id'] = Variable<String>(jobId);
    map['sequence'] = Variable<int>(sequence);
    map['state'] = Variable<String>(state);
    map['estimated_mass_mg'] = Variable<int>(estimatedMassMg);
    if (!nullToAbsent || actualMassMg != null) {
      map['actual_mass_mg'] = Variable<int>(actualMassMg);
    }
    map['elapsed_seconds'] = Variable<int>(elapsedSeconds);
    if (!nullToAbsent || failureReason != null) {
      map['failure_reason'] = Variable<String>(failureReason);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrintAttemptsCompanion toCompanion(bool nullToAbsent) {
    return PrintAttemptsCompanion(
      id: Value(id),
      jobId: Value(jobId),
      sequence: Value(sequence),
      state: Value(state),
      estimatedMassMg: Value(estimatedMassMg),
      actualMassMg: actualMassMg == null && nullToAbsent
          ? const Value.absent()
          : Value(actualMassMg),
      elapsedSeconds: Value(elapsedSeconds),
      failureReason: failureReason == null && nullToAbsent
          ? const Value.absent()
          : Value(failureReason),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      createdAt: Value(createdAt),
    );
  }

  factory PrintAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrintAttempt(
      id: serializer.fromJson<String>(json['id']),
      jobId: serializer.fromJson<String>(json['jobId']),
      sequence: serializer.fromJson<int>(json['sequence']),
      state: serializer.fromJson<String>(json['state']),
      estimatedMassMg: serializer.fromJson<int>(json['estimatedMassMg']),
      actualMassMg: serializer.fromJson<int?>(json['actualMassMg']),
      elapsedSeconds: serializer.fromJson<int>(json['elapsedSeconds']),
      failureReason: serializer.fromJson<String?>(json['failureReason']),
      notes: serializer.fromJson<String?>(json['notes']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'jobId': serializer.toJson<String>(jobId),
      'sequence': serializer.toJson<int>(sequence),
      'state': serializer.toJson<String>(state),
      'estimatedMassMg': serializer.toJson<int>(estimatedMassMg),
      'actualMassMg': serializer.toJson<int?>(actualMassMg),
      'elapsedSeconds': serializer.toJson<int>(elapsedSeconds),
      'failureReason': serializer.toJson<String?>(failureReason),
      'notes': serializer.toJson<String?>(notes),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PrintAttempt copyWith({
    String? id,
    String? jobId,
    int? sequence,
    String? state,
    int? estimatedMassMg,
    Value<int?> actualMassMg = const Value.absent(),
    int? elapsedSeconds,
    Value<String?> failureReason = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> endedAt = const Value.absent(),
    DateTime? createdAt,
  }) => PrintAttempt(
    id: id ?? this.id,
    jobId: jobId ?? this.jobId,
    sequence: sequence ?? this.sequence,
    state: state ?? this.state,
    estimatedMassMg: estimatedMassMg ?? this.estimatedMassMg,
    actualMassMg: actualMassMg.present ? actualMassMg.value : this.actualMassMg,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    failureReason: failureReason.present
        ? failureReason.value
        : this.failureReason,
    notes: notes.present ? notes.value : this.notes,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  PrintAttempt copyWithCompanion(PrintAttemptsCompanion data) {
    return PrintAttempt(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      state: data.state.present ? data.state.value : this.state,
      estimatedMassMg: data.estimatedMassMg.present
          ? data.estimatedMassMg.value
          : this.estimatedMassMg,
      actualMassMg: data.actualMassMg.present
          ? data.actualMassMg.value
          : this.actualMassMg,
      elapsedSeconds: data.elapsedSeconds.present
          ? data.elapsedSeconds.value
          : this.elapsedSeconds,
      failureReason: data.failureReason.present
          ? data.failureReason.value
          : this.failureReason,
      notes: data.notes.present ? data.notes.value : this.notes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrintAttempt(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('sequence: $sequence, ')
          ..write('state: $state, ')
          ..write('estimatedMassMg: $estimatedMassMg, ')
          ..write('actualMassMg: $actualMassMg, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('failureReason: $failureReason, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    jobId,
    sequence,
    state,
    estimatedMassMg,
    actualMassMg,
    elapsedSeconds,
    failureReason,
    notes,
    startedAt,
    endedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrintAttempt &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.sequence == this.sequence &&
          other.state == this.state &&
          other.estimatedMassMg == this.estimatedMassMg &&
          other.actualMassMg == this.actualMassMg &&
          other.elapsedSeconds == this.elapsedSeconds &&
          other.failureReason == this.failureReason &&
          other.notes == this.notes &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.createdAt == this.createdAt);
}

class PrintAttemptsCompanion extends UpdateCompanion<PrintAttempt> {
  final Value<String> id;
  final Value<String> jobId;
  final Value<int> sequence;
  final Value<String> state;
  final Value<int> estimatedMassMg;
  final Value<int?> actualMassMg;
  final Value<int> elapsedSeconds;
  final Value<String?> failureReason;
  final Value<String?> notes;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> endedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PrintAttemptsCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.sequence = const Value.absent(),
    this.state = const Value.absent(),
    this.estimatedMassMg = const Value.absent(),
    this.actualMassMg = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.failureReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrintAttemptsCompanion.insert({
    required String id,
    required String jobId,
    required int sequence,
    this.state = const Value.absent(),
    this.estimatedMassMg = const Value.absent(),
    this.actualMassMg = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.failureReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       jobId = Value(jobId),
       sequence = Value(sequence);
  static Insertable<PrintAttempt> custom({
    Expression<String>? id,
    Expression<String>? jobId,
    Expression<int>? sequence,
    Expression<String>? state,
    Expression<int>? estimatedMassMg,
    Expression<int>? actualMassMg,
    Expression<int>? elapsedSeconds,
    Expression<String>? failureReason,
    Expression<String>? notes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (sequence != null) 'sequence': sequence,
      if (state != null) 'state': state,
      if (estimatedMassMg != null) 'estimated_mass_mg': estimatedMassMg,
      if (actualMassMg != null) 'actual_mass_mg': actualMassMg,
      if (elapsedSeconds != null) 'elapsed_seconds': elapsedSeconds,
      if (failureReason != null) 'failure_reason': failureReason,
      if (notes != null) 'notes': notes,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrintAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? jobId,
    Value<int>? sequence,
    Value<String>? state,
    Value<int>? estimatedMassMg,
    Value<int?>? actualMassMg,
    Value<int>? elapsedSeconds,
    Value<String?>? failureReason,
    Value<String?>? notes,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? endedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PrintAttemptsCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      sequence: sequence ?? this.sequence,
      state: state ?? this.state,
      estimatedMassMg: estimatedMassMg ?? this.estimatedMassMg,
      actualMassMg: actualMassMg ?? this.actualMassMg,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      failureReason: failureReason ?? this.failureReason,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (estimatedMassMg.present) {
      map['estimated_mass_mg'] = Variable<int>(estimatedMassMg.value);
    }
    if (actualMassMg.present) {
      map['actual_mass_mg'] = Variable<int>(actualMassMg.value);
    }
    if (elapsedSeconds.present) {
      map['elapsed_seconds'] = Variable<int>(elapsedSeconds.value);
    }
    if (failureReason.present) {
      map['failure_reason'] = Variable<String>(failureReason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrintAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('sequence: $sequence, ')
          ..write('state: $state, ')
          ..write('estimatedMassMg: $estimatedMassMg, ')
          ..write('actualMassMg: $actualMassMg, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('failureReason: $failureReason, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryTransactionsTable extends InventoryTransactions
    with TableInfo<$InventoryTransactionsTable, InventoryTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spoolIdMeta = const VerificationMeta(
    'spoolId',
  );
  @override
  late final GeneratedColumn<String> spoolId = GeneratedColumn<String>(
    'spool_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES spools (id)',
    ),
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
    'job_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id)',
    ),
  );
  static const VerificationMeta _attemptIdMeta = const VerificationMeta(
    'attemptId',
  );
  @override
  late final GeneratedColumn<String> attemptId = GeneratedColumn<String>(
    'attempt_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES print_attempts (id)',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaMassMgMeta = const VerificationMeta(
    'deltaMassMg',
  );
  @override
  late final GeneratedColumn<int> deltaMassMg = GeneratedColumn<int>(
    'delta_mass_mg',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reversalOfTransactionIdMeta =
      const VerificationMeta('reversalOfTransactionId');
  @override
  late final GeneratedColumn<String> reversalOfTransactionId =
      GeneratedColumn<String>(
        'reversal_of_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    spoolId,
    jobId,
    attemptId,
    kind,
    deltaMassMg,
    note,
    reversalOfTransactionId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('spool_id')) {
      context.handle(
        _spoolIdMeta,
        spoolId.isAcceptableOrUnknown(data['spool_id']!, _spoolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_spoolIdMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    }
    if (data.containsKey('attempt_id')) {
      context.handle(
        _attemptIdMeta,
        attemptId.isAcceptableOrUnknown(data['attempt_id']!, _attemptIdMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('delta_mass_mg')) {
      context.handle(
        _deltaMassMgMeta,
        deltaMassMg.isAcceptableOrUnknown(
          data['delta_mass_mg']!,
          _deltaMassMgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deltaMassMgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('reversal_of_transaction_id')) {
      context.handle(
        _reversalOfTransactionIdMeta,
        reversalOfTransactionId.isAcceptableOrUnknown(
          data['reversal_of_transaction_id']!,
          _reversalOfTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      spoolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spool_id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      ),
      attemptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempt_id'],
      ),
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      deltaMassMg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delta_mass_mg'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      reversalOfTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reversal_of_transaction_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InventoryTransactionsTable createAlias(String alias) {
    return $InventoryTransactionsTable(attachedDatabase, alias);
  }
}

class InventoryTransaction extends DataClass
    implements Insertable<InventoryTransaction> {
  final String id;
  final String spoolId;
  final String? jobId;
  final String? attemptId;
  final String kind;
  final int deltaMassMg;
  final String? note;
  final String? reversalOfTransactionId;
  final DateTime createdAt;
  const InventoryTransaction({
    required this.id,
    required this.spoolId,
    this.jobId,
    this.attemptId,
    required this.kind,
    required this.deltaMassMg,
    this.note,
    this.reversalOfTransactionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['spool_id'] = Variable<String>(spoolId);
    if (!nullToAbsent || jobId != null) {
      map['job_id'] = Variable<String>(jobId);
    }
    if (!nullToAbsent || attemptId != null) {
      map['attempt_id'] = Variable<String>(attemptId);
    }
    map['kind'] = Variable<String>(kind);
    map['delta_mass_mg'] = Variable<int>(deltaMassMg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || reversalOfTransactionId != null) {
      map['reversal_of_transaction_id'] = Variable<String>(
        reversalOfTransactionId,
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InventoryTransactionsCompanion toCompanion(bool nullToAbsent) {
    return InventoryTransactionsCompanion(
      id: Value(id),
      spoolId: Value(spoolId),
      jobId: jobId == null && nullToAbsent
          ? const Value.absent()
          : Value(jobId),
      attemptId: attemptId == null && nullToAbsent
          ? const Value.absent()
          : Value(attemptId),
      kind: Value(kind),
      deltaMassMg: Value(deltaMassMg),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      reversalOfTransactionId: reversalOfTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(reversalOfTransactionId),
      createdAt: Value(createdAt),
    );
  }

  factory InventoryTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryTransaction(
      id: serializer.fromJson<String>(json['id']),
      spoolId: serializer.fromJson<String>(json['spoolId']),
      jobId: serializer.fromJson<String?>(json['jobId']),
      attemptId: serializer.fromJson<String?>(json['attemptId']),
      kind: serializer.fromJson<String>(json['kind']),
      deltaMassMg: serializer.fromJson<int>(json['deltaMassMg']),
      note: serializer.fromJson<String?>(json['note']),
      reversalOfTransactionId: serializer.fromJson<String?>(
        json['reversalOfTransactionId'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'spoolId': serializer.toJson<String>(spoolId),
      'jobId': serializer.toJson<String?>(jobId),
      'attemptId': serializer.toJson<String?>(attemptId),
      'kind': serializer.toJson<String>(kind),
      'deltaMassMg': serializer.toJson<int>(deltaMassMg),
      'note': serializer.toJson<String?>(note),
      'reversalOfTransactionId': serializer.toJson<String?>(
        reversalOfTransactionId,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InventoryTransaction copyWith({
    String? id,
    String? spoolId,
    Value<String?> jobId = const Value.absent(),
    Value<String?> attemptId = const Value.absent(),
    String? kind,
    int? deltaMassMg,
    Value<String?> note = const Value.absent(),
    Value<String?> reversalOfTransactionId = const Value.absent(),
    DateTime? createdAt,
  }) => InventoryTransaction(
    id: id ?? this.id,
    spoolId: spoolId ?? this.spoolId,
    jobId: jobId.present ? jobId.value : this.jobId,
    attemptId: attemptId.present ? attemptId.value : this.attemptId,
    kind: kind ?? this.kind,
    deltaMassMg: deltaMassMg ?? this.deltaMassMg,
    note: note.present ? note.value : this.note,
    reversalOfTransactionId: reversalOfTransactionId.present
        ? reversalOfTransactionId.value
        : this.reversalOfTransactionId,
    createdAt: createdAt ?? this.createdAt,
  );
  InventoryTransaction copyWithCompanion(InventoryTransactionsCompanion data) {
    return InventoryTransaction(
      id: data.id.present ? data.id.value : this.id,
      spoolId: data.spoolId.present ? data.spoolId.value : this.spoolId,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      attemptId: data.attemptId.present ? data.attemptId.value : this.attemptId,
      kind: data.kind.present ? data.kind.value : this.kind,
      deltaMassMg: data.deltaMassMg.present
          ? data.deltaMassMg.value
          : this.deltaMassMg,
      note: data.note.present ? data.note.value : this.note,
      reversalOfTransactionId: data.reversalOfTransactionId.present
          ? data.reversalOfTransactionId.value
          : this.reversalOfTransactionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransaction(')
          ..write('id: $id, ')
          ..write('spoolId: $spoolId, ')
          ..write('jobId: $jobId, ')
          ..write('attemptId: $attemptId, ')
          ..write('kind: $kind, ')
          ..write('deltaMassMg: $deltaMassMg, ')
          ..write('note: $note, ')
          ..write('reversalOfTransactionId: $reversalOfTransactionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    spoolId,
    jobId,
    attemptId,
    kind,
    deltaMassMg,
    note,
    reversalOfTransactionId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryTransaction &&
          other.id == this.id &&
          other.spoolId == this.spoolId &&
          other.jobId == this.jobId &&
          other.attemptId == this.attemptId &&
          other.kind == this.kind &&
          other.deltaMassMg == this.deltaMassMg &&
          other.note == this.note &&
          other.reversalOfTransactionId == this.reversalOfTransactionId &&
          other.createdAt == this.createdAt);
}

class InventoryTransactionsCompanion
    extends UpdateCompanion<InventoryTransaction> {
  final Value<String> id;
  final Value<String> spoolId;
  final Value<String?> jobId;
  final Value<String?> attemptId;
  final Value<String> kind;
  final Value<int> deltaMassMg;
  final Value<String?> note;
  final Value<String?> reversalOfTransactionId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InventoryTransactionsCompanion({
    this.id = const Value.absent(),
    this.spoolId = const Value.absent(),
    this.jobId = const Value.absent(),
    this.attemptId = const Value.absent(),
    this.kind = const Value.absent(),
    this.deltaMassMg = const Value.absent(),
    this.note = const Value.absent(),
    this.reversalOfTransactionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryTransactionsCompanion.insert({
    required String id,
    required String spoolId,
    this.jobId = const Value.absent(),
    this.attemptId = const Value.absent(),
    required String kind,
    required int deltaMassMg,
    this.note = const Value.absent(),
    this.reversalOfTransactionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       spoolId = Value(spoolId),
       kind = Value(kind),
       deltaMassMg = Value(deltaMassMg);
  static Insertable<InventoryTransaction> custom({
    Expression<String>? id,
    Expression<String>? spoolId,
    Expression<String>? jobId,
    Expression<String>? attemptId,
    Expression<String>? kind,
    Expression<int>? deltaMassMg,
    Expression<String>? note,
    Expression<String>? reversalOfTransactionId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (spoolId != null) 'spool_id': spoolId,
      if (jobId != null) 'job_id': jobId,
      if (attemptId != null) 'attempt_id': attemptId,
      if (kind != null) 'kind': kind,
      if (deltaMassMg != null) 'delta_mass_mg': deltaMassMg,
      if (note != null) 'note': note,
      if (reversalOfTransactionId != null)
        'reversal_of_transaction_id': reversalOfTransactionId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? spoolId,
    Value<String?>? jobId,
    Value<String?>? attemptId,
    Value<String>? kind,
    Value<int>? deltaMassMg,
    Value<String?>? note,
    Value<String?>? reversalOfTransactionId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InventoryTransactionsCompanion(
      id: id ?? this.id,
      spoolId: spoolId ?? this.spoolId,
      jobId: jobId ?? this.jobId,
      attemptId: attemptId ?? this.attemptId,
      kind: kind ?? this.kind,
      deltaMassMg: deltaMassMg ?? this.deltaMassMg,
      note: note ?? this.note,
      reversalOfTransactionId:
          reversalOfTransactionId ?? this.reversalOfTransactionId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (spoolId.present) {
      map['spool_id'] = Variable<String>(spoolId.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (attemptId.present) {
      map['attempt_id'] = Variable<String>(attemptId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (deltaMassMg.present) {
      map['delta_mass_mg'] = Variable<int>(deltaMassMg.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (reversalOfTransactionId.present) {
      map['reversal_of_transaction_id'] = Variable<String>(
        reversalOfTransactionId.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('spoolId: $spoolId, ')
          ..write('jobId: $jobId, ')
          ..write('attemptId: $attemptId, ')
          ..write('kind: $kind, ')
          ..write('deltaMassMg: $deltaMassMg, ')
          ..write('note: $note, ')
          ..write('reversalOfTransactionId: $reversalOfTransactionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MarketplacePresetsTable extends MarketplacePresets
    with TableInfo<$MarketplacePresetsTable, MarketplacePreset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MarketplacePresetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _percentageBasisPointsMeta =
      const VerificationMeta('percentageBasisPoints');
  @override
  late final GeneratedColumn<int> percentageBasisPoints = GeneratedColumn<int>(
    'percentage_basis_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fixedFeeMicrosMeta = const VerificationMeta(
    'fixedFeeMicros',
  );
  @override
  late final GeneratedColumn<int> fixedFeeMicros = GeneratedColumn<int>(
    'fixed_fee_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('AED'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    percentageBasisPoints,
    fixedFeeMicros,
    currencyCode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'marketplace_presets';
  @override
  VerificationContext validateIntegrity(
    Insertable<MarketplacePreset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('percentage_basis_points')) {
      context.handle(
        _percentageBasisPointsMeta,
        percentageBasisPoints.isAcceptableOrUnknown(
          data['percentage_basis_points']!,
          _percentageBasisPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_percentageBasisPointsMeta);
    }
    if (data.containsKey('fixed_fee_micros')) {
      context.handle(
        _fixedFeeMicrosMeta,
        fixedFeeMicros.isAcceptableOrUnknown(
          data['fixed_fee_micros']!,
          _fixedFeeMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fixedFeeMicrosMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MarketplacePreset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MarketplacePreset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      percentageBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}percentage_basis_points'],
      )!,
      fixedFeeMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixed_fee_micros'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MarketplacePresetsTable createAlias(String alias) {
    return $MarketplacePresetsTable(attachedDatabase, alias);
  }
}

class MarketplacePreset extends DataClass
    implements Insertable<MarketplacePreset> {
  final String id;
  final String name;
  final int percentageBasisPoints;
  final int fixedFeeMicros;
  final String currencyCode;
  final DateTime createdAt;
  const MarketplacePreset({
    required this.id,
    required this.name,
    required this.percentageBasisPoints,
    required this.fixedFeeMicros,
    required this.currencyCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['percentage_basis_points'] = Variable<int>(percentageBasisPoints);
    map['fixed_fee_micros'] = Variable<int>(fixedFeeMicros);
    map['currency_code'] = Variable<String>(currencyCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MarketplacePresetsCompanion toCompanion(bool nullToAbsent) {
    return MarketplacePresetsCompanion(
      id: Value(id),
      name: Value(name),
      percentageBasisPoints: Value(percentageBasisPoints),
      fixedFeeMicros: Value(fixedFeeMicros),
      currencyCode: Value(currencyCode),
      createdAt: Value(createdAt),
    );
  }

  factory MarketplacePreset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MarketplacePreset(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      percentageBasisPoints: serializer.fromJson<int>(
        json['percentageBasisPoints'],
      ),
      fixedFeeMicros: serializer.fromJson<int>(json['fixedFeeMicros']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'percentageBasisPoints': serializer.toJson<int>(percentageBasisPoints),
      'fixedFeeMicros': serializer.toJson<int>(fixedFeeMicros),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MarketplacePreset copyWith({
    String? id,
    String? name,
    int? percentageBasisPoints,
    int? fixedFeeMicros,
    String? currencyCode,
    DateTime? createdAt,
  }) => MarketplacePreset(
    id: id ?? this.id,
    name: name ?? this.name,
    percentageBasisPoints: percentageBasisPoints ?? this.percentageBasisPoints,
    fixedFeeMicros: fixedFeeMicros ?? this.fixedFeeMicros,
    currencyCode: currencyCode ?? this.currencyCode,
    createdAt: createdAt ?? this.createdAt,
  );
  MarketplacePreset copyWithCompanion(MarketplacePresetsCompanion data) {
    return MarketplacePreset(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      percentageBasisPoints: data.percentageBasisPoints.present
          ? data.percentageBasisPoints.value
          : this.percentageBasisPoints,
      fixedFeeMicros: data.fixedFeeMicros.present
          ? data.fixedFeeMicros.value
          : this.fixedFeeMicros,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MarketplacePreset(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('percentageBasisPoints: $percentageBasisPoints, ')
          ..write('fixedFeeMicros: $fixedFeeMicros, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    percentageBasisPoints,
    fixedFeeMicros,
    currencyCode,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MarketplacePreset &&
          other.id == this.id &&
          other.name == this.name &&
          other.percentageBasisPoints == this.percentageBasisPoints &&
          other.fixedFeeMicros == this.fixedFeeMicros &&
          other.currencyCode == this.currencyCode &&
          other.createdAt == this.createdAt);
}

class MarketplacePresetsCompanion extends UpdateCompanion<MarketplacePreset> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> percentageBasisPoints;
  final Value<int> fixedFeeMicros;
  final Value<String> currencyCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MarketplacePresetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.percentageBasisPoints = const Value.absent(),
    this.fixedFeeMicros = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MarketplacePresetsCompanion.insert({
    required String id,
    required String name,
    required int percentageBasisPoints,
    required int fixedFeeMicros,
    this.currencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       percentageBasisPoints = Value(percentageBasisPoints),
       fixedFeeMicros = Value(fixedFeeMicros);
  static Insertable<MarketplacePreset> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? percentageBasisPoints,
    Expression<int>? fixedFeeMicros,
    Expression<String>? currencyCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (percentageBasisPoints != null)
        'percentage_basis_points': percentageBasisPoints,
      if (fixedFeeMicros != null) 'fixed_fee_micros': fixedFeeMicros,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MarketplacePresetsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? percentageBasisPoints,
    Value<int>? fixedFeeMicros,
    Value<String>? currencyCode,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MarketplacePresetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      percentageBasisPoints:
          percentageBasisPoints ?? this.percentageBasisPoints,
      fixedFeeMicros: fixedFeeMicros ?? this.fixedFeeMicros,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (percentageBasisPoints.present) {
      map['percentage_basis_points'] = Variable<int>(
        percentageBasisPoints.value,
      );
    }
    if (fixedFeeMicros.present) {
      map['fixed_fee_micros'] = Variable<int>(fixedFeeMicros.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MarketplacePresetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('percentageBasisPoints: $percentageBasisPoints, ')
          ..write('fixedFeeMicros: $fixedFeeMicros, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BusinessProfilesTable extends BusinessProfiles
    with TableInfo<$BusinessProfilesTable, BusinessProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinessProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessNameMeta = const VerificationMeta(
    'businessName',
  );
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>(
    'business_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressEnglishMeta = const VerificationMeta(
    'addressEnglish',
  );
  @override
  late final GeneratedColumn<String> addressEnglish = GeneratedColumn<String>(
    'address_english',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressArabicMeta = const VerificationMeta(
    'addressArabic',
  );
  @override
  late final GeneratedColumn<String> addressArabic = GeneratedColumn<String>(
    'address_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trnMeta = const VerificationMeta('trn');
  @override
  late final GeneratedColumn<String> trn = GeneratedColumn<String>(
    'trn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vatBasisPointsMeta = const VerificationMeta(
    'vatBasisPoints',
  );
  @override
  late final GeneratedColumn<int> vatBasisPoints = GeneratedColumn<int>(
    'vat_basis_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _termsEnglishMeta = const VerificationMeta(
    'termsEnglish',
  );
  @override
  late final GeneratedColumn<String> termsEnglish = GeneratedColumn<String>(
    'terms_english',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termsArabicMeta = const VerificationMeta(
    'termsArabic',
  );
  @override
  late final GeneratedColumn<String> termsArabic = GeneratedColumn<String>(
    'terms_arabic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    businessName,
    logoPath,
    phone,
    email,
    addressEnglish,
    addressArabic,
    trn,
    vatBasisPoints,
    termsEnglish,
    termsArabic,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'business_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<BusinessProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('business_name')) {
      context.handle(
        _businessNameMeta,
        businessName.isAcceptableOrUnknown(
          data['business_name']!,
          _businessNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_businessNameMeta);
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address_english')) {
      context.handle(
        _addressEnglishMeta,
        addressEnglish.isAcceptableOrUnknown(
          data['address_english']!,
          _addressEnglishMeta,
        ),
      );
    }
    if (data.containsKey('address_arabic')) {
      context.handle(
        _addressArabicMeta,
        addressArabic.isAcceptableOrUnknown(
          data['address_arabic']!,
          _addressArabicMeta,
        ),
      );
    }
    if (data.containsKey('trn')) {
      context.handle(
        _trnMeta,
        trn.isAcceptableOrUnknown(data['trn']!, _trnMeta),
      );
    }
    if (data.containsKey('vat_basis_points')) {
      context.handle(
        _vatBasisPointsMeta,
        vatBasisPoints.isAcceptableOrUnknown(
          data['vat_basis_points']!,
          _vatBasisPointsMeta,
        ),
      );
    }
    if (data.containsKey('terms_english')) {
      context.handle(
        _termsEnglishMeta,
        termsEnglish.isAcceptableOrUnknown(
          data['terms_english']!,
          _termsEnglishMeta,
        ),
      );
    }
    if (data.containsKey('terms_arabic')) {
      context.handle(
        _termsArabicMeta,
        termsArabic.isAcceptableOrUnknown(
          data['terms_arabic']!,
          _termsArabicMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusinessProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      businessName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_name'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      addressEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_english'],
      ),
      addressArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_arabic'],
      ),
      trn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trn'],
      ),
      vatBasisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_basis_points'],
      )!,
      termsEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms_english'],
      ),
      termsArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms_arabic'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BusinessProfilesTable createAlias(String alias) {
    return $BusinessProfilesTable(attachedDatabase, alias);
  }
}

class BusinessProfile extends DataClass implements Insertable<BusinessProfile> {
  final String id;
  final String businessName;
  final String? logoPath;
  final String? phone;
  final String? email;
  final String? addressEnglish;
  final String? addressArabic;
  final String? trn;
  final int vatBasisPoints;
  final String? termsEnglish;
  final String? termsArabic;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BusinessProfile({
    required this.id,
    required this.businessName,
    this.logoPath,
    this.phone,
    this.email,
    this.addressEnglish,
    this.addressArabic,
    this.trn,
    required this.vatBasisPoints,
    this.termsEnglish,
    this.termsArabic,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['business_name'] = Variable<String>(businessName);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || addressEnglish != null) {
      map['address_english'] = Variable<String>(addressEnglish);
    }
    if (!nullToAbsent || addressArabic != null) {
      map['address_arabic'] = Variable<String>(addressArabic);
    }
    if (!nullToAbsent || trn != null) {
      map['trn'] = Variable<String>(trn);
    }
    map['vat_basis_points'] = Variable<int>(vatBasisPoints);
    if (!nullToAbsent || termsEnglish != null) {
      map['terms_english'] = Variable<String>(termsEnglish);
    }
    if (!nullToAbsent || termsArabic != null) {
      map['terms_arabic'] = Variable<String>(termsArabic);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BusinessProfilesCompanion toCompanion(bool nullToAbsent) {
    return BusinessProfilesCompanion(
      id: Value(id),
      businessName: Value(businessName),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      addressEnglish: addressEnglish == null && nullToAbsent
          ? const Value.absent()
          : Value(addressEnglish),
      addressArabic: addressArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(addressArabic),
      trn: trn == null && nullToAbsent ? const Value.absent() : Value(trn),
      vatBasisPoints: Value(vatBasisPoints),
      termsEnglish: termsEnglish == null && nullToAbsent
          ? const Value.absent()
          : Value(termsEnglish),
      termsArabic: termsArabic == null && nullToAbsent
          ? const Value.absent()
          : Value(termsArabic),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BusinessProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessProfile(
      id: serializer.fromJson<String>(json['id']),
      businessName: serializer.fromJson<String>(json['businessName']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      addressEnglish: serializer.fromJson<String?>(json['addressEnglish']),
      addressArabic: serializer.fromJson<String?>(json['addressArabic']),
      trn: serializer.fromJson<String?>(json['trn']),
      vatBasisPoints: serializer.fromJson<int>(json['vatBasisPoints']),
      termsEnglish: serializer.fromJson<String?>(json['termsEnglish']),
      termsArabic: serializer.fromJson<String?>(json['termsArabic']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'businessName': serializer.toJson<String>(businessName),
      'logoPath': serializer.toJson<String?>(logoPath),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'addressEnglish': serializer.toJson<String?>(addressEnglish),
      'addressArabic': serializer.toJson<String?>(addressArabic),
      'trn': serializer.toJson<String?>(trn),
      'vatBasisPoints': serializer.toJson<int>(vatBasisPoints),
      'termsEnglish': serializer.toJson<String?>(termsEnglish),
      'termsArabic': serializer.toJson<String?>(termsArabic),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BusinessProfile copyWith({
    String? id,
    String? businessName,
    Value<String?> logoPath = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> addressEnglish = const Value.absent(),
    Value<String?> addressArabic = const Value.absent(),
    Value<String?> trn = const Value.absent(),
    int? vatBasisPoints,
    Value<String?> termsEnglish = const Value.absent(),
    Value<String?> termsArabic = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BusinessProfile(
    id: id ?? this.id,
    businessName: businessName ?? this.businessName,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    addressEnglish: addressEnglish.present
        ? addressEnglish.value
        : this.addressEnglish,
    addressArabic: addressArabic.present
        ? addressArabic.value
        : this.addressArabic,
    trn: trn.present ? trn.value : this.trn,
    vatBasisPoints: vatBasisPoints ?? this.vatBasisPoints,
    termsEnglish: termsEnglish.present ? termsEnglish.value : this.termsEnglish,
    termsArabic: termsArabic.present ? termsArabic.value : this.termsArabic,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BusinessProfile copyWithCompanion(BusinessProfilesCompanion data) {
    return BusinessProfile(
      id: data.id.present ? data.id.value : this.id,
      businessName: data.businessName.present
          ? data.businessName.value
          : this.businessName,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      addressEnglish: data.addressEnglish.present
          ? data.addressEnglish.value
          : this.addressEnglish,
      addressArabic: data.addressArabic.present
          ? data.addressArabic.value
          : this.addressArabic,
      trn: data.trn.present ? data.trn.value : this.trn,
      vatBasisPoints: data.vatBasisPoints.present
          ? data.vatBasisPoints.value
          : this.vatBasisPoints,
      termsEnglish: data.termsEnglish.present
          ? data.termsEnglish.value
          : this.termsEnglish,
      termsArabic: data.termsArabic.present
          ? data.termsArabic.value
          : this.termsArabic,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessProfile(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('logoPath: $logoPath, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('addressEnglish: $addressEnglish, ')
          ..write('addressArabic: $addressArabic, ')
          ..write('trn: $trn, ')
          ..write('vatBasisPoints: $vatBasisPoints, ')
          ..write('termsEnglish: $termsEnglish, ')
          ..write('termsArabic: $termsArabic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    businessName,
    logoPath,
    phone,
    email,
    addressEnglish,
    addressArabic,
    trn,
    vatBasisPoints,
    termsEnglish,
    termsArabic,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessProfile &&
          other.id == this.id &&
          other.businessName == this.businessName &&
          other.logoPath == this.logoPath &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.addressEnglish == this.addressEnglish &&
          other.addressArabic == this.addressArabic &&
          other.trn == this.trn &&
          other.vatBasisPoints == this.vatBasisPoints &&
          other.termsEnglish == this.termsEnglish &&
          other.termsArabic == this.termsArabic &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BusinessProfilesCompanion extends UpdateCompanion<BusinessProfile> {
  final Value<String> id;
  final Value<String> businessName;
  final Value<String?> logoPath;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> addressEnglish;
  final Value<String?> addressArabic;
  final Value<String?> trn;
  final Value<int> vatBasisPoints;
  final Value<String?> termsEnglish;
  final Value<String?> termsArabic;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BusinessProfilesCompanion({
    this.id = const Value.absent(),
    this.businessName = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.addressEnglish = const Value.absent(),
    this.addressArabic = const Value.absent(),
    this.trn = const Value.absent(),
    this.vatBasisPoints = const Value.absent(),
    this.termsEnglish = const Value.absent(),
    this.termsArabic = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BusinessProfilesCompanion.insert({
    required String id,
    required String businessName,
    this.logoPath = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.addressEnglish = const Value.absent(),
    this.addressArabic = const Value.absent(),
    this.trn = const Value.absent(),
    this.vatBasisPoints = const Value.absent(),
    this.termsEnglish = const Value.absent(),
    this.termsArabic = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       businessName = Value(businessName);
  static Insertable<BusinessProfile> custom({
    Expression<String>? id,
    Expression<String>? businessName,
    Expression<String>? logoPath,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? addressEnglish,
    Expression<String>? addressArabic,
    Expression<String>? trn,
    Expression<int>? vatBasisPoints,
    Expression<String>? termsEnglish,
    Expression<String>? termsArabic,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessName != null) 'business_name': businessName,
      if (logoPath != null) 'logo_path': logoPath,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (addressEnglish != null) 'address_english': addressEnglish,
      if (addressArabic != null) 'address_arabic': addressArabic,
      if (trn != null) 'trn': trn,
      if (vatBasisPoints != null) 'vat_basis_points': vatBasisPoints,
      if (termsEnglish != null) 'terms_english': termsEnglish,
      if (termsArabic != null) 'terms_arabic': termsArabic,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BusinessProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? businessName,
    Value<String?>? logoPath,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? addressEnglish,
    Value<String?>? addressArabic,
    Value<String?>? trn,
    Value<int>? vatBasisPoints,
    Value<String?>? termsEnglish,
    Value<String?>? termsArabic,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BusinessProfilesCompanion(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      logoPath: logoPath ?? this.logoPath,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      addressEnglish: addressEnglish ?? this.addressEnglish,
      addressArabic: addressArabic ?? this.addressArabic,
      trn: trn ?? this.trn,
      vatBasisPoints: vatBasisPoints ?? this.vatBasisPoints,
      termsEnglish: termsEnglish ?? this.termsEnglish,
      termsArabic: termsArabic ?? this.termsArabic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (addressEnglish.present) {
      map['address_english'] = Variable<String>(addressEnglish.value);
    }
    if (addressArabic.present) {
      map['address_arabic'] = Variable<String>(addressArabic.value);
    }
    if (trn.present) {
      map['trn'] = Variable<String>(trn.value);
    }
    if (vatBasisPoints.present) {
      map['vat_basis_points'] = Variable<int>(vatBasisPoints.value);
    }
    if (termsEnglish.present) {
      map['terms_english'] = Variable<String>(termsEnglish.value);
    }
    if (termsArabic.present) {
      map['terms_arabic'] = Variable<String>(termsArabic.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusinessProfilesCompanion(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('logoPath: $logoPath, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('addressEnglish: $addressEnglish, ')
          ..write('addressArabic: $addressArabic, ')
          ..write('trn: $trn, ')
          ..write('vatBasisPoints: $vatBasisPoints, ')
          ..write('termsEnglish: $termsEnglish, ')
          ..write('termsArabic: $termsArabic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupMetadataTable extends BackupMetadata
    with TableInfo<$BackupMetadataTable, BackupMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256HexMeta = const VerificationMeta(
    'sha256Hex',
  );
  @override
  late final GeneratedColumn<String> sha256Hex = GeneratedColumn<String>(
    'sha256_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _restoredAtMeta = const VerificationMeta(
    'restoredAt',
  );
  @override
  late final GeneratedColumn<DateTime> restoredAt = GeneratedColumn<DateTime>(
    'restored_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    schemaVersion,
    sha256Hex,
    fileName,
    createdAt,
    restoredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('sha256_hex')) {
      context.handle(
        _sha256HexMeta,
        sha256Hex.isAcceptableOrUnknown(data['sha256_hex']!, _sha256HexMeta),
      );
    } else if (isInserting) {
      context.missing(_sha256HexMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('restored_at')) {
      context.handle(
        _restoredAtMeta,
        restoredAt.isAcceptableOrUnknown(data['restored_at']!, _restoredAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupMetadataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
      sha256Hex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256_hex'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      restoredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}restored_at'],
      ),
    );
  }

  @override
  $BackupMetadataTable createAlias(String alias) {
    return $BackupMetadataTable(attachedDatabase, alias);
  }
}

class BackupMetadataData extends DataClass
    implements Insertable<BackupMetadataData> {
  final String id;
  final int schemaVersion;
  final String sha256Hex;
  final String? fileName;
  final DateTime createdAt;
  final DateTime? restoredAt;
  const BackupMetadataData({
    required this.id,
    required this.schemaVersion,
    required this.sha256Hex,
    this.fileName,
    required this.createdAt,
    this.restoredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['sha256_hex'] = Variable<String>(sha256Hex);
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || restoredAt != null) {
      map['restored_at'] = Variable<DateTime>(restoredAt);
    }
    return map;
  }

  BackupMetadataCompanion toCompanion(bool nullToAbsent) {
    return BackupMetadataCompanion(
      id: Value(id),
      schemaVersion: Value(schemaVersion),
      sha256Hex: Value(sha256Hex),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
      createdAt: Value(createdAt),
      restoredAt: restoredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(restoredAt),
    );
  }

  factory BackupMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupMetadataData(
      id: serializer.fromJson<String>(json['id']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      sha256Hex: serializer.fromJson<String>(json['sha256Hex']),
      fileName: serializer.fromJson<String?>(json['fileName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      restoredAt: serializer.fromJson<DateTime?>(json['restoredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'sha256Hex': serializer.toJson<String>(sha256Hex),
      'fileName': serializer.toJson<String?>(fileName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'restoredAt': serializer.toJson<DateTime?>(restoredAt),
    };
  }

  BackupMetadataData copyWith({
    String? id,
    int? schemaVersion,
    String? sha256Hex,
    Value<String?> fileName = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> restoredAt = const Value.absent(),
  }) => BackupMetadataData(
    id: id ?? this.id,
    schemaVersion: schemaVersion ?? this.schemaVersion,
    sha256Hex: sha256Hex ?? this.sha256Hex,
    fileName: fileName.present ? fileName.value : this.fileName,
    createdAt: createdAt ?? this.createdAt,
    restoredAt: restoredAt.present ? restoredAt.value : this.restoredAt,
  );
  BackupMetadataData copyWithCompanion(BackupMetadataCompanion data) {
    return BackupMetadataData(
      id: data.id.present ? data.id.value : this.id,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      sha256Hex: data.sha256Hex.present ? data.sha256Hex.value : this.sha256Hex,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      restoredAt: data.restoredAt.present
          ? data.restoredAt.value
          : this.restoredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataData(')
          ..write('id: $id, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('sha256Hex: $sha256Hex, ')
          ..write('fileName: $fileName, ')
          ..write('createdAt: $createdAt, ')
          ..write('restoredAt: $restoredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    schemaVersion,
    sha256Hex,
    fileName,
    createdAt,
    restoredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupMetadataData &&
          other.id == this.id &&
          other.schemaVersion == this.schemaVersion &&
          other.sha256Hex == this.sha256Hex &&
          other.fileName == this.fileName &&
          other.createdAt == this.createdAt &&
          other.restoredAt == this.restoredAt);
}

class BackupMetadataCompanion extends UpdateCompanion<BackupMetadataData> {
  final Value<String> id;
  final Value<int> schemaVersion;
  final Value<String> sha256Hex;
  final Value<String?> fileName;
  final Value<DateTime> createdAt;
  final Value<DateTime?> restoredAt;
  final Value<int> rowid;
  const BackupMetadataCompanion({
    this.id = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.sha256Hex = const Value.absent(),
    this.fileName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.restoredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupMetadataCompanion.insert({
    required String id,
    required int schemaVersion,
    required String sha256Hex,
    this.fileName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.restoredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       schemaVersion = Value(schemaVersion),
       sha256Hex = Value(sha256Hex);
  static Insertable<BackupMetadataData> custom({
    Expression<String>? id,
    Expression<int>? schemaVersion,
    Expression<String>? sha256Hex,
    Expression<String>? fileName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? restoredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (sha256Hex != null) 'sha256_hex': sha256Hex,
      if (fileName != null) 'file_name': fileName,
      if (createdAt != null) 'created_at': createdAt,
      if (restoredAt != null) 'restored_at': restoredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupMetadataCompanion copyWith({
    Value<String>? id,
    Value<int>? schemaVersion,
    Value<String>? sha256Hex,
    Value<String?>? fileName,
    Value<DateTime>? createdAt,
    Value<DateTime?>? restoredAt,
    Value<int>? rowid,
  }) {
    return BackupMetadataCompanion(
      id: id ?? this.id,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      sha256Hex: sha256Hex ?? this.sha256Hex,
      fileName: fileName ?? this.fileName,
      createdAt: createdAt ?? this.createdAt,
      restoredAt: restoredAt ?? this.restoredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (sha256Hex.present) {
      map['sha256_hex'] = Variable<String>(sha256Hex.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (restoredAt.present) {
      map['restored_at'] = Variable<DateTime>(restoredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataCompanion(')
          ..write('id: $id, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('sha256Hex: $sha256Hex, ')
          ..write('fileName: $fileName, ')
          ..write('createdAt: $createdAt, ')
          ..write('restoredAt: $restoredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueJsonMeta = const VerificationMeta(
    'valueJson',
  );
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
    'value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, valueJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(
        _valueJsonMeta,
        valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      valueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String valueJson;
  final DateTime updatedAt;
  const AppSetting({
    required this.key,
    required this.valueJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      valueJson: Value(valueJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({String? key, String? valueJson, DateTime? updatedAt}) =>
      AppSetting(
        key: key ?? this.key,
        valueJson: valueJson ?? this.valueJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.valueJson == this.valueJson &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> valueJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String valueJson,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       valueJson = Value(valueJson);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? valueJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MaterialProfilesTable materialProfiles = $MaterialProfilesTable(
    this,
  );
  late final $SpoolsTable spools = $SpoolsTable(this);
  late final $PrinterProfilesTable printerProfiles = $PrinterProfilesTable(
    this,
  );
  late final $CustomersTable customers = $CustomersTable(this);
  late final $QuotesTable quotes = $QuotesTable(this);
  late final $QuoteRevisionsTable quoteRevisions = $QuoteRevisionsTable(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $PrintAttemptsTable printAttempts = $PrintAttemptsTable(this);
  late final $InventoryTransactionsTable inventoryTransactions =
      $InventoryTransactionsTable(this);
  late final $MarketplacePresetsTable marketplacePresets =
      $MarketplacePresetsTable(this);
  late final $BusinessProfilesTable businessProfiles = $BusinessProfilesTable(
    this,
  );
  late final $BackupMetadataTable backupMetadata = $BackupMetadataTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    materialProfiles,
    spools,
    printerProfiles,
    customers,
    quotes,
    quoteRevisions,
    jobs,
    printAttempts,
    inventoryTransactions,
    marketplacePresets,
    businessProfiles,
    backupMetadata,
    appSettings,
  ];
}

typedef $$MaterialProfilesTableCreateCompanionBuilder =
    MaterialProfilesCompanion Function({
      required String id,
      required String name,
      required String materialType,
      Value<String?> brand,
      required String colorHex,
      required int spoolPriceMicros,
      required int nominalMassMg,
      Value<int> densityMicrogramsPerCubicMillimeter,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$MaterialProfilesTableUpdateCompanionBuilder =
    MaterialProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> materialType,
      Value<String?> brand,
      Value<String> colorHex,
      Value<int> spoolPriceMicros,
      Value<int> nominalMassMg,
      Value<int> densityMicrogramsPerCubicMillimeter,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$MaterialProfilesTableReferences
    extends
        BaseReferences<_$AppDatabase, $MaterialProfilesTable, MaterialProfile> {
  $$MaterialProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SpoolsTable, List<Spool>> _spoolsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.spools,
    aliasName: 'material_profiles__id__spools__material_profile_id',
  );

  $$SpoolsTableProcessedTableManager get spoolsRefs {
    final manager = $$SpoolsTableTableManager($_db, $_db.spools).filter(
      (f) => f.materialProfileId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_spoolsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaterialProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $MaterialProfilesTable> {
  $$MaterialProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spoolPriceMicros => $composableBuilder(
    column: $table.spoolPriceMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominalMassMg => $composableBuilder(
    column: $table.nominalMassMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get densityMicrogramsPerCubicMillimeter =>
      $composableBuilder(
        column: $table.densityMicrogramsPerCubicMillimeter,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> spoolsRefs(
    Expression<bool> Function($$SpoolsTableFilterComposer f) f,
  ) {
    final $$SpoolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.spools,
      getReferencedColumn: (t) => t.materialProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpoolsTableFilterComposer(
            $db: $db,
            $table: $db.spools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaterialProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $MaterialProfilesTable> {
  $$MaterialProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spoolPriceMicros => $composableBuilder(
    column: $table.spoolPriceMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominalMassMg => $composableBuilder(
    column: $table.nominalMassMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get densityMicrogramsPerCubicMillimeter =>
      $composableBuilder(
        column: $table.densityMicrogramsPerCubicMillimeter,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaterialProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaterialProfilesTable> {
  $$MaterialProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get spoolPriceMicros => $composableBuilder(
    column: $table.spoolPriceMicros,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nominalMassMg => $composableBuilder(
    column: $table.nominalMassMg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get densityMicrogramsPerCubicMillimeter =>
      $composableBuilder(
        column: $table.densityMicrogramsPerCubicMillimeter,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> spoolsRefs<T extends Object>(
    Expression<T> Function($$SpoolsTableAnnotationComposer a) f,
  ) {
    final $$SpoolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.spools,
      getReferencedColumn: (t) => t.materialProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpoolsTableAnnotationComposer(
            $db: $db,
            $table: $db.spools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaterialProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaterialProfilesTable,
          MaterialProfile,
          $$MaterialProfilesTableFilterComposer,
          $$MaterialProfilesTableOrderingComposer,
          $$MaterialProfilesTableAnnotationComposer,
          $$MaterialProfilesTableCreateCompanionBuilder,
          $$MaterialProfilesTableUpdateCompanionBuilder,
          (MaterialProfile, $$MaterialProfilesTableReferences),
          MaterialProfile,
          PrefetchHooks Function({bool spoolsRefs})
        > {
  $$MaterialProfilesTableTableManager(
    _$AppDatabase db,
    $MaterialProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaterialProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaterialProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaterialProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> materialType = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> spoolPriceMicros = const Value.absent(),
                Value<int> nominalMassMg = const Value.absent(),
                Value<int> densityMicrogramsPerCubicMillimeter =
                    const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaterialProfilesCompanion(
                id: id,
                name: name,
                materialType: materialType,
                brand: brand,
                colorHex: colorHex,
                spoolPriceMicros: spoolPriceMicros,
                nominalMassMg: nominalMassMg,
                densityMicrogramsPerCubicMillimeter:
                    densityMicrogramsPerCubicMillimeter,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String materialType,
                Value<String?> brand = const Value.absent(),
                required String colorHex,
                required int spoolPriceMicros,
                required int nominalMassMg,
                Value<int> densityMicrogramsPerCubicMillimeter =
                    const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaterialProfilesCompanion.insert(
                id: id,
                name: name,
                materialType: materialType,
                brand: brand,
                colorHex: colorHex,
                spoolPriceMicros: spoolPriceMicros,
                nominalMassMg: nominalMassMg,
                densityMicrogramsPerCubicMillimeter:
                    densityMicrogramsPerCubicMillimeter,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MaterialProfilesTable, MaterialProfile>(table),
                  $$MaterialProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({spoolsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (spoolsRefs) db.spools],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (spoolsRefs)
                    await $_getPrefetchedDataByColumns<
                      MaterialProfile,
                      $MaterialProfilesTable,
                      Spool,
                      $SpoolsTable
                    >(
                      currentTable: table,
                      referencedTable: $$MaterialProfilesTableReferences
                          ._spoolsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MaterialProfilesTableReferences(
                            db,
                            table,
                            p0,
                          ).spoolsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'material_profile_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MaterialProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaterialProfilesTable,
      MaterialProfile,
      $$MaterialProfilesTableFilterComposer,
      $$MaterialProfilesTableOrderingComposer,
      $$MaterialProfilesTableAnnotationComposer,
      $$MaterialProfilesTableCreateCompanionBuilder,
      $$MaterialProfilesTableUpdateCompanionBuilder,
      (MaterialProfile, $$MaterialProfilesTableReferences),
      MaterialProfile,
      PrefetchHooks Function({bool spoolsRefs})
    >;
typedef $$SpoolsTableCreateCompanionBuilder = SpoolsCompanion Function({
  required String id,
  required String materialProfileId,
  Value<String?> lotCode,
  required int remainingMassMg,
  Value<DateTime?> openedAt,
  Value<DateTime> createdAt,
  Value<bool> archived,
  Value<int> rowid,
});
typedef $$SpoolsTableUpdateCompanionBuilder = SpoolsCompanion Function({
  Value<String> id,
  Value<String> materialProfileId,
  Value<String?> lotCode,
  Value<int> remainingMassMg,
  Value<DateTime?> openedAt,
  Value<DateTime> createdAt,
  Value<bool> archived,
  Value<int> rowid,
});

final class $$SpoolsTableReferences
    extends BaseReferences<_$AppDatabase, $SpoolsTable, Spool> {
  $$SpoolsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MaterialProfilesTable _materialProfileIdTable(_$AppDatabase db) => db
      .materialProfiles
      .createAlias('spools__material_profile_id__material_profiles__id');

  $$MaterialProfilesTableProcessedTableManager get materialProfileId {
    final $_column = $_itemColumn<String>('material_profile_id')!;

    final manager = $$MaterialProfilesTableTableManager(
      $_db,
      $_db.materialProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_materialProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionsTable,
    List<InventoryTransaction>
  >
  _inventoryTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactions,
        aliasName: 'spools__id__inventory_transactions__spool_id',
      );

  $$InventoryTransactionsTableProcessedTableManager
  get inventoryTransactionsRefs {
    final manager = $$InventoryTransactionsTableTableManager(
      $_db,
      $_db.inventoryTransactions,
    ).filter((f) => f.spoolId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpoolsTableFilterComposer
    extends Composer<_$AppDatabase, $SpoolsTable> {
  $$SpoolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotCode => $composableBuilder(
    column: $table.lotCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remainingMassMg => $composableBuilder(
    column: $table.remainingMassMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  $$MaterialProfilesTableFilterComposer get materialProfileId {
    final $$MaterialProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialProfileId,
      referencedTable: $db.materialProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialProfilesTableFilterComposer(
            $db: $db,
            $table: $db.materialProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> inventoryTransactionsRefs(
    Expression<bool> Function($$InventoryTransactionsTableFilterComposer f) f,
  ) {
    final $$InventoryTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.spoolId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpoolsTableOrderingComposer
    extends Composer<_$AppDatabase, $SpoolsTable> {
  $$SpoolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotCode => $composableBuilder(
    column: $table.lotCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainingMassMg => $composableBuilder(
    column: $table.remainingMassMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  $$MaterialProfilesTableOrderingComposer get materialProfileId {
    final $$MaterialProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialProfileId,
      referencedTable: $db.materialProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.materialProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpoolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpoolsTable> {
  $$SpoolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lotCode =>
      $composableBuilder(column: $table.lotCode, builder: (column) => column);

  GeneratedColumn<int> get remainingMassMg => $composableBuilder(
    column: $table.remainingMassMg,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  $$MaterialProfilesTableAnnotationComposer get materialProfileId {
    final $$MaterialProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialProfileId,
      referencedTable: $db.materialProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.materialProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> inventoryTransactionsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionsTableAnnotationComposer a) f,
  ) {
    final $$InventoryTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.spoolId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpoolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpoolsTable,
          Spool,
          $$SpoolsTableFilterComposer,
          $$SpoolsTableOrderingComposer,
          $$SpoolsTableAnnotationComposer,
          $$SpoolsTableCreateCompanionBuilder,
          $$SpoolsTableUpdateCompanionBuilder,
          (Spool, $$SpoolsTableReferences),
          Spool,
          PrefetchHooks Function({
            bool materialProfileId,
            bool inventoryTransactionsRefs,
          })
        > {
  $$SpoolsTableTableManager(_$AppDatabase db, $SpoolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpoolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpoolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpoolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> materialProfileId = const Value.absent(),
                Value<String?> lotCode = const Value.absent(),
                Value<int> remainingMassMg = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpoolsCompanion(
                id: id,
                materialProfileId: materialProfileId,
                lotCode: lotCode,
                remainingMassMg: remainingMassMg,
                openedAt: openedAt,
                createdAt: createdAt,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String materialProfileId,
                Value<String?> lotCode = const Value.absent(),
                required int remainingMassMg,
                Value<DateTime?> openedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpoolsCompanion.insert(
                id: id,
                materialProfileId: materialProfileId,
                lotCode: lotCode,
                remainingMassMg: remainingMassMg,
                openedAt: openedAt,
                createdAt: createdAt,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SpoolsTable, Spool>(table),
                  $$SpoolsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({materialProfileId = false, inventoryTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (inventoryTransactionsRefs) db.inventoryTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (materialProfileId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.materialProfileId,
                            referencedTable: $$SpoolsTableReferences
                                ._materialProfileIdTable(db),
                            referencedColumn: $$SpoolsTableReferences
                                ._materialProfileIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (inventoryTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Spool,
                          $SpoolsTable,
                          InventoryTransaction,
                          $InventoryTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SpoolsTableReferences
                              ._inventoryTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpoolsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'spool_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SpoolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpoolsTable,
      Spool,
      $$SpoolsTableFilterComposer,
      $$SpoolsTableOrderingComposer,
      $$SpoolsTableAnnotationComposer,
      $$SpoolsTableCreateCompanionBuilder,
      $$SpoolsTableUpdateCompanionBuilder,
      (Spool, $$SpoolsTableReferences),
      Spool,
      PrefetchHooks Function({
        bool materialProfileId,
        bool inventoryTransactionsRefs,
      })
    >;
typedef $$PrinterProfilesTableCreateCompanionBuilder =
    PrinterProfilesCompanion Function({
      required String id,
      required String name,
      required int watts,
      required int machineRateMicrosPerHour,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PrinterProfilesTableUpdateCompanionBuilder =
    PrinterProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> watts,
      Value<int> machineRateMicrosPerHour,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PrinterProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $PrinterProfilesTable> {
  $$PrinterProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get watts => $composableBuilder(
    column: $table.watts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get machineRateMicrosPerHour => $composableBuilder(
    column: $table.machineRateMicrosPerHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrinterProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PrinterProfilesTable> {
  $$PrinterProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get watts => $composableBuilder(
    column: $table.watts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get machineRateMicrosPerHour => $composableBuilder(
    column: $table.machineRateMicrosPerHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrinterProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrinterProfilesTable> {
  $$PrinterProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get watts =>
      $composableBuilder(column: $table.watts, builder: (column) => column);

  GeneratedColumn<int> get machineRateMicrosPerHour => $composableBuilder(
    column: $table.machineRateMicrosPerHour,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PrinterProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrinterProfilesTable,
          PrinterProfile,
          $$PrinterProfilesTableFilterComposer,
          $$PrinterProfilesTableOrderingComposer,
          $$PrinterProfilesTableAnnotationComposer,
          $$PrinterProfilesTableCreateCompanionBuilder,
          $$PrinterProfilesTableUpdateCompanionBuilder,
          (
            PrinterProfile,
            BaseReferences<
              _$AppDatabase,
              $PrinterProfilesTable,
              PrinterProfile
            >,
          ),
          PrinterProfile,
          PrefetchHooks Function()
        > {
  $$PrinterProfilesTableTableManager(
    _$AppDatabase db,
    $PrinterProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrinterProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrinterProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrinterProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> watts = const Value.absent(),
                Value<int> machineRateMicrosPerHour = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrinterProfilesCompanion(
                id: id,
                name: name,
                watts: watts,
                machineRateMicrosPerHour: machineRateMicrosPerHour,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int watts,
                required int machineRateMicrosPerHour,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrinterProfilesCompanion.insert(
                id: id,
                name: name,
                watts: watts,
                machineRateMicrosPerHour: machineRateMicrosPerHour,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrinterProfilesTable, PrinterProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PrinterProfilesTable,
                    PrinterProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrinterProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrinterProfilesTable,
      PrinterProfile,
      $$PrinterProfilesTableFilterComposer,
      $$PrinterProfilesTableOrderingComposer,
      $$PrinterProfilesTableAnnotationComposer,
      $$PrinterProfilesTableCreateCompanionBuilder,
      $$PrinterProfilesTableUpdateCompanionBuilder,
      (
        PrinterProfile,
        BaseReferences<_$AppDatabase, $PrinterProfilesTable, PrinterProfile>,
      ),
      PrinterProfile,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  required String id,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuotesTable, List<Quote>> _quotesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.quotes,
    aliasName: 'customers__id__quotes__customer_id',
  );

  $$QuotesTableProcessedTableManager get quotesRefs {
    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> quotesRefs(
    Expression<bool> Function($$QuotesTableFilterComposer f) f,
  ) {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> quotesRefs<T extends Object>(
    Expression<T> Function($$QuotesTableAnnotationComposer a) f,
  ) {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool quotesRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                email: email,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                email: email,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomersTable, Customer>(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({quotesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (quotesRefs) db.quotes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (quotesRefs)
                    await $_getPrefetchedDataByColumns<
                      Customer,
                      $CustomersTable,
                      Quote,
                      $QuotesTable
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._quotesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(db, table, p0).quotesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'customer_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool quotesRefs})
    >;
typedef $$QuotesTableCreateCompanionBuilder = QuotesCompanion Function({
  required String id,
  required String quoteNumber,
  Value<String?> customerId,
  Value<String> status,
  Value<String> currencyCode,
  required int subtotalMicros,
  required int taxMicros,
  required int totalMicros,
  required String snapshotJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$QuotesTableUpdateCompanionBuilder = QuotesCompanion Function({
  Value<String> id,
  Value<String> quoteNumber,
  Value<String?> customerId,
  Value<String> status,
  Value<String> currencyCode,
  Value<int> subtotalMicros,
  Value<int> taxMicros,
  Value<int> totalMicros,
  Value<String> snapshotJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$QuotesTableReferences
    extends BaseReferences<_$AppDatabase, $QuotesTable, Quote> {
  $$QuotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('quotes__customer_id__customers__id');

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<String>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$QuoteRevisionsTable, List<QuoteRevision>>
  _quoteRevisionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quoteRevisions,
    aliasName: 'quotes__id__quote_revisions__quote_id',
  );

  $$QuoteRevisionsTableProcessedTableManager get quoteRevisionsRefs {
    final manager = $$QuoteRevisionsTableTableManager(
      $_db,
      $_db.quoteRevisions,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quoteRevisionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JobsTable, List<Job>> _jobsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.jobs,
    aliasName: 'quotes__id__jobs__quote_id',
  );

  $$JobsTableProcessedTableManager get jobsRefs {
    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuotesTableFilterComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteNumber => $composableBuilder(
    column: $table.quoteNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalMicros => $composableBuilder(
    column: $table.subtotalMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxMicros => $composableBuilder(
    column: $table.taxMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMicros => $composableBuilder(
    column: $table.totalMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> quoteRevisionsRefs(
    Expression<bool> Function($$QuoteRevisionsTableFilterComposer f) f,
  ) {
    final $$QuoteRevisionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quoteRevisions,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuoteRevisionsTableFilterComposer(
            $db: $db,
            $table: $db.quoteRevisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jobsRefs(
    Expression<bool> Function($$JobsTableFilterComposer f) f,
  ) {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteNumber => $composableBuilder(
    column: $table.quoteNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalMicros => $composableBuilder(
    column: $table.subtotalMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxMicros => $composableBuilder(
    column: $table.taxMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMicros => $composableBuilder(
    column: $table.totalMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get quoteNumber => $composableBuilder(
    column: $table.quoteNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotalMicros => $composableBuilder(
    column: $table.subtotalMicros,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxMicros =>
      $composableBuilder(column: $table.taxMicros, builder: (column) => column);

  GeneratedColumn<int> get totalMicros => $composableBuilder(
    column: $table.totalMicros,
    builder: (column) => column,
  );

  GeneratedColumn<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> quoteRevisionsRefs<T extends Object>(
    Expression<T> Function($$QuoteRevisionsTableAnnotationComposer a) f,
  ) {
    final $$QuoteRevisionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quoteRevisions,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuoteRevisionsTableAnnotationComposer(
            $db: $db,
            $table: $db.quoteRevisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jobsRefs<T extends Object>(
    Expression<T> Function($$JobsTableAnnotationComposer a) f,
  ) {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.quoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotesTable,
          Quote,
          $$QuotesTableFilterComposer,
          $$QuotesTableOrderingComposer,
          $$QuotesTableAnnotationComposer,
          $$QuotesTableCreateCompanionBuilder,
          $$QuotesTableUpdateCompanionBuilder,
          (Quote, $$QuotesTableReferences),
          Quote,
          PrefetchHooks Function({
            bool customerId,
            bool quoteRevisionsRefs,
            bool jobsRefs,
          })
        > {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> quoteNumber = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> subtotalMicros = const Value.absent(),
                Value<int> taxMicros = const Value.absent(),
                Value<int> totalMicros = const Value.absent(),
                Value<String> snapshotJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion(
                id: id,
                quoteNumber: quoteNumber,
                customerId: customerId,
                status: status,
                currencyCode: currencyCode,
                subtotalMicros: subtotalMicros,
                taxMicros: taxMicros,
                totalMicros: totalMicros,
                snapshotJson: snapshotJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String quoteNumber,
                Value<String?> customerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                required int subtotalMicros,
                required int taxMicros,
                required int totalMicros,
                required String snapshotJson,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuotesCompanion.insert(
                id: id,
                quoteNumber: quoteNumber,
                customerId: customerId,
                status: status,
                currencyCode: currencyCode,
                subtotalMicros: subtotalMicros,
                taxMicros: taxMicros,
                totalMicros: totalMicros,
                snapshotJson: snapshotJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuotesTable, Quote>(table),
                  $$QuotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                quoteRevisionsRefs = false,
                jobsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (quoteRevisionsRefs) db.quoteRevisions,
                    if (jobsRefs) db.jobs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (customerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.customerId,
                            referencedTable: $$QuotesTableReferences
                                ._customerIdTable(db),
                            referencedColumn: $$QuotesTableReferences
                                ._customerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (quoteRevisionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Quote,
                          $QuotesTable,
                          QuoteRevision,
                          $QuoteRevisionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuotesTableReferences
                              ._quoteRevisionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuotesTableReferences(
                                db,
                                table,
                                p0,
                              ).quoteRevisionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'quote_id',
                          typedResults: items,
                        ),
                      if (jobsRefs)
                        await $_getPrefetchedDataByColumns<
                          Quote,
                          $QuotesTable,
                          Job,
                          $JobsTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuotesTableReferences
                              ._jobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuotesTableReferences(db, table, p0).jobsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'quote_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$QuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotesTable,
      Quote,
      $$QuotesTableFilterComposer,
      $$QuotesTableOrderingComposer,
      $$QuotesTableAnnotationComposer,
      $$QuotesTableCreateCompanionBuilder,
      $$QuotesTableUpdateCompanionBuilder,
      (Quote, $$QuotesTableReferences),
      Quote,
      PrefetchHooks Function({
        bool customerId,
        bool quoteRevisionsRefs,
        bool jobsRefs,
      })
    >;
typedef $$QuoteRevisionsTableCreateCompanionBuilder =
    QuoteRevisionsCompanion Function({
      required String id,
      required String quoteId,
      required int revisionNumber,
      required String snapshotJson,
      required int subtotalMicros,
      required int taxMicros,
      required int totalMicros,
      Value<String?> reason,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$QuoteRevisionsTableUpdateCompanionBuilder =
    QuoteRevisionsCompanion Function({
      Value<String> id,
      Value<String> quoteId,
      Value<int> revisionNumber,
      Value<String> snapshotJson,
      Value<int> subtotalMicros,
      Value<int> taxMicros,
      Value<int> totalMicros,
      Value<String?> reason,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$QuoteRevisionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuoteRevisionsTable, QuoteRevision> {
  $$QuoteRevisionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuotesTable _quoteIdTable(_$AppDatabase db) =>
      db.quotes.createAlias('quote_revisions__quote_id__quotes__id');

  $$QuotesTableProcessedTableManager get quoteId {
    final $_column = $_itemColumn<String>('quote_id')!;

    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuoteRevisionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuoteRevisionsTable> {
  $$QuoteRevisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revisionNumber => $composableBuilder(
    column: $table.revisionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalMicros => $composableBuilder(
    column: $table.subtotalMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxMicros => $composableBuilder(
    column: $table.taxMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMicros => $composableBuilder(
    column: $table.totalMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuotesTableFilterComposer get quoteId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuoteRevisionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuoteRevisionsTable> {
  $$QuoteRevisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revisionNumber => $composableBuilder(
    column: $table.revisionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalMicros => $composableBuilder(
    column: $table.subtotalMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxMicros => $composableBuilder(
    column: $table.taxMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMicros => $composableBuilder(
    column: $table.totalMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuotesTableOrderingComposer get quoteId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuoteRevisionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuoteRevisionsTable> {
  $$QuoteRevisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get revisionNumber => $composableBuilder(
    column: $table.revisionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get snapshotJson => $composableBuilder(
    column: $table.snapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotalMicros => $composableBuilder(
    column: $table.subtotalMicros,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxMicros =>
      $composableBuilder(column: $table.taxMicros, builder: (column) => column);

  GeneratedColumn<int> get totalMicros => $composableBuilder(
    column: $table.totalMicros,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuotesTableAnnotationComposer get quoteId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuoteRevisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuoteRevisionsTable,
          QuoteRevision,
          $$QuoteRevisionsTableFilterComposer,
          $$QuoteRevisionsTableOrderingComposer,
          $$QuoteRevisionsTableAnnotationComposer,
          $$QuoteRevisionsTableCreateCompanionBuilder,
          $$QuoteRevisionsTableUpdateCompanionBuilder,
          (QuoteRevision, $$QuoteRevisionsTableReferences),
          QuoteRevision,
          PrefetchHooks Function({bool quoteId})
        > {
  $$QuoteRevisionsTableTableManager(
    _$AppDatabase db,
    $QuoteRevisionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuoteRevisionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuoteRevisionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuoteRevisionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> quoteId = const Value.absent(),
                Value<int> revisionNumber = const Value.absent(),
                Value<String> snapshotJson = const Value.absent(),
                Value<int> subtotalMicros = const Value.absent(),
                Value<int> taxMicros = const Value.absent(),
                Value<int> totalMicros = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuoteRevisionsCompanion(
                id: id,
                quoteId: quoteId,
                revisionNumber: revisionNumber,
                snapshotJson: snapshotJson,
                subtotalMicros: subtotalMicros,
                taxMicros: taxMicros,
                totalMicros: totalMicros,
                reason: reason,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String quoteId,
                required int revisionNumber,
                required String snapshotJson,
                required int subtotalMicros,
                required int taxMicros,
                required int totalMicros,
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuoteRevisionsCompanion.insert(
                id: id,
                quoteId: quoteId,
                revisionNumber: revisionNumber,
                snapshotJson: snapshotJson,
                subtotalMicros: subtotalMicros,
                taxMicros: taxMicros,
                totalMicros: totalMicros,
                reason: reason,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuoteRevisionsTable, QuoteRevision>(table),
                  $$QuoteRevisionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({quoteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (quoteId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.quoteId,
                        referencedTable: $$QuoteRevisionsTableReferences
                            ._quoteIdTable(db),
                        referencedColumn: $$QuoteRevisionsTableReferences
                            ._quoteIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuoteRevisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuoteRevisionsTable,
      QuoteRevision,
      $$QuoteRevisionsTableFilterComposer,
      $$QuoteRevisionsTableOrderingComposer,
      $$QuoteRevisionsTableAnnotationComposer,
      $$QuoteRevisionsTableCreateCompanionBuilder,
      $$QuoteRevisionsTableUpdateCompanionBuilder,
      (QuoteRevision, $$QuoteRevisionsTableReferences),
      QuoteRevision,
      PrefetchHooks Function({bool quoteId})
    >;
typedef $$JobsTableCreateCompanionBuilder = JobsCompanion Function({
  required String id,
  Value<String?> quoteId,
  Value<String> state,
  Value<String?> sourceName,
  required String projectJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$JobsTableUpdateCompanionBuilder = JobsCompanion Function({
  Value<String> id,
  Value<String?> quoteId,
  Value<String> state,
  Value<String?> sourceName,
  Value<String> projectJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$JobsTableReferences
    extends BaseReferences<_$AppDatabase, $JobsTable, Job> {
  $$JobsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuotesTable _quoteIdTable(_$AppDatabase db) =>
      db.quotes.createAlias('jobs__quote_id__quotes__id');

  $$QuotesTableProcessedTableManager? get quoteId {
    final $_column = $_itemColumn<String>('quote_id');
    if ($_column == null) return null;
    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PrintAttemptsTable, List<PrintAttempt>>
  _printAttemptsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.printAttempts,
    aliasName: 'jobs__id__print_attempts__job_id',
  );

  $$PrintAttemptsTableProcessedTableManager get printAttemptsRefs {
    final manager = $$PrintAttemptsTableTableManager(
      $_db,
      $_db.printAttempts,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_printAttemptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionsTable,
    List<InventoryTransaction>
  >
  _inventoryTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactions,
        aliasName: 'jobs__id__inventory_transactions__job_id',
      );

  $$InventoryTransactionsTableProcessedTableManager
  get inventoryTransactionsRefs {
    final manager = $$InventoryTransactionsTableTableManager(
      $_db,
      $_db.inventoryTransactions,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobsTableFilterComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectJson => $composableBuilder(
    column: $table.projectJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuotesTableFilterComposer get quoteId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> printAttemptsRefs(
    Expression<bool> Function($$PrintAttemptsTableFilterComposer f) f,
  ) {
    final $$PrintAttemptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.printAttempts,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintAttemptsTableFilterComposer(
            $db: $db,
            $table: $db.printAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryTransactionsRefs(
    Expression<bool> Function($$InventoryTransactionsTableFilterComposer f) f,
  ) {
    final $$InventoryTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.jobId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$JobsTableOrderingComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectJson => $composableBuilder(
    column: $table.projectJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuotesTableOrderingComposer get quoteId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get projectJson => $composableBuilder(
    column: $table.projectJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$QuotesTableAnnotationComposer get quoteId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> printAttemptsRefs<T extends Object>(
    Expression<T> Function($$PrintAttemptsTableAnnotationComposer a) f,
  ) {
    final $$PrintAttemptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.printAttempts,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintAttemptsTableAnnotationComposer(
            $db: $db,
            $table: $db.printAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inventoryTransactionsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionsTableAnnotationComposer a) f,
  ) {
    final $$InventoryTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.jobId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$JobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobsTable,
          Job,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (Job, $$JobsTableReferences),
          Job,
          PrefetchHooks Function({
            bool quoteId,
            bool printAttemptsRefs,
            bool inventoryTransactionsRefs,
          })
        > {
  $$JobsTableTableManager(_$AppDatabase db, $JobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> quoteId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                Value<String> projectJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                quoteId: quoteId,
                state: state,
                sourceName: sourceName,
                projectJson: projectJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> quoteId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                required String projectJson,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JobsCompanion.insert(
                id: id,
                quoteId: quoteId,
                state: state,
                sourceName: sourceName,
                projectJson: projectJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JobsTable, Job>(table),
                  $$JobsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                quoteId = false,
                printAttemptsRefs = false,
                inventoryTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (printAttemptsRefs) db.printAttempts,
                    if (inventoryTransactionsRefs) db.inventoryTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (quoteId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.quoteId,
                            referencedTable: $$JobsTableReferences
                                ._quoteIdTable(db),
                            referencedColumn: $$JobsTableReferences
                                ._quoteIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (printAttemptsRefs)
                        await $_getPrefetchedDataByColumns<
                          Job,
                          $JobsTable,
                          PrintAttempt,
                          $PrintAttemptsTable
                        >(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._printAttemptsRefsTable(db),
                          managerFromTypedResult: (p0) => $$JobsTableReferences(
                            db,
                            table,
                            p0,
                          ).printAttemptsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'job_id',
                          typedResults: items,
                        ),
                      if (inventoryTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Job,
                          $JobsTable,
                          InventoryTransaction,
                          $InventoryTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._inventoryTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) => $$JobsTableReferences(
                            db,
                            table,
                            p0,
                          ).inventoryTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'job_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobsTable,
      Job,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (Job, $$JobsTableReferences),
      Job,
      PrefetchHooks Function({
        bool quoteId,
        bool printAttemptsRefs,
        bool inventoryTransactionsRefs,
      })
    >;
typedef $$PrintAttemptsTableCreateCompanionBuilder =
    PrintAttemptsCompanion Function({
      required String id,
      required String jobId,
      required int sequence,
      Value<String> state,
      Value<int> estimatedMassMg,
      Value<int?> actualMassMg,
      Value<int> elapsedSeconds,
      Value<String?> failureReason,
      Value<String?> notes,
      Value<DateTime?> startedAt,
      Value<DateTime?> endedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PrintAttemptsTableUpdateCompanionBuilder =
    PrintAttemptsCompanion Function({
      Value<String> id,
      Value<String> jobId,
      Value<int> sequence,
      Value<String> state,
      Value<int> estimatedMassMg,
      Value<int?> actualMassMg,
      Value<int> elapsedSeconds,
      Value<String?> failureReason,
      Value<String?> notes,
      Value<DateTime?> startedAt,
      Value<DateTime?> endedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PrintAttemptsTableReferences
    extends BaseReferences<_$AppDatabase, $PrintAttemptsTable, PrintAttempt> {
  $$PrintAttemptsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias('print_attempts__job_id__jobs__id');

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<String>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionsTable,
    List<InventoryTransaction>
  >
  _inventoryTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactions,
        aliasName: 'print_attempts__id__inventory_transactions__attempt_id',
      );

  $$InventoryTransactionsTableProcessedTableManager
  get inventoryTransactionsRefs {
    final manager = $$InventoryTransactionsTableTableManager(
      $_db,
      $_db.inventoryTransactions,
    ).filter((f) => f.attemptId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PrintAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $PrintAttemptsTable> {
  $$PrintAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMassMg => $composableBuilder(
    column: $table.estimatedMassMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualMassMg => $composableBuilder(
    column: $table.actualMassMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureReason => $composableBuilder(
    column: $table.failureReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> inventoryTransactionsRefs(
    Expression<bool> Function($$InventoryTransactionsTableFilterComposer f) f,
  ) {
    final $$InventoryTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.attemptId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PrintAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrintAttemptsTable> {
  $$PrintAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMassMg => $composableBuilder(
    column: $table.estimatedMassMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualMassMg => $composableBuilder(
    column: $table.actualMassMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureReason => $composableBuilder(
    column: $table.failureReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrintAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrintAttemptsTable> {
  $$PrintAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get estimatedMassMg => $composableBuilder(
    column: $table.estimatedMassMg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualMassMg => $composableBuilder(
    column: $table.actualMassMg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureReason => $composableBuilder(
    column: $table.failureReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> inventoryTransactionsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionsTableAnnotationComposer a) f,
  ) {
    final $$InventoryTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.attemptId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PrintAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrintAttemptsTable,
          PrintAttempt,
          $$PrintAttemptsTableFilterComposer,
          $$PrintAttemptsTableOrderingComposer,
          $$PrintAttemptsTableAnnotationComposer,
          $$PrintAttemptsTableCreateCompanionBuilder,
          $$PrintAttemptsTableUpdateCompanionBuilder,
          (PrintAttempt, $$PrintAttemptsTableReferences),
          PrintAttempt,
          PrefetchHooks Function({bool jobId, bool inventoryTransactionsRefs})
        > {
  $$PrintAttemptsTableTableManager(_$AppDatabase db, $PrintAttemptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrintAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrintAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrintAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> jobId = const Value.absent(),
                Value<int> sequence = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<int> estimatedMassMg = const Value.absent(),
                Value<int?> actualMassMg = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<String?> failureReason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrintAttemptsCompanion(
                id: id,
                jobId: jobId,
                sequence: sequence,
                state: state,
                estimatedMassMg: estimatedMassMg,
                actualMassMg: actualMassMg,
                elapsedSeconds: elapsedSeconds,
                failureReason: failureReason,
                notes: notes,
                startedAt: startedAt,
                endedAt: endedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String jobId,
                required int sequence,
                Value<String> state = const Value.absent(),
                Value<int> estimatedMassMg = const Value.absent(),
                Value<int?> actualMassMg = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<String?> failureReason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrintAttemptsCompanion.insert(
                id: id,
                jobId: jobId,
                sequence: sequence,
                state: state,
                estimatedMassMg: estimatedMassMg,
                actualMassMg: actualMassMg,
                elapsedSeconds: elapsedSeconds,
                failureReason: failureReason,
                notes: notes,
                startedAt: startedAt,
                endedAt: endedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PrintAttemptsTable, PrintAttempt>(table),
                  $$PrintAttemptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({jobId = false, inventoryTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (inventoryTransactionsRefs) db.inventoryTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (jobId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.jobId,
                            referencedTable: $$PrintAttemptsTableReferences
                                ._jobIdTable(db),
                            referencedColumn: $$PrintAttemptsTableReferences
                                ._jobIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (inventoryTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          PrintAttempt,
                          $PrintAttemptsTable,
                          InventoryTransaction,
                          $InventoryTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PrintAttemptsTableReferences
                              ._inventoryTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PrintAttemptsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'attempt_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PrintAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrintAttemptsTable,
      PrintAttempt,
      $$PrintAttemptsTableFilterComposer,
      $$PrintAttemptsTableOrderingComposer,
      $$PrintAttemptsTableAnnotationComposer,
      $$PrintAttemptsTableCreateCompanionBuilder,
      $$PrintAttemptsTableUpdateCompanionBuilder,
      (PrintAttempt, $$PrintAttemptsTableReferences),
      PrintAttempt,
      PrefetchHooks Function({bool jobId, bool inventoryTransactionsRefs})
    >;
typedef $$InventoryTransactionsTableCreateCompanionBuilder =
    InventoryTransactionsCompanion Function({
      required String id,
      required String spoolId,
      Value<String?> jobId,
      Value<String?> attemptId,
      required String kind,
      required int deltaMassMg,
      Value<String?> note,
      Value<String?> reversalOfTransactionId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$InventoryTransactionsTableUpdateCompanionBuilder =
    InventoryTransactionsCompanion Function({
      Value<String> id,
      Value<String> spoolId,
      Value<String?> jobId,
      Value<String?> attemptId,
      Value<String> kind,
      Value<int> deltaMassMg,
      Value<String?> note,
      Value<String?> reversalOfTransactionId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InventoryTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InventoryTransactionsTable,
          InventoryTransaction
        > {
  $$InventoryTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SpoolsTable _spoolIdTable(_$AppDatabase db) =>
      db.spools.createAlias('inventory_transactions__spool_id__spools__id');

  $$SpoolsTableProcessedTableManager get spoolId {
    final $_column = $_itemColumn<String>('spool_id')!;

    final manager = $$SpoolsTableTableManager(
      $_db,
      $_db.spools,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_spoolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias('inventory_transactions__job_id__jobs__id');

  $$JobsTableProcessedTableManager? get jobId {
    final $_column = $_itemColumn<String>('job_id');
    if ($_column == null) return null;
    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PrintAttemptsTable _attemptIdTable(_$AppDatabase db) => db
      .printAttempts
      .createAlias('inventory_transactions__attempt_id__print_attempts__id');

  $$PrintAttemptsTableProcessedTableManager? get attemptId {
    final $_column = $_itemColumn<String>('attempt_id');
    if ($_column == null) return null;
    final manager = $$PrintAttemptsTableTableManager(
      $_db,
      $_db.printAttempts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attemptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deltaMassMg => $composableBuilder(
    column: $table.deltaMassMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reversalOfTransactionId => $composableBuilder(
    column: $table.reversalOfTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SpoolsTableFilterComposer get spoolId {
    final $$SpoolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spoolId,
      referencedTable: $db.spools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpoolsTableFilterComposer(
            $db: $db,
            $table: $db.spools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PrintAttemptsTableFilterComposer get attemptId {
    final $$PrintAttemptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attemptId,
      referencedTable: $db.printAttempts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintAttemptsTableFilterComposer(
            $db: $db,
            $table: $db.printAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deltaMassMg => $composableBuilder(
    column: $table.deltaMassMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reversalOfTransactionId => $composableBuilder(
    column: $table.reversalOfTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SpoolsTableOrderingComposer get spoolId {
    final $$SpoolsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spoolId,
      referencedTable: $db.spools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpoolsTableOrderingComposer(
            $db: $db,
            $table: $db.spools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PrintAttemptsTableOrderingComposer get attemptId {
    final $$PrintAttemptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attemptId,
      referencedTable: $db.printAttempts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintAttemptsTableOrderingComposer(
            $db: $db,
            $table: $db.printAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get deltaMassMg => $composableBuilder(
    column: $table.deltaMassMg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get reversalOfTransactionId => $composableBuilder(
    column: $table.reversalOfTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SpoolsTableAnnotationComposer get spoolId {
    final $$SpoolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.spoolId,
      referencedTable: $db.spools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpoolsTableAnnotationComposer(
            $db: $db,
            $table: $db.spools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PrintAttemptsTableAnnotationComposer get attemptId {
    final $$PrintAttemptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attemptId,
      referencedTable: $db.printAttempts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrintAttemptsTableAnnotationComposer(
            $db: $db,
            $table: $db.printAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryTransactionsTable,
          InventoryTransaction,
          $$InventoryTransactionsTableFilterComposer,
          $$InventoryTransactionsTableOrderingComposer,
          $$InventoryTransactionsTableAnnotationComposer,
          $$InventoryTransactionsTableCreateCompanionBuilder,
          $$InventoryTransactionsTableUpdateCompanionBuilder,
          (InventoryTransaction, $$InventoryTransactionsTableReferences),
          InventoryTransaction,
          PrefetchHooks Function({bool spoolId, bool jobId, bool attemptId})
        > {
  $$InventoryTransactionsTableTableManager(
    _$AppDatabase db,
    $InventoryTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InventoryTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InventoryTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> spoolId = const Value.absent(),
                Value<String?> jobId = const Value.absent(),
                Value<String?> attemptId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> deltaMassMg = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> reversalOfTransactionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryTransactionsCompanion(
                id: id,
                spoolId: spoolId,
                jobId: jobId,
                attemptId: attemptId,
                kind: kind,
                deltaMassMg: deltaMassMg,
                note: note,
                reversalOfTransactionId: reversalOfTransactionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String spoolId,
                Value<String?> jobId = const Value.absent(),
                Value<String?> attemptId = const Value.absent(),
                required String kind,
                required int deltaMassMg,
                Value<String?> note = const Value.absent(),
                Value<String?> reversalOfTransactionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryTransactionsCompanion.insert(
                id: id,
                spoolId: spoolId,
                jobId: jobId,
                attemptId: attemptId,
                kind: kind,
                deltaMassMg: deltaMassMg,
                note: note,
                reversalOfTransactionId: reversalOfTransactionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $InventoryTransactionsTable,
                    InventoryTransaction
                  >(table),
                  $$InventoryTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({spoolId = false, jobId = false, attemptId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (spoolId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.spoolId,
                            referencedTable:
                                $$InventoryTransactionsTableReferences
                                    ._spoolIdTable(db),
                            referencedColumn:
                                $$InventoryTransactionsTableReferences
                                    ._spoolIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (jobId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.jobId,
                            referencedTable:
                                $$InventoryTransactionsTableReferences
                                    ._jobIdTable(db),
                            referencedColumn:
                                $$InventoryTransactionsTableReferences
                                    ._jobIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (attemptId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.attemptId,
                            referencedTable:
                                $$InventoryTransactionsTableReferences
                                    ._attemptIdTable(db),
                            referencedColumn:
                                $$InventoryTransactionsTableReferences
                                    ._attemptIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$InventoryTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryTransactionsTable,
      InventoryTransaction,
      $$InventoryTransactionsTableFilterComposer,
      $$InventoryTransactionsTableOrderingComposer,
      $$InventoryTransactionsTableAnnotationComposer,
      $$InventoryTransactionsTableCreateCompanionBuilder,
      $$InventoryTransactionsTableUpdateCompanionBuilder,
      (InventoryTransaction, $$InventoryTransactionsTableReferences),
      InventoryTransaction,
      PrefetchHooks Function({bool spoolId, bool jobId, bool attemptId})
    >;
typedef $$MarketplacePresetsTableCreateCompanionBuilder =
    MarketplacePresetsCompanion Function({
      required String id,
      required String name,
      required int percentageBasisPoints,
      required int fixedFeeMicros,
      Value<String> currencyCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$MarketplacePresetsTableUpdateCompanionBuilder =
    MarketplacePresetsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> percentageBasisPoints,
      Value<int> fixedFeeMicros,
      Value<String> currencyCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$MarketplacePresetsTableFilterComposer
    extends Composer<_$AppDatabase, $MarketplacePresetsTable> {
  $$MarketplacePresetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get percentageBasisPoints => $composableBuilder(
    column: $table.percentageBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fixedFeeMicros => $composableBuilder(
    column: $table.fixedFeeMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MarketplacePresetsTableOrderingComposer
    extends Composer<_$AppDatabase, $MarketplacePresetsTable> {
  $$MarketplacePresetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get percentageBasisPoints => $composableBuilder(
    column: $table.percentageBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fixedFeeMicros => $composableBuilder(
    column: $table.fixedFeeMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MarketplacePresetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MarketplacePresetsTable> {
  $$MarketplacePresetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get percentageBasisPoints => $composableBuilder(
    column: $table.percentageBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fixedFeeMicros => $composableBuilder(
    column: $table.fixedFeeMicros,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MarketplacePresetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MarketplacePresetsTable,
          MarketplacePreset,
          $$MarketplacePresetsTableFilterComposer,
          $$MarketplacePresetsTableOrderingComposer,
          $$MarketplacePresetsTableAnnotationComposer,
          $$MarketplacePresetsTableCreateCompanionBuilder,
          $$MarketplacePresetsTableUpdateCompanionBuilder,
          (
            MarketplacePreset,
            BaseReferences<
              _$AppDatabase,
              $MarketplacePresetsTable,
              MarketplacePreset
            >,
          ),
          MarketplacePreset,
          PrefetchHooks Function()
        > {
  $$MarketplacePresetsTableTableManager(
    _$AppDatabase db,
    $MarketplacePresetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MarketplacePresetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MarketplacePresetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MarketplacePresetsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> percentageBasisPoints = const Value.absent(),
                Value<int> fixedFeeMicros = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MarketplacePresetsCompanion(
                id: id,
                name: name,
                percentageBasisPoints: percentageBasisPoints,
                fixedFeeMicros: fixedFeeMicros,
                currencyCode: currencyCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int percentageBasisPoints,
                required int fixedFeeMicros,
                Value<String> currencyCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MarketplacePresetsCompanion.insert(
                id: id,
                name: name,
                percentageBasisPoints: percentageBasisPoints,
                fixedFeeMicros: fixedFeeMicros,
                currencyCode: currencyCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MarketplacePresetsTable, MarketplacePreset>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $MarketplacePresetsTable,
                    MarketplacePreset
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MarketplacePresetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MarketplacePresetsTable,
      MarketplacePreset,
      $$MarketplacePresetsTableFilterComposer,
      $$MarketplacePresetsTableOrderingComposer,
      $$MarketplacePresetsTableAnnotationComposer,
      $$MarketplacePresetsTableCreateCompanionBuilder,
      $$MarketplacePresetsTableUpdateCompanionBuilder,
      (
        MarketplacePreset,
        BaseReferences<
          _$AppDatabase,
          $MarketplacePresetsTable,
          MarketplacePreset
        >,
      ),
      MarketplacePreset,
      PrefetchHooks Function()
    >;
typedef $$BusinessProfilesTableCreateCompanionBuilder =
    BusinessProfilesCompanion Function({
      required String id,
      required String businessName,
      Value<String?> logoPath,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> addressEnglish,
      Value<String?> addressArabic,
      Value<String?> trn,
      Value<int> vatBasisPoints,
      Value<String?> termsEnglish,
      Value<String?> termsArabic,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$BusinessProfilesTableUpdateCompanionBuilder =
    BusinessProfilesCompanion Function({
      Value<String> id,
      Value<String> businessName,
      Value<String?> logoPath,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> addressEnglish,
      Value<String?> addressArabic,
      Value<String?> trn,
      Value<int> vatBasisPoints,
      Value<String?> termsEnglish,
      Value<String?> termsArabic,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BusinessProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressEnglish => $composableBuilder(
    column: $table.addressEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressArabic => $composableBuilder(
    column: $table.addressArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trn => $composableBuilder(
    column: $table.trn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatBasisPoints => $composableBuilder(
    column: $table.vatBasisPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termsEnglish => $composableBuilder(
    column: $table.termsEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termsArabic => $composableBuilder(
    column: $table.termsArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BusinessProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressEnglish => $composableBuilder(
    column: $table.addressEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressArabic => $composableBuilder(
    column: $table.addressArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trn => $composableBuilder(
    column: $table.trn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatBasisPoints => $composableBuilder(
    column: $table.vatBasisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termsEnglish => $composableBuilder(
    column: $table.termsEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termsArabic => $composableBuilder(
    column: $table.termsArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BusinessProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get addressEnglish => $composableBuilder(
    column: $table.addressEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressArabic => $composableBuilder(
    column: $table.addressArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trn =>
      $composableBuilder(column: $table.trn, builder: (column) => column);

  GeneratedColumn<int> get vatBasisPoints => $composableBuilder(
    column: $table.vatBasisPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get termsEnglish => $composableBuilder(
    column: $table.termsEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get termsArabic => $composableBuilder(
    column: $table.termsArabic,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BusinessProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BusinessProfilesTable,
          BusinessProfile,
          $$BusinessProfilesTableFilterComposer,
          $$BusinessProfilesTableOrderingComposer,
          $$BusinessProfilesTableAnnotationComposer,
          $$BusinessProfilesTableCreateCompanionBuilder,
          $$BusinessProfilesTableUpdateCompanionBuilder,
          (
            BusinessProfile,
            BaseReferences<
              _$AppDatabase,
              $BusinessProfilesTable,
              BusinessProfile
            >,
          ),
          BusinessProfile,
          PrefetchHooks Function()
        > {
  $$BusinessProfilesTableTableManager(
    _$AppDatabase db,
    $BusinessProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BusinessProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BusinessProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BusinessProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> addressEnglish = const Value.absent(),
                Value<String?> addressArabic = const Value.absent(),
                Value<String?> trn = const Value.absent(),
                Value<int> vatBasisPoints = const Value.absent(),
                Value<String?> termsEnglish = const Value.absent(),
                Value<String?> termsArabic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BusinessProfilesCompanion(
                id: id,
                businessName: businessName,
                logoPath: logoPath,
                phone: phone,
                email: email,
                addressEnglish: addressEnglish,
                addressArabic: addressArabic,
                trn: trn,
                vatBasisPoints: vatBasisPoints,
                termsEnglish: termsEnglish,
                termsArabic: termsArabic,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String businessName,
                Value<String?> logoPath = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> addressEnglish = const Value.absent(),
                Value<String?> addressArabic = const Value.absent(),
                Value<String?> trn = const Value.absent(),
                Value<int> vatBasisPoints = const Value.absent(),
                Value<String?> termsEnglish = const Value.absent(),
                Value<String?> termsArabic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BusinessProfilesCompanion.insert(
                id: id,
                businessName: businessName,
                logoPath: logoPath,
                phone: phone,
                email: email,
                addressEnglish: addressEnglish,
                addressArabic: addressArabic,
                trn: trn,
                vatBasisPoints: vatBasisPoints,
                termsEnglish: termsEnglish,
                termsArabic: termsArabic,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BusinessProfilesTable, BusinessProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BusinessProfilesTable,
                    BusinessProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BusinessProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BusinessProfilesTable,
      BusinessProfile,
      $$BusinessProfilesTableFilterComposer,
      $$BusinessProfilesTableOrderingComposer,
      $$BusinessProfilesTableAnnotationComposer,
      $$BusinessProfilesTableCreateCompanionBuilder,
      $$BusinessProfilesTableUpdateCompanionBuilder,
      (
        BusinessProfile,
        BaseReferences<_$AppDatabase, $BusinessProfilesTable, BusinessProfile>,
      ),
      BusinessProfile,
      PrefetchHooks Function()
    >;
typedef $$BackupMetadataTableCreateCompanionBuilder =
    BackupMetadataCompanion Function({
      required String id,
      required int schemaVersion,
      required String sha256Hex,
      Value<String?> fileName,
      Value<DateTime> createdAt,
      Value<DateTime?> restoredAt,
      Value<int> rowid,
    });
typedef $$BackupMetadataTableUpdateCompanionBuilder =
    BackupMetadataCompanion Function({
      Value<String> id,
      Value<int> schemaVersion,
      Value<String> sha256Hex,
      Value<String?> fileName,
      Value<DateTime> createdAt,
      Value<DateTime?> restoredAt,
      Value<int> rowid,
    });

class $$BackupMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256Hex => $composableBuilder(
    column: $table.sha256Hex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get restoredAt => $composableBuilder(
    column: $table.restoredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256Hex => $composableBuilder(
    column: $table.sha256Hex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get restoredAt => $composableBuilder(
    column: $table.restoredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256Hex =>
      $composableBuilder(column: $table.sha256Hex, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get restoredAt => $composableBuilder(
    column: $table.restoredAt,
    builder: (column) => column,
  );
}

class $$BackupMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupMetadataTable,
          BackupMetadataData,
          $$BackupMetadataTableFilterComposer,
          $$BackupMetadataTableOrderingComposer,
          $$BackupMetadataTableAnnotationComposer,
          $$BackupMetadataTableCreateCompanionBuilder,
          $$BackupMetadataTableUpdateCompanionBuilder,
          (
            BackupMetadataData,
            BaseReferences<
              _$AppDatabase,
              $BackupMetadataTable,
              BackupMetadataData
            >,
          ),
          BackupMetadataData,
          PrefetchHooks Function()
        > {
  $$BackupMetadataTableTableManager(
    _$AppDatabase db,
    $BackupMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<String> sha256Hex = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> restoredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupMetadataCompanion(
                id: id,
                schemaVersion: schemaVersion,
                sha256Hex: sha256Hex,
                fileName: fileName,
                createdAt: createdAt,
                restoredAt: restoredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int schemaVersion,
                required String sha256Hex,
                Value<String?> fileName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> restoredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupMetadataCompanion.insert(
                id: id,
                schemaVersion: schemaVersion,
                sha256Hex: sha256Hex,
                fileName: fileName,
                createdAt: createdAt,
                restoredAt: restoredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BackupMetadataTable, BackupMetadataData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BackupMetadataTable,
                    BackupMetadataData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupMetadataTable,
      BackupMetadataData,
      $$BackupMetadataTableFilterComposer,
      $$BackupMetadataTableOrderingComposer,
      $$BackupMetadataTableAnnotationComposer,
      $$BackupMetadataTableCreateCompanionBuilder,
      $$BackupMetadataTableUpdateCompanionBuilder,
      (
        BackupMetadataData,
        BaseReferences<_$AppDatabase, $BackupMetadataTable, BackupMetadataData>,
      ),
      BackupMetadataData,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String valueJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> valueJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> valueJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String valueJson,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MaterialProfilesTableTableManager get materialProfiles =>
      $$MaterialProfilesTableTableManager(_db, _db.materialProfiles);
  $$SpoolsTableTableManager get spools =>
      $$SpoolsTableTableManager(_db, _db.spools);
  $$PrinterProfilesTableTableManager get printerProfiles =>
      $$PrinterProfilesTableTableManager(_db, _db.printerProfiles);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$QuotesTableTableManager get quotes =>
      $$QuotesTableTableManager(_db, _db.quotes);
  $$QuoteRevisionsTableTableManager get quoteRevisions =>
      $$QuoteRevisionsTableTableManager(_db, _db.quoteRevisions);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$PrintAttemptsTableTableManager get printAttempts =>
      $$PrintAttemptsTableTableManager(_db, _db.printAttempts);
  $$InventoryTransactionsTableTableManager get inventoryTransactions =>
      $$InventoryTransactionsTableTableManager(_db, _db.inventoryTransactions);
  $$MarketplacePresetsTableTableManager get marketplacePresets =>
      $$MarketplacePresetsTableTableManager(_db, _db.marketplacePresets);
  $$BusinessProfilesTableTableManager get businessProfiles =>
      $$BusinessProfilesTableTableManager(_db, _db.businessProfiles);
  $$BackupMetadataTableTableManager get backupMetadata =>
      $$BackupMetadataTableTableManager(_db, _db.backupMetadata);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
