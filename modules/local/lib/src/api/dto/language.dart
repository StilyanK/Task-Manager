part of hms_local.api;

@DTOSerializable()
class LanguageDTO {
  int language_id;
  String name;
  String code;
  String locale;
  bool active;

  LanguageDTO();

  factory LanguageDTO.fromMap(Map data) => _$LanguageDTOFromMap(data);

  LanguageDTO.fromLanguage(Language lang) {
    language_id = lang.language_id;
    name = lang.name;
    code = lang.code;
    locale = lang.locale;
    active = lang.active;
  }

  Map toMap() => _$LanguageDTOToMap(this);
}
