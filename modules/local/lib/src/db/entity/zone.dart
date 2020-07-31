part of hms_local.entity;

@MSerializable()
class CountryZone {
  int country_zone_id;

  int country_id;

  String name;

  String iso;

  double geo_lat;

  double geo_lng;

  int active;

  Country country;
  CountryZoneIntlCollection languages;

  CountryZone();

  void init(Map data) => _$CountryZoneFromMap(this, data);

  Map<String, dynamic> toMap() => _$CountryZoneToMap(this);

  Map<String, dynamic> toJson() => _$CountryZoneToMap(this, true);

  String getName([dynamic language_id]) {
    if (language_id != null && languages != null) {
      for (final language in languages)
        if (language.language_id == language_id)
          return (language.name.isNotEmpty) ? language.name : name;
    }
    return name;
  }
}

class CountryZoneCollection<E extends CountryZone> extends Collection<E> {
  CountryZoneCollection();

  void fromList(List data) {
    data.forEach((m) => add(new CountryZone()..init(m)));
  }

  List pair([dynamic language_id]) {
    final l = map((country_zone) => {
          'k': country_zone.country_zone_id,
          'v': country_zone.getName(language_id)
        }).toList()
      ..sort((a, b) => (a['v'] as String).compareTo(b['v']));
    return l;
  }
}
