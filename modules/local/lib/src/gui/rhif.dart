part of hms_local.gui;

class Rhif extends ItemBuilder {
  UrlPattern contr_get = RoutesRhif.itemGet;
  UrlPattern contr_save = RoutesRhif.itemSave;
  UrlPattern contr_del = RoutesRhif.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = ((id) => intl.Rhif())
    ..height = 500
    ..width = 600
    ..icon = Icon.Rhif;

  Rhif(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$Rhif.region_code).focus();
  }

  void setUI() {
    final rhifForm = new cl_gui.FormElement(form)
      ..addRow(intl.Region(), [
        new SelectRegion(ap)
          ..setName(entity.$Rhif.region_code)
          ..load()
      ])
      ..addRow(intl.Code(), [new cl_form.Input()..setName(entity.$Rhif.code)])
      ..addRow(intl.Name(), [new cl_form.Input()..setName(entity.$Rhif.name)]);

    layout.contInner.append(rhifForm);
  }
}
