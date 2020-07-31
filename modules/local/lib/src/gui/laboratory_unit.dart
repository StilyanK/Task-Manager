part of hms_local.gui;

class LaboratoryUnit extends ItemBuilder {
  UrlPattern contr_get = RoutesLabUnit.itemGet;
  UrlPattern contr_save = RoutesLabUnit.itemSave;
  UrlPattern contr_del = RoutesLabUnit.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Laboratory_unit_title()
    ..height = 300
    ..width = 500
    ..icon = hms_icon.Icon.units;

  LaboratoryUnit(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$LaboratoryUnit.name).focus();
  }

  void setUI() {
    final unitForm = new cl_gui.FormElement(form)
      ..addRow(intl.Unit(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$LaboratoryUnit.name)
      ])
      ..addRow(intl.System(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$LaboratoryUnit.system)
      ]);

    final tab = createTab(null, unitForm);
    layout.contInner.activeTab(tab);
  }
}
