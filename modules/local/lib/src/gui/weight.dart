part of hms_local.gui;

class WeightUnit extends ItemBuilder {
  UrlPattern contr_get = RoutesWeight.itemGet;
  UrlPattern contr_save = RoutesWeight.itemSave;
  UrlPattern contr_del = RoutesWeight.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Weight_title
    ..width = 500
    ..height = 300
    ..icon = Icon.Weight;

  WeightUnit(ap, [id]) : super(ap, id) {
    addHook(ItemBase.save_after, (_) {
      ap.serverCall(RoutesWeight.reload.reverse([]), {}).then(
          (d) => initWeightUnits(d['weight']));
      return true;
    });
  }

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$WeightUnit.unit).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Unit(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$WeightUnit.unit)
      ])
      ..addRow(intl.Languages(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$WeightUnit.intl)
      ])
      ..addRow(intl.Value(), [
        new cl_form.Input(new cl_form.InputTypeDouble())
          ..setName(entity.$WeightUnit.value)
      ]);
  }
}

class WeightUnitList extends Listing {
  UrlPattern contr_get = RoutesWeight.collectionGet;
  UrlPattern contr_del = RoutesWeight.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$WeightUnit.weight_unit_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Weight()
    ..width = 1000
    ..height = 500
    ..icon = 'weight';

  WeightUnitList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_weight())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$WeightUnit.unit)
          ..title = intl.Unit()
          ..filter = (new cl_form.Input()..setName(entity.$WeightUnit.unit))
          ..width = '100%'
          ..sortable = true,
        new cl_form.GridColumn(entity.$WeightUnit.value)
          ..title = intl.Value()
          ..sortable = true
      ];

  void onEdit(dynamic id) => ap
          .run<WeightUnit>('weight_units/$id')
          .addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });
}

class SelectWeight extends cl_form.Select {
  SelectWeight() : super() {
    final q = new shared.WeightService();
    q.getCollection().forEach((v) => addOption(
        v.weight_unit_id,
        v.getUnit(
            new shared.LanguageService().getLanguageId(Intl.defaultLocale))));
  }
}
