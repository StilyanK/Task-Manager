part of hms_local.gui;

class RhifList extends Listing {
  UrlPattern contr_get = RoutesRhif.collectionGet;

  String mode = Listing.MODE_CHOOSE;
  String key = entity.$Rhif.rhif_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Rhif()
    ..height = 600
    ..width = 600
    ..icon = Icon.Rhif;

  RhifList(ap) : super(ap);

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Rhif.name)
          ..title = intl.Name()
          ..filter = (new cl_form.Input()..setName(entity.$Rhif.name))
          ..sortable = true,
        new cl_form.GridColumn(entity.$Rhif.region_code)
          ..title = intl.Region()
          ..filter = (new SelectRegion(ap, [null, intl.Select_region()])
            ..setName(entity.$Rhif.region_code)
            ..load()),
        new cl_form.GridColumn(entity.$Rhif.code)
          ..title = intl.Code()
          ..filter = (new SelectRegion(ap, [null, intl.Select_region()])
            ..setName(entity.$Rhif.region_code)
            ..load()),
      ];

  void onEdit(dynamic id) {
    ap.run('rhif/$id');
  }

  void onClick(TableRowElement row) =>
      onEdit(gridList.grid.rowToMap(row)[entity.$Rhif.rhif_id]);
}
