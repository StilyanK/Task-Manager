part of hms_local.gui;

class CountryList extends Listing {
  UrlPattern contr_get = RoutesCountry.collectionGet;
  UrlPattern contr_del = RoutesCountry.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$Country.country_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Countries()
    ..height = 800
    ..width = 1000
    ..icon = Icon.Country;

  CountryList(ap, {bool autoload = true}) : super(ap, autoload: autoload) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_country())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<String> initOrder() => [entity.$Country.name, 'ASC'];

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Country.name)
          ..title = intl.Country()
          ..filter = (new cl_form.Input()..setName(entity.$Country.name))
          ..width = '100%'
          ..sortable = true,
        new cl_form.GridColumn(entity.$Country.iso)..title = 'ISO',
        new cl_form.GridColumn(entity.$Country.active)
          ..title = intl.Active()
          ..filter = (new cl_form.Select()
            ..setName(entity.$Country.active)
            ..addOption(null, intl.all())
            ..addOption(1, intl.active())
            ..addOption(0, intl.unactive())
            ..addClass('m'))
          ..sortable = true
      ];

  void onEdit(dynamic id) =>
      ap.run<Country>('country/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });

  void customRow(dynamic row, dynamic obj) {
    obj[entity.$Country.active] =
        (obj[entity.$Country.active] != 0) ? intl.active() : intl.unactive();
  }
}
