part of hms_local.entity;

@MSerializable()
class Place {
  int place_id;
  String name;
  String region_code;
  String rhif_id;
  bool is_city;

  Region region;
  Rhif rhif;

  Place();

  String getRepresentation() {
    final form = is_city ? 'гр.' : 'с.';
    return '$form $name';
  }

  void init(Map data) => _$PlaceFromMap(this, data);

  Map<String, dynamic> toJson() => _$PlaceToMap(this);

  Map<String, dynamic> toMap() => _$PlaceToMap(this);

  Future<Rhif> loadRHIF() async => null;

  Future<Region> loadRegion() async => null;
}

class PlaceCollection<E extends Place> extends Collection<E> {}
