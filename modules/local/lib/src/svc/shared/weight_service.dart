part of local.shared;

class WeightService {
  static WeightService instance;

  WeightUnitCollection _dc;

  factory WeightService([WeightUnitCollection dc]) {
    if (instance == null || dc != null) instance = new WeightService._(dc);
    return instance;
  }

  WeightService._(dc) {
    _dc = dc;
  }

  WeightUnitCollection getCollection() => _dc;

  List<Map<String, dynamic>> pair() => _dc.pair();

  String get(double weight, int weight_unit_id, [dynamic localeOrLanguageId]) {
    final language_id = (localeOrLanguageId is String)
        ? new LanguageService().getLanguageId(localeOrLanguageId)
        : localeOrLanguageId;
    final wgt = _dc.firstWhere((d) => d.weight_unit_id == weight_unit_id,
        orElse: () => null);
    return '$weight${wgt != null ? ' ${wgt.getUnit(language_id)}' : ''}';
  }

  String getUnitById(int weight_unit_id) {
    final dim = _dc.firstWhere((d) => d.weight_unit_id == weight_unit_id,
        orElse: () => null);
    return dim?.unit;
  }

  int getIdByUnit(String unit) {
    final dim = _dc.firstWhere((d) => d.unit == unit, orElse: () => null);
    return dim?.weight_unit_id;
  }
}
