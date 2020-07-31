part of local.shared;

class LanguageService {
  static LanguageService instance;

  LanguageCollection _dc;

  final _language = <int, Language>{};

  factory LanguageService([LanguageCollection dc]) {
    if (instance == null || dc != null) instance = new LanguageService._(dc);
    return instance;
  }

  LanguageService._(dc) {
    _dc = dc;
    _setLanguage();
  }

  LanguageCollection getCollection() => _dc;

  void _setLanguage() {
    _dc ??= (new LanguageCollection()
      ..add(new Language()
        ..language_id = 1
        ..code = 'bg'
        ..locale = 'bg'
        ..name = 'BG'));
    _dc.forEach((d) => _language[d.language_id] = d);
  }

  String getLocale(int language_id) => _language[language_id].locale;

  int getLanguageId(String locale) {
    var id = 0;
    _language.forEach((k, v) {
      if (v.locale == locale) id = v.language_id;
    });
    return id;
  }

  String getUserLocale(Map session) {
    if (session['client']['settings'] != null)
      return session['client']['settings']['language'];
    return null;
  }

  int getUserLanguageId(Map session) => getLanguageId(getUserLocale(session));

  List<Map<String, dynamic>> pair() => _dc.pair();
}
