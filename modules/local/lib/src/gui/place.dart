part of hms_local.gui;

class Place extends ItemBuilder {
  UrlPattern contr_get = RoutesPlace.itemGet;
  UrlPattern contr_save = RoutesPlace.itemSave;
  UrlPattern contr_del = RoutesPlace.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = ((id) => intl.Rhif())
    ..height = 500
    ..width = 600
    ..icon = Icon.Place;

  Place(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {}

  void setUI() {
    final placeForm = new cl_gui.FormElement(form)
      ..addRow(intl.Name(), [
        new cl_form.Input()
          ..setName(entity.$Place.name)
          ..disable()
      ])
      ..addRow(intl.Region(), [
        new cl_form.Input()
          ..setName(entity.$Address.region_id)
          ..disable()
      ])
      ..addRow(intl.Rhif(), [
        new cl_form.Input()
          ..setName(entity.$Place.rhif_id)
          ..disable()
      ]);

    layout.contInner.append(placeForm);
  }
}
