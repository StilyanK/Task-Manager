part of hms_local.gui;

class LaboratoryUnitList extends Listing {
  UrlPattern contr_get = RoutesLabUnit.collectionGet;
  UrlPattern contr_del = RoutesLabUnit.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$LaboratoryUnit.laboratory_unit_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Quantity()
    ..height = 500
    ..width = 1000
    ..icon = hms_icon.Icon.units;

  LaboratoryUnitList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_Unit())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$LaboratoryUnit.name)
          ..title = intl.name()
          ..filter = (new cl_form.Input()..setName(entity.$QuantityUnit.unit)),
        new cl_form.GridColumn(entity.$LaboratoryUnit.system)
          ..title = intl.System()
          ..filter = (new cl_form.Input()..setName(entity.$WeightUnit.unit)),
      ];

  void onEdit(dynamic id) => ap
          .run<LaboratoryUnit>('quantity_units/$id')
          .addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });
}
