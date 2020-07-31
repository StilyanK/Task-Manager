part of hms_local.entity;

@MSerializable()
class CountryZoneIntl {
  int country_zone_id;

  int language_id;

  String name;

  CountryZoneIntl();

  void init(Map data) => _$CountryZoneIntlFromMap(this, data);

  Map<String, dynamic> toMap() => _$CountryZoneIntlToMap(this);

  Map<String, dynamic> toJson() => _$CountryZoneIntlToMap(this, true);
}

class CountryZoneIntlCollection<E extends CountryZoneIntl>
    extends Collection<E> {
  CountryZoneIntlCollection();

  void fromList(List data) {
    data.forEach((l) => add(new CountryZoneIntl()..init(l)));
  }

  Map<String, String> getLanguageMap() {
    final m = <String, String>{};
    forEach((o) => m[o.language_id.toString()] = o.name);
    return m;
  }
}
