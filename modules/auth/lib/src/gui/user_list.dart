part of auth.gui;

class UserList extends Listing {
  UrlPattern contr_get = RoutesU.collectionGet;
  UrlPattern contr_del = RoutesU.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = $User.user_id;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.Users()
    ..icon = Icon.User;

  UserList(ap, {autoload = true}) : super(ap, autoload: autoload);

  void setActions() {
    super.setActions();
    menu.add(cl_action.Button()
      ..setTitle(intl.Add_user())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..setStyle({'margin-left': 'auto'})
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() {
    final filterUser = cl_form.Input()..setName($User.username);
    final filterName = cl_form.Input()..setName($User.name);
    final filterMail = cl_form.Input()..setName($User.mail);
    final filterGroup = SelectGroup(ap, [null, intl.All()])
      ..setName($User.user_group_id)
      ..load();
    final filterState = cl_form.Select()
      ..setName($User.active)
      ..addOption(null, intl.all())
      ..addOption(true, intl.active())
      ..addOption(false, intl.unactive());
    return [
      cl_form.GridColumn($User.picture)
        ..title = ''
        ..send = false
        ..width = '1%',
      cl_form.GridColumn($User.username)
        ..title = intl.User()
        ..filter = filterUser
        ..sortable = true,
      cl_form.GridColumn($User.name)
        ..title = intl.Name()
        ..filter = filterName
        ..sortable = true,
      cl_form.GridColumn($User.mail)
        ..title = intl.Email()
        ..filter = filterMail
        ..sortable = true,
      cl_form.GridColumn('group')
        ..title = intl.Group()
        ..filter = filterGroup
        ..sortable = true,
      cl_form.GridColumn($User.active)
        ..title = intl.Active()
        ..filter = filterState
        ..sortable = true,
      cl_form.GridColumn($User.settings)
        ..title = ''
        ..filter = filterState
    ];
  }

  void onEdit(dynamic id) {
    ap.run('user/$id');
  }

  void customRow(TableRowElement row, Map obj) {
    obj[$User.active] = obj[$User.active] ? intl.active() : intl.unactive();
    obj[$User.picture] = cl_gui.ImageContainer(
        null, null, () => '${ap.baseurl}media/image50x50/user/${obj[key]}')
      ..addClass('small round')
      ..setValue(obj[$User.picture]);
    obj[$User.settings] = cl_action.Button()
      ..setTitle(intl.Session_data())
      ..addAction((e) {
        e.stopPropagation();
        UserHome(ap);
      });
  }
}
