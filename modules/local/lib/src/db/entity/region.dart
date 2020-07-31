part of hms_local.entity;

@MSerializable()
class Region {
  String code;
  int country_id;
  int language_id;
  String name;

  Region();

  void init(Map data) => _$RegionFromMap(this, data);

  Map<String, dynamic> toJson() => _$RegionToMap(this);

  Map<String, dynamic> toMap() => _$RegionToMap(this);
}

class RegionCollection<E extends Region> extends Collection<E> {}
