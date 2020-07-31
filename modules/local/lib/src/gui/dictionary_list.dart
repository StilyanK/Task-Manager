part of local.gui;

class DictionaryList extends Listing {
  UrlPattern contr_get = RoutesDictionary.collectionGet;
  UrlPattern contr_del = RoutesDictionary.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$Dictionary.dictionary_id;
  cl_form.GridOrder order =
      new cl_form.GridOrder(entity.$Dictionary.dictionary_id, 'DESC');

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Dictionary()
    ..height = 700
    ..width = 1000
    ..icon = Icon.Dictionary;

  DictionaryList(ap) : super(ap) {
    menu
      ..add(new cl_action.Button()
        ..setStyle({'margin-left': 'auto'})
        ..setTitle(intl.Add_translation())
        ..setIcon(cl.Icon.add)
        ..addClass('important')
        ..addAction((e) => onEdit(0)))
      ..add(new cl_action.Button()
        ..setTitle(intl.Parse_files())
        ..setIcon(cl.Icon.code)
        ..addAction((e) => parse()));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Dictionary.name)
          ..title = intl.Name()
          ..filter = (new cl_form.Input()..setName(entity.$Dictionary.name))
          ..width = '100%'
          ..sortable = true,
        new cl_form.GridColumn('translated')
          ..title = intl.Translated()
          ..filter = (new cl_form.Input()..setName(entity.$Dictionary.name))
          ..width = '100%'
          ..sortable = true
      ];

  Future parse() async {
    final n = await ap.serverCall(RoutesDictionary.getTR.reverse([]), null);
    final cont = new cl.Container()
      ..append(new ParagraphElement()..text = intl.New_matches(n));
    new cl_app.Dialog(ap, cont)
      ..icon = cl.Icon.code
      ..title = intl.Parse_files()
      ..render();
  }

  void onEdit(dynamic id) =>
      ap.run<Dictionary>('dictionary/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });
}
