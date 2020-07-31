part of hms_local.gui;

class Currency extends ItemBuilder {
  UrlPattern contr_get = RoutesCurrency.itemGet;
  UrlPattern contr_save = RoutesCurrency.itemSave;
  UrlPattern contr_del = RoutesCurrency.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Currency_title
    ..height = 600
    ..width = 600
    ..icon = Icon.Currency;

  Currency(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$Currency.title).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);
    t1
      ..addRow(intl.Active(),
          [new cl_form.Check('bool')..setName(entity.$Currency.active)])
      ..addRow(intl.Code(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$Currency.title)
      ])
      ..addRow(intl.Symbol(),
          [new cl_form.Input()..setName(entity.$Currency.symbol)])
      ..addRow(intl.Symbol_at_left(),
          [new cl_form.Check()..setName(entity.$Currency.symbol_position)])
      ..addRow(intl.Rounding(), [
        new cl_form.Select()
          ..addOption(0, '#.00')
          ..addOption(1, '#.#0')
          ..addOption(4, '#.25')
          ..addOption(3, '#.50')
          ..addOption(2, '#.##')
          ..setName('round')
      ]);
  }
}
