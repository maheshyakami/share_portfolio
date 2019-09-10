// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Share extends DataClass implements Insertable<Share> {
  final String name;
  final int units;
  final String type;
  final String boughtDate;
  final double boughtPrice;
  Share(
      {@required this.name,
      @required this.units,
      @required this.type,
      @required this.boughtDate,
      @required this.boughtPrice});
  factory Share.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Share(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      units: intType.mapFromDatabaseResponse(data['${effectivePrefix}units']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      boughtDate: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}bought_date']),
      boughtPrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}bought_price']),
    );
  }
  factory Share.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Share(
      name: serializer.fromJson<String>(json['name']),
      units: serializer.fromJson<int>(json['units']),
      type: serializer.fromJson<String>(json['type']),
      boughtDate: serializer.fromJson<String>(json['boughtDate']),
      boughtPrice: serializer.fromJson<double>(json['boughtPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'name': serializer.toJson<String>(name),
      'units': serializer.toJson<int>(units),
      'type': serializer.toJson<String>(type),
      'boughtDate': serializer.toJson<String>(boughtDate),
      'boughtPrice': serializer.toJson<double>(boughtPrice),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Share>>(bool nullToAbsent) {
    return SharesCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      units:
          units == null && nullToAbsent ? const Value.absent() : Value(units),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      boughtDate: boughtDate == null && nullToAbsent
          ? const Value.absent()
          : Value(boughtDate),
      boughtPrice: boughtPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(boughtPrice),
    ) as T;
  }

  Share copyWith(
          {String name,
          int units,
          String type,
          String boughtDate,
          double boughtPrice}) =>
      Share(
        name: name ?? this.name,
        units: units ?? this.units,
        type: type ?? this.type,
        boughtDate: boughtDate ?? this.boughtDate,
        boughtPrice: boughtPrice ?? this.boughtPrice,
      );
  @override
  String toString() {
    return (StringBuffer('Share(')
          ..write('name: $name, ')
          ..write('units: $units, ')
          ..write('type: $type, ')
          ..write('boughtDate: $boughtDate, ')
          ..write('boughtPrice: $boughtPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc($mrjc($mrjc(0, name.hashCode), units.hashCode), type.hashCode),
          boughtDate.hashCode),
      boughtPrice.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Share &&
          other.name == name &&
          other.units == units &&
          other.type == type &&
          other.boughtDate == boughtDate &&
          other.boughtPrice == boughtPrice);
}

class SharesCompanion extends UpdateCompanion<Share> {
  final Value<String> name;
  final Value<int> units;
  final Value<String> type;
  final Value<String> boughtDate;
  final Value<double> boughtPrice;
  const SharesCompanion({
    this.name = const Value.absent(),
    this.units = const Value.absent(),
    this.type = const Value.absent(),
    this.boughtDate = const Value.absent(),
    this.boughtPrice = const Value.absent(),
  });
}

class $SharesTable extends Shares with TableInfo<$SharesTable, Share> {
  final GeneratedDatabase _db;
  final String _alias;
  $SharesTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unitsMeta = const VerificationMeta('units');
  GeneratedIntColumn _units;
  @override
  GeneratedIntColumn get units => _units ??= _constructUnits();
  GeneratedIntColumn _constructUnits() {
    return GeneratedIntColumn(
      'units',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _boughtDateMeta = const VerificationMeta('boughtDate');
  GeneratedTextColumn _boughtDate;
  @override
  GeneratedTextColumn get boughtDate => _boughtDate ??= _constructBoughtDate();
  GeneratedTextColumn _constructBoughtDate() {
    return GeneratedTextColumn(
      'bought_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _boughtPriceMeta =
      const VerificationMeta('boughtPrice');
  GeneratedRealColumn _boughtPrice;
  @override
  GeneratedRealColumn get boughtPrice =>
      _boughtPrice ??= _constructBoughtPrice();
  GeneratedRealColumn _constructBoughtPrice() {
    return GeneratedRealColumn(
      'bought_price',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [name, units, type, boughtDate, boughtPrice];
  @override
  $SharesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'shares';
  @override
  final String actualTableName = 'shares';
  @override
  VerificationContext validateIntegrity(SharesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.units.present) {
      context.handle(
          _unitsMeta, units.isAcceptableValue(d.units.value, _unitsMeta));
    } else if (units.isRequired && isInserting) {
      context.missing(_unitsMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (type.isRequired && isInserting) {
      context.missing(_typeMeta);
    }
    if (d.boughtDate.present) {
      context.handle(_boughtDateMeta,
          boughtDate.isAcceptableValue(d.boughtDate.value, _boughtDateMeta));
    } else if (boughtDate.isRequired && isInserting) {
      context.missing(_boughtDateMeta);
    }
    if (d.boughtPrice.present) {
      context.handle(_boughtPriceMeta,
          boughtPrice.isAcceptableValue(d.boughtPrice.value, _boughtPriceMeta));
    } else if (boughtPrice.isRequired && isInserting) {
      context.missing(_boughtPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name, type};
  @override
  Share map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Share.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SharesCompanion d) {
    final map = <String, Variable>{};
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.units.present) {
      map['units'] = Variable<int, IntType>(d.units.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.boughtDate.present) {
      map['bought_date'] = Variable<String, StringType>(d.boughtDate.value);
    }
    if (d.boughtPrice.present) {
      map['bought_price'] = Variable<double, RealType>(d.boughtPrice.value);
    }
    return map;
  }

  @override
  $SharesTable createAlias(String alias) {
    return $SharesTable(_db, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
  final String name;
  final double ltp;
  Company({@required this.name, @required this.ltp});
  factory Company.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return Company(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      ltp: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}ltp']),
    );
  }
  factory Company.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Company(
      name: serializer.fromJson<String>(json['name']),
      ltp: serializer.fromJson<double>(json['ltp']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'name': serializer.toJson<String>(name),
      'ltp': serializer.toJson<double>(ltp),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Company>>(bool nullToAbsent) {
    return CompaniesCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      ltp: ltp == null && nullToAbsent ? const Value.absent() : Value(ltp),
    ) as T;
  }

  Company copyWith({String name, double ltp}) => Company(
        name: name ?? this.name,
        ltp: ltp ?? this.ltp,
      );
  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('name: $name, ')
          ..write('ltp: $ltp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc($mrjc(0, name.hashCode), ltp.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Company && other.name == name && other.ltp == ltp);
}

class CompaniesCompanion extends UpdateCompanion<Company> {
  final Value<String> name;
  final Value<double> ltp;
  const CompaniesCompanion({
    this.name = const Value.absent(),
    this.ltp = const Value.absent(),
  });
}

class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, Company> {
  final GeneratedDatabase _db;
  final String _alias;
  $CompaniesTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ltpMeta = const VerificationMeta('ltp');
  GeneratedRealColumn _ltp;
  @override
  GeneratedRealColumn get ltp => _ltp ??= _constructLtp();
  GeneratedRealColumn _constructLtp() {
    return GeneratedRealColumn(
      'ltp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [name, ltp];
  @override
  $CompaniesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'companies';
  @override
  final String actualTableName = 'companies';
  @override
  VerificationContext validateIntegrity(CompaniesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.ltp.present) {
      context.handle(_ltpMeta, ltp.isAcceptableValue(d.ltp.value, _ltpMeta));
    } else if (ltp.isRequired && isInserting) {
      context.missing(_ltpMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Company map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Company.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CompaniesCompanion d) {
    final map = <String, Variable>{};
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.ltp.present) {
      map['ltp'] = Variable<double, RealType>(d.ltp.value);
    }
    return map;
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(_db, alias);
  }
}

abstract class _$PortfolioDatabase extends GeneratedDatabase {
  _$PortfolioDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $SharesTable _shares;
  $SharesTable get shares => _shares ??= $SharesTable(this);
  $CompaniesTable _companies;
  $CompaniesTable get companies => _companies ??= $CompaniesTable(this);
  ShareDao _shareDao;
  ShareDao get shareDao => _shareDao ??= ShareDao(this as PortfolioDatabase);
  CompaniesDao _companiesDao;
  CompaniesDao get companiesDao =>
      _companiesDao ??= CompaniesDao(this as PortfolioDatabase);
  @override
  List<TableInfo> get allTables => [shares, companies];
}
