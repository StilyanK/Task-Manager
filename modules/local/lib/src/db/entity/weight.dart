part of hms_local.entity;

@MSerializable()
class WeightUnit {
  int weight_unit_id;

  String unit;

  Map intl;

  num value;

  WeightUnit();

  void init(Map data) => _$WeightUnitFromMap(this, data);

  Map<String, dynamic> toMap() => _$WeightUnitToMap(this);

  Map<String, dynamic> toJson() => _$WeightUnitToMap(this, true);

  dynamic getUnit([int language_id]) {
    if (language_id == null) return unit;
    final key = language_id.toString();
    return intl.containsKey(key) ? intl[key] : intl.values.first;
  }
}

class WeightUnitCollection<E extends WeightUnit> extends Collection<E> {
  List<Map<String, dynamic>> pair([int language_id]) => map((weight) =>
      {'k': weight.weight_unit_id, 'v': weight.getUnit(language_id)}).toList();

  List<Map<String, String>> toJson() =>
      map((entity) => entity.toJson()).toList();
}
