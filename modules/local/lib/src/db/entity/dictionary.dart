part of local.entity;

@MSerializable()
class Dictionary {
  int dictionary_id;
  String name;
  Map<dynamic, String> intl;

  Dictionary();

  void init(Map data) => _$DictionaryFromMap(this, data);

  Map<String, dynamic> toMap() => _$DictionaryToMap(this);

  String getValue(int language_id) {
    final key = language_id.toString();
    if (intl.isEmpty) return name;
    return intl.containsKey(key) ? intl[key] : intl.values.first;
  }

  Map<String, dynamic> toJson() => _$DictionaryToMap(this, true);
}

class DictionaryCollection<E extends Dictionary> extends Collection<E> {
  Map<String, String> getMap(int language_id) {
    final m = <String, String>{};
    map((dic) => m[dic.name] = dic.getValue(language_id)).toList();
    return m;
  }
}
