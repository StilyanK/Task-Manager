part of local.shared;

class DrugUnit {
  num value;
  String unit;

  DrugUnit(this.value, this.unit) {
    value ??= 0;
  }

  factory DrugUnit.fromMap(Map data) =>
      new DrugUnit(data['value'], data['unit']);

  String getUnit([dynamic localeOrLanguageId]) {
    final language_id =
        (localeOrLanguageId is String || localeOrLanguageId == null)
            ? new LanguageService()
                .getLanguageId(localeOrLanguageId ?? Intl.defaultLocale)
            : localeOrLanguageId;
    final u = new QuantityService().getIdByUnit(unit);
    if (u != null) return new QuantityService().getSymbol(u, language_id);
    return unit;
  }

  Map toMap() => {'value': value, 'unit': unit};

  Map toJson() => toMap();
}

class DrugConvert {
  static const String pcs = 'pcs';
  static const String ml = 'ml';
  static const String onePcs = '1:$pcs';

  String data;
  final _units = <DrugUnit>[];
  DrugUnit quantity;
  num _factor = 1;

  int quantity_unit_id;
  int quantity_unit_alt;
  int quantity_unit_base;
  num quantity_unit_factor;

  DrugConvert(this.data,
      {this.quantity_unit_id,
      this.quantity_unit_alt,
      this.quantity_unit_base,
      this.quantity_unit_factor}) {
    try {
      _parse();
      if (_units.every((r) => r.unit != pcs)) _units.add(new DrugUnit(1, pcs));
    } catch (e) {
      _units.add(new DrugUnit(1, pcs));
    }
  }

  factory DrugConvert.fromMap(Map data) {
    final dc = new DrugConvert(data['as_total'],
        quantity_unit_id: data['quantity_unit_id'],
        quantity_unit_alt: data['quantity_unit_alt'],
        quantity_unit_base: data['quantity_unit_base'],
        quantity_unit_factor: data['quantity_unit_factor']);
    if (data['as_unit'] != null)
      dc.set(new DrugUnit(data['as_quantity'], data['as_unit']));
    return dc;
  }

  void _parse() {
    final manyIngredients = data.contains('/');
    if (manyIngredients) {
      data.split('/').forEach((part) {
        final ip = part.split(':');
        _units.add(new DrugUnit(num.parse(ip.first), ip.last));
      });
    } else {
      final ip = data.split(':');
      _units.add(new DrugUnit(num.parse(ip.first), ip.last));
    }
  }

  List<String> getUnits() => _units.map<String>((u) => u.unit).toList();

  List<Map> getUnitsPair() =>
      _units.map<Map>((u) => {'k': u.unit, 'v': u.getUnit()}).toList();

  void set(DrugUnit unit) {
    quantity = unit;
    final t = _units.firstWhere((u) => u.unit == quantity.unit);
    _factor = t.value / quantity.value;
  }

  String getDescription() {
    final temp = _units
        .where((u) => u.unit != pcs)
        .map<String>((u) => '${getQuantityRelative(u.value)} ${u.getUnit()}')
        .toList()
          ..add(getRepresentation());
    return temp.join(', ');
  }

  String getRepresentation([int precision = 2]) {
    final _first = new Quantity()
      ..quantity = getQuantity(precision)
      ..quantity_unit_id = quantity_unit_id;
    if (quantity_unit_alt != null) {
      Quantity _second = new Quantity()
        ..quantity = getQuantity(precision)
        ..quantity_unit_id = quantity_unit_alt;
      _second /= quantity_unit_factor;
      return '${_first.toStringSymboled()} (${_second.toStringSymboled()})';
    }
    return _first.toStringSymboled();
  }

  num getQuantityRelative(num value, [int precision = 2]) =>
      num.parse((value / _factor).toStringAsFixed(precision));

  num getQuantity([int precision = 2]) =>
      num.parse((1 / _factor).toStringAsFixed(precision));

  num getQuantityInUnit(String unit, [int precision = 2]) {
    final u = _units.firstWhere((u) => u.unit == unit, orElse: () => null);
    if (u == null) return null;
    return getQuantityRelative(u.value);
  }

  Quantity getProductQuantity([int precision = 2]) {
    if (quantity_unit_id != null) {
      return new Quantity()
        ..quantity = getQuantity(precision)
        ..quantity_unit_id = quantity_unit_id
        ..quantity_unit_alt = quantity_unit_alt
        ..quantity_unit_base = quantity_unit_base
        ..quantity_unit_factor = quantity_unit_factor;
    } else {
      return null;
    }
  }

  Quantity getProductQuantityAlt([int precision = 2]) {
    if (quantity_unit_alt != null && quantity_unit_factor != null) {
      Quantity _second = new Quantity()
        ..quantity = getQuantity(precision)
        ..quantity_unit_id = quantity_unit_alt;
      return _second /= quantity_unit_factor;
    } else {
      return null;
    }
  }

  Map toMap() => {
        'as_quantity': quantity?.value,
        'as_unit': quantity?.unit,
        'as_total': data,
        'quantity_unit_id': quantity_unit_id,
        'quantity_unit_alt': quantity_unit_alt,
        'quantity_unit_base': quantity_unit_id,
        'quantity_unit_factor': quantity_unit_factor
      };

  Map toJson() => toMap();
}
