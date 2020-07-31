part of hms_local.entity;

@MSerializable()
class Country {
  int country_id;

  String name;

  String iso;

  double geo_lat;

  double geo_lng;

  int active;

  CountryZoneCollection zones;

  CountryIntlCollection languages;

  Country();

  void init(Map data) => _$CountryFromMap(this, data);

  Map<String, dynamic> toMap() => _$CountryToMap(this);

  Map<String, dynamic> toJson() => _$CountryToMap(this, true);

  String getName([dynamic language_id]) {
    if (language_id != null && languages != null) {
      for (final language in languages)
        if (language.language_id == language_id)
          return (language.name.isNotEmpty) ? language.name : name;
    }
    return name;
  }
}

class CountryCollection<E extends Country> extends Collection<E> {
  List<Map> pair([dynamic language_id]) => map((country) => {
        'k': country.country_id,
        'v': '${country.getName(language_id)} (${country.iso})',
        'iso2': country.iso
      }).toList();

  List<Map> pairCodes([dynamic language_id]) =>
      map((country) => {'k': country.iso, 'v': country.getName(language_id)})
          .toList();
}
