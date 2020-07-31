part of hms_local.entity;

@MSerializable()
class Rhif {
  String rhif_id;
  String region_code;
  String code;
  String name;

  Rhif();

  void init(Map data) => _$RhifFromMap(this, data);

  Map<String, dynamic> toJson() => _$RhifToMap(this);

  Map<String, dynamic> toMap() => _$RhifToMap(this);
}

class RhifCollection<E extends Rhif> extends Collection<E> {}
