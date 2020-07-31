part of hms_local.shared;

class LabUnitService {
  static LabUnitService instance;

  LaboratoryUnitCollection _dc;

  factory LabUnitService([LaboratoryUnitCollection dc]) {
    if (instance == null || dc != null) instance = new LabUnitService._(dc);
    return instance;
  }

  LabUnitService._(dc) {
    _dc = dc;
  }

  LaboratoryUnitCollection getCollection() => _dc;

  List<Map<String, dynamic>> pair() => _dc.pair();

  String get(String value, int laboratory_unit_id, [String system]) {
    final v = value ?? '';
    final s = getSymbol(laboratory_unit_id, system);
    if (s.isEmpty)
      return '$v';
    else
      return '$v [ $s ]';
  }

  String getUnitById(int laboratory_unit_id) {
    final dim = _dc.firstWhere(
        (d) => d.laboratory_unit_id == laboratory_unit_id,
        orElse: () => null);
    return dim?.name;
  }

  int getIdByUnitName(String unitName) {
    final dim = _dc.firstWhere((d) => d.name == unitName, orElse: () => null);
    return dim?.laboratory_unit_id;
  }

  String getSymbol(dynamic laboratory_unit_id,
      [String system = 'Conventional']) {
    final dim = _dc.firstWhere(
        (d) => d.laboratory_unit_id == laboratory_unit_id && d.system == system,
        orElse: () => null);
    return dim != null ? dim.name : '';
  }
}
