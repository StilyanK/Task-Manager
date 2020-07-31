part of hms_local.shared;

class LabUnit {
  LabUnitService _lus;

  String value;

  int laboratory_unit_id;

  LabUnit([LabUnitService ls]) {
    _lus = ls ?? new LabUnitService();
  }

  LabUnit.fromMap(Map data, [LabUnitService ls]) {
    _lus = ls ?? new LabUnitService();
    value = data['value'];
    laboratory_unit_id = data['laboratory_unit_id'];
  }

  /*operator +(LabUnit lu) {
    var u = new LabUnit(_lus);
    u.value = value + lu.value;
    u.laboratory_unit_id = laboratory_unit_id;
    return u;
  }

  operator -(LabUnit lu) {
    var u = new LabUnit(_lus);
    u.value = value - lu.value;
    u.laboratory_unit_id = laboratory_unit_id;
    return u;
  }

  operator *(dynamic multiplier) {
    var u = new LabUnit(_lus);
    u.value = value * multiplier;
    u.laboratory_unit_id = laboratory_unit_id;
    return u;
  }

  operator /(dynamic delimiter) {
    var u = new LabUnit(_lus);
    u.value = value / delimiter;
    u.laboratory_unit_id = laboratory_unit_id;
    return u;
  }*/

  LabUnit convert(int laboratory_unit_id) {
    final u = new LabUnit(_lus)
      ..value = value
      ..laboratory_unit_id = laboratory_unit_id;
    return u;
  }

  LabUnit clone() => new LabUnit(_lus)
    ..value = value
    ..laboratory_unit_id = laboratory_unit_id;

  bool isIdentical(LabUnit u) => laboratory_unit_id == u.laboratory_unit_id;

  String toStringSymboled([String System = 'Conventional']) =>
      _lus.get(value, laboratory_unit_id, System);

  Map<String, dynamic> toMap() =>
      {'value': value, 'laboratory_unit_id': laboratory_unit_id};

  Map<String, dynamic> toJson() => toMap();

  String toString() => toStringSymboled();
}
