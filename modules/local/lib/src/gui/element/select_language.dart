part of hms_local.gui;

class SelectLanguage extends cl_form.Select {
  SelectLanguage() : super() {
    final cur = new shared.LanguageService();
    cur.getCollection().forEach((l) {
      addOption(l.language_id, l.name);
    });
  }
}
