part of hms_local.entity;

@MSerializable()
class Language {
  int language_id;

  String name;

  String code;

  String locale;

  bool active;

  int position;

  Language();

  void init(Map data) => _$LanguageFromMap(this, data);

  Map<String, dynamic> toMap() => _$LanguageToMap(this);

  Map<String, dynamic> toJson() => _$LanguageToMap(this, true);
}

class LanguageCollection<E extends Language> extends Collection<E> {
  List<Map<String, dynamic>> pair() => map<Map<String, dynamic>>(
      (language) => {'k': language.language_id, 'v': language.name}).toList();
}
