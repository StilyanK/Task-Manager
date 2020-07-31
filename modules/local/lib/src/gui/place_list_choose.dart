part of local.gui;

class PlaceListChoose extends PlaceList {
  String mode = Listing.MODE_CHOOSE;

  void Function(Map) callback;

  PlaceListChoose(this.callback, ap) : super(ap);

  void onClick(TableRowElement row) {
    callback(gridList.grid.rowToMap(row));
    wapi.close();
  }
}
