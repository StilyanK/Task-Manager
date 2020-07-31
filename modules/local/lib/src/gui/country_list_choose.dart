part of hms_local.gui;

class CountryListChoose extends CountryList {
  String mode = Listing.MODE_CHOOSE;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Choose_country()
    ..height = 800
    ..width = 1000
    ..icon = Icon.Country;
  void Function(Map) callback;

  CountryListChoose(this.callback, ap, {autoload = true})
      : super(ap, autoload: autoload);

  void onClick(TableRowElement row) {
    callback(gridList.grid.rowToMap(row));
    wapi.close();
  }
}
