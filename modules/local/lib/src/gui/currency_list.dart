part of local.gui;

class CurrencyList extends Listing {
  UrlPattern contr_get = RoutesCurrency.collectionGet;
  UrlPattern contr_del = RoutesCurrency.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$Currency.currency_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Currencies()
    ..height = 700
    ..width = 1000
    ..icon = Icon.Currency;

  CurrencyList(ap) : super(ap) {
    menu
      ..add(new cl_action.Button()
        ..setStyle({'margin-left': 'auto'})
        ..setTitle(intl.Add_currency())
        ..setIcon(cl.Icon.add)
        ..addClass('important')
        ..addAction((e) => onEdit(0)))
      ..add(new cl_action.Button()
        ..setTitle(intl.Currency_update())
        ..setIcon(cl.Icon.sync)
        ..addAction((e) => updateCurrencies()));
  }

  Future<dynamic> updateCurrencies() =>
      ap.serverCall(RoutesCurrency.update.reverse([]), null, layout);

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Currency.title)
          ..title = intl.Code()
          ..filter = (new cl_form.Input()..setName(entity.$Currency.title))
          ..sortable = true,
        new cl_form.GridColumn(entity.$CurrencyData.rate)
          ..title = intl.Rate_to_EUR()
          ..filter = (new cl_form.Input()..setName(entity.$Currency.title)),
        new cl_form.GridColumn('date')
          ..title = intl.Updated()
          ..type = (grid, row, cell, object) =>
              new DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Currency.symbol)..title = intl.Symbol(),
        new cl_form.GridColumn('round')..title = intl.Rounding(),
        new cl_form.GridColumn(entity.$Currency.active)
          ..title = intl.Active()
          ..sortable = true
      ];

  void onEdit(dynamic id) =>
      ap.run<Currency>('currency/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });

  void customRow(dynamic row, dynamic obj) {
    obj[entity.$Currency.active] =
        obj[entity.$Currency.active] ? intl.active() : intl.unactive();
  }
}
