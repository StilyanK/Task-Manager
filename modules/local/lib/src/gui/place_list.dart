part of local.gui;

class PlaceList extends Listing {
  UrlPattern contr_get = RoutesPlace.collectionGet;

  String mode = Listing.MODE_CHOOSE;
  String key = entity.$Place.place_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.City()
    ..height = 600
    ..width = 600
    ..icon = Icon.Place;
  SelectRegion filterRegion;

  PlaceList(ap) : super(ap, autoload: false);

  List<cl_form.GridColumn> initHeader() {
    filterRegion = new SelectRegion(ap, [null, intl.Select_region()])
      ..setName(entity.$Place.region_code)
      ..load()
      ..hide();

    return [
      new cl_form.GridColumn(entity.$Place.name)
        ..title = intl.Name()
        ..filter = (new cl_form.Input()..setName(entity.$Place.name))
        ..sortable = true,
      new cl_form.GridColumn('rhif_name')
        ..title = intl.Code()
        ..filter = (new SelectRhif(ap)..setName(entity.$Place.rhif_id)),
      new cl_form.GridColumn('region_name')
        ..title = intl.Region()
        ..filter = filterRegion
    ];
  }

  dynamic onEdit(dynamic id) => new Place(id);

  dynamic onClick(TableRowElement row) =>
      onEdit(gridList.grid.rowToMap(row)[entity.$Place.place_id]);
}
