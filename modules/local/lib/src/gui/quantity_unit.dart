part of hms_local.gui;

class QuantityUnit extends ItemBuilder {
  UrlPattern contr_get = RoutesQuantity.itemGet;
  UrlPattern contr_save = RoutesQuantity.itemSave;
  UrlPattern contr_del = RoutesQuantity.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Quantity_title
    ..height = 300
    ..width = 500
    ..icon = Icon.Quantity;

  QuantityUnit(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$QuantityUnit.unit).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Unit(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$QuantityUnit.unit)
      ])
      ..addRow(intl.Languages(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$QuantityUnit.intl)
      ])
      ..addRow(intl.Value(), [
        new cl_form.Input(new cl_form.InputTypeDouble())
          ..setName(entity.$QuantityUnit.value)
      ]);
  }
}

class QuantityUnitList extends Listing {
  UrlPattern contr_get = RoutesQuantity.collectionGet;
  UrlPattern contr_del = RoutesQuantity.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$QuantityUnit.quantity_unit_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Quantity()
    ..icon = 'units'
    ..width = 1000
    ..height = 500;

  QuantityUnitList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_quantity())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$QuantityUnit.unit)
          ..title = intl.Unit()
          ..filter = (new cl_form.Input()..setName(entity.$QuantityUnit.unit))
          ..width = '100%'
          ..sortable = true,
        new cl_form.GridColumn(entity.$QuantityUnit.value)
          ..title = intl.Value()
          ..sortable = true
      ];

  void onEdit(dynamic id) => ap
          .run<QuantityUnit>('quantity_units/$id')
          .addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });
}
