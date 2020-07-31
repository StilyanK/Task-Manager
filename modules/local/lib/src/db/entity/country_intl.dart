part of local.entity;

@MSerializable()
class CountryIntl {
  int country_id;

  int language_id;

  String name;

  CountryIntl();

  void init(Map data) => _$CountryIntlFromMap(this, data);

  Map<String, dynamic> toMap() => _$CountryIntlToMap(this);

  Map<String, dynamic> toJson() => _$CountryIntlToMap(this, true);
}

class CountryIntlCollection<E extends CountryIntl> extends Collection<E> {
  CountryIntlCollection();

  void fromList(List data) {
    data.forEach((l) => add(new CountryIntl()..init(l)));
  }

  Map<String, String> getLanguageMap() {
    final m = <String, String>{};
    forEach((l) => m[l.language_id.toString()] = l.name);
    return m;
  }
}
