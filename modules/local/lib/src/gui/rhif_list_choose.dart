part of hms_local.gui;

class RhifListChoose extends RhifList {
  String mode = Listing.MODE_CHOOSE;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Choose_rhif()
    ..height = 800
    ..width = 1000
    ..icon = Icon.Rhif;
  void Function(Map) callback;

  RhifListChoose(this.callback, ap) : super(ap);

  void onClick(TableRowElement row) {
    callback(gridList.grid.rowToMap(row));
    wapi.close();
  }
}
