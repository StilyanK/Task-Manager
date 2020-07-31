part of local.gui;

class LanguageList extends Listing {
  UrlPattern contr_get = RoutesLanguage.collectionGet;
  UrlPattern contr_del = RoutesLanguage.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$Language.language_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Language()
    ..height = 500
    ..width = 1000
    ..icon = Icon.Language;

  LanguageList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_language())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Language.name)
          ..title = intl.Language()
          ..filter = (new cl_form.Input()..setName(entity.$Language.name))
          ..width = '100%'
          ..sortable = true,
        new cl_form.GridColumn(entity.$Language.code)
          ..title = intl.Code()
          ..filter = (new cl_form.Input()..setName(entity.$Language.code)),
        new cl_form.GridColumn(entity.$Language.locale)
          ..title = intl.Locale()
          ..filter = (new cl_form.Input()..setName(entity.$Language.locale)),
        new cl_form.GridColumn(entity.$Language.active)
          ..title = intl.Active()
          ..sortable = true
      ];

  void onEdit(dynamic id) =>
      ap.run<Language>('language/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });

  void customRow(dynamic row, dynamic obj) {
    obj[entity.$Language.active] =
        obj[entity.$Language.active] ? intl.active() : intl.unactive();
  }
}
