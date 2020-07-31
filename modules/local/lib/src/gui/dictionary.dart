part of hms_local.gui;

class Dictionary extends ItemBuilder {
  UrlPattern contr_get = RoutesDictionary.itemGet;
  UrlPattern contr_save = RoutesDictionary.itemSave;
  UrlPattern contr_del = RoutesDictionary.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Dictionary_title
    ..height = 500
    ..width = 600
    ..icon = Icon.Dictionary;

  Dictionary(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$Dictionary.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Name(), [
        new cl_form.Input()
          ..setRequired(true)
          ..addClass('max')
          ..setName(entity.$Dictionary.name)
      ])
      ..addRow(intl.Translation(), [
        new cl_form.LangArea(ap.client.data['language'])
          ..addClass('max')
          ..setName(entity.$Dictionary.intl)
      ]);
  }
}
