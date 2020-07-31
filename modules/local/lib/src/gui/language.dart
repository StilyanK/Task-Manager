part of local.gui;

class Language extends ItemBuilder {
  UrlPattern contr_get = RoutesLanguage.itemGet;
  UrlPattern contr_save = RoutesLanguage.itemSave;
  UrlPattern contr_del = RoutesLanguage.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Language_title
    ..height = 500
    ..width = 600
    ..icon = Icon.Language;

  Language(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$Language.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Active(),
          [new cl_form.Check('bool')..setName(entity.$Language.active)])
      ..addRow(intl.Language(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$Language.name)
      ])
      ..addRow(intl.Code(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setClass('xs')
          ..setName(entity.$Language.code)
      ])
      ..addRow(intl.Locale(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setClass('s')
          ..setName(entity.$Language.locale)
      ]);
  }
}
