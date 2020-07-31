part of hms_local.gui;

class Country extends ItemBuilder {
  UrlPattern contr_get = RoutesCountry.itemGet;
  UrlPattern contr_save = RoutesCountry.itemSave;
  UrlPattern contr_del = RoutesCountry.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.country_title
    ..height = 500
    ..width = 600
    ..icon = Icon.Country;

  Country(ap, [id]) : super(ap, id);

  Future setData() async {
    if (data_response != null) {
      final languages = data_response.remove('languages');
      form.setValue(data_response);

      if (languages is List) {
        final langs = new entity.CountryIntlCollection()..fromList(languages);
        form.getElement('languages').setValue(langs.getLanguageMap());
      }
    }
  }

  Future setDefaults() async {
    form.getElement(entity.$Country.active).setValue(1);
    form.getElement(entity.$Country.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);
    t1
      ..addRow(
          intl.Active(), [new cl_form.Check()..setName(entity.$Country.active)])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$Country.name)
          ..addClass('max')
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName('languages')
          ..addClass('max')
      ])
      ..addRow(intl.ISO(), [
        new cl_form.Input()
          ..addClass('s')
          ..setName(entity.$Country.iso)
      ]);
  }
}
