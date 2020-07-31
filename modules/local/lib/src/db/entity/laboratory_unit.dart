part of hms_local.entity;

@MSerializable()
class LaboratoryUnit {
  int laboratory_unit_id;
  String name;
  String system;

  LaboratoryUnit();

  void init(Map data) => _$LaboratoryUnitFromMap(this, data);

  Map<String, dynamic> toJson() => _$LaboratoryUnitToMap(this, true);

  Map<String, dynamic> toMap() => _$LaboratoryUnitToMap(this);
}

class LaboratoryUnitCollection<E extends LaboratoryUnit> extends Collection<E> {
  List<Map<String, dynamic>> pair() =>
      map((u) => {'k': u.laboratory_unit_id, 'v': u.name}).toList();
}
