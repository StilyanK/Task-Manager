part of project.gui;

class TaskListChoose extends TaskList {
  String mode = base.Listing.MODE_CHOOSE;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.Choose_user()
    ..icon = Icon.User;

  void Function(Map) callback;

  TaskListChoose(this.callback, ap, {autoload = true}) : super(ap, autoload);

  void addButton() {}

  void onClick(dynamic row) {
    callback(gridList.grid.rowToMap(row));
    wapi.close();
  }
}
