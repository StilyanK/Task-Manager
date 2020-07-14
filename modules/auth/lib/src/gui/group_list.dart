part of auth.gui;

class UserGroupList extends Listing {
  UrlPattern contr_get = RoutesG.collectionGet;
  UrlPattern contr_del = RoutesG.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = $UserGroup.user_group_id;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.User_groups()
    ..icon = Icon.UserGroup;

  UserGroupList(ap) : super(ap) {
    menu.add(cl_action.Button()
      ..setTitle(intl.Add_group())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..setStyle({'margin-left': 'auto'})
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        cl_form.GridColumn($UserGroup.name)
          ..title = intl.Name()
          ..filter = (cl_form.Input()..setName($UserGroup.name))
          ..width = '100%'
          ..sortable = true
      ];

  void onEdit(dynamic id) {
    ap.run('user_group/$id');
  }
}
