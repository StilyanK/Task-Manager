part of local.gui;

class Zone extends ItemBuilder {
  UrlPattern contr_get = RoutesZone.itemGet;
  UrlPattern contr_save = RoutesZone.itemSave;
  UrlPattern contr_del = RoutesZone.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.zone_title
    ..icon = Icon.Zone
    ..width = 600
    ..height = 500;

  Zone(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$CountryZone.active).setValue(1);
    form.getElement(entity.$CountryZone.name).focus();
  }

  Future<void> setData() async {
    if (data_response != null) {
      final languages = data_response.remove('languages');
      form.setValue(data_response);
      if (languages is List) {
        final lang = new entity.CountryZoneIntlCollection()
          ..fromList(languages);
        form.getElement('languages').setValue(lang.getLanguageMap());
      }
    }
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Active(),
          [new cl_form.Check()..setName(entity.$CountryZone.active)])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$CountryZone.name)
          ..addClass('max')
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName('languages')
          ..addClass('max')
      ])
      ..addRow(intl.Country(), [
        new SelectCountry(ap, [0, ''])
          ..setName(entity.$CountryZone.country_id)
          ..load()
      ])
      ..addRow('ISO', [
        new cl_form.Input()
          ..addClass('s')
          ..setName(entity.$CountryZone.iso)
      ]);
  }
}

class ZoneList extends Listing {
  UrlPattern contr_get = RoutesZone.collectionGet;
  UrlPattern contr_del = RoutesZone.collectionPair;

  String mode = Listing.MODE_LIST;
  String key = entity.$CountryZone.country_zone_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Zones()
    ..width = 1000
    ..height = 500
    ..icon = 'globe-wire';

  ZoneList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_zone())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$CountryZone.name)
          ..title = intl.Zone()
          ..filter = (new cl_form.Input()..setName(entity.$CountryZone.name))
          ..width = '100%'
          ..sortable = true,
        new cl_form.GridColumn('country')
          ..title = intl.Country()
          ..filter = (new cl_form.Input()..setName('country')),
        new cl_form.GridColumn(entity.$CountryZone.iso)..title = 'ISO',
        new cl_form.GridColumn(entity.$CountryZone.active)
          ..title = intl.Active()
          ..filter = (new cl_form.Select()
            ..setName(entity.$CountryZone.active)
            ..addOption(null, intl.all())
            ..addOption(1, intl.active())
            ..addOption(0, intl.unactive())
            ..addClass('m'))
          ..sortable = true
      ];

  void onEdit(dynamic id) =>
      ap.run<Zone>('zone/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });

  void customRow(dynamic row, Map obj) {
    obj[entity.$CountryZone.active] = (obj[entity.$CountryZone.active] != 0)
        ? intl.active()
        : intl.unactive();
  }
}
