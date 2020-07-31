part of local.entity;

@MSerializable()
class QuantityUnit {
  int quantity_unit_id;

  String unit;

  Map intl;

  num value;

  QuantityUnit();

  void init(Map data) => _$QuantityUnitFromMap(this, data);

  Map<String, dynamic> toMap() => _$QuantityUnitToMap(this);

  Map<String, dynamic> toJson() => _$QuantityUnitToMap(this, true);

  String getUnit([int language_id]) {
    if (language_id == null) return unit;
    final key = language_id.toString();
    return intl.containsKey(key) ? intl[key] : intl.values.first;
  }
}

class QuantityUnitCollection<E extends QuantityUnit> extends Collection<E> {
  List<Map> pair([int language_id]) => map((quantity) => {
        'k': quantity.quantity_unit_id,
        'v': quantity.getUnit(language_id)
      }).toList();

  List<Map> toJson() => map((entity) => entity.toJson()).toList();
}
