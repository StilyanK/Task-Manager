part of local.shared;

class QuantityService {
  static QuantityService instance;

  QuantityUnitCollection _dc;

  factory QuantityService([QuantityUnitCollection dc]) {
    if (instance == null || dc != null) instance = new QuantityService._(dc);
    return instance;
  }

  QuantityService._(dc) {
    _dc = dc ??
        (new QuantityUnitCollection()
          ..add(new QuantityUnit()
            ..quantity_unit_id = 1
            ..unit = 'pcs'
            ..intl = {'1': 'бр'}));
  }

  QuantityUnitCollection getCollection() => _dc;

  List<Map> pair() => _dc.pair();

  String get(num quantity, int quantity_unit_id, [dynamic localeOrLanguageId]) {
    final language_id = (localeOrLanguageId is String)
        ? new LanguageService().getLanguageId(localeOrLanguageId)
        : localeOrLanguageId;
    var q = quantity;
    if (quantity.toString().split('.').last == '0') q = quantity.toInt();
    return '$q ${getSymbol(quantity_unit_id, language_id)}';
  }

  String getUnitById(int quantity_unit_id) {
    final dim = _dc.firstWhere((d) => d.quantity_unit_id == quantity_unit_id,
        orElse: () => null);
    return dim?.unit;
  }

  int getIdByUnit(String unit) {
    final dim = _dc.firstWhere((d) => d.unit == unit, orElse: () => null);
    return dim?.quantity_unit_id;
  }

  String getSymbol(dynamic quantity_unit_id, [int language_id]) {
    final dim = _dc.firstWhere((d) => d.quantity_unit_id == quantity_unit_id,
        orElse: () => null);
    return dim != null ? dim.getUnit(language_id) : '';
  }
}
