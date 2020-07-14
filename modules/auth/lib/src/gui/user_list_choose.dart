part of auth.gui;

class UserListChoose extends UserList {
  String mode = Listing.MODE_CHOOSE;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.Choose_user()
    ..icon = Icon.User;

  void Function(Map) callback;

  UserListChoose(this.callback, ap, {autoload = true})
      : super(ap, autoload: autoload);

  void addButton() {}

  void onClick(dynamic row) {
    callback(gridList.grid.rowToMap(row));
    wapi.close();
  }
}
