part of auth.gui;

class UserHome extends ItemBuilder {
  UrlPattern contr_get = RoutesU.itemGet;
  UrlPattern contr_save = RoutesU.itemSaveProfile;

  cl_action.Button pass_but;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.Profile()
    ..icon = Icon.User;

  UserHome(cl_app.Application ap) : super(ap, ap.client.userId) {
    wapi.setTitle(intl.Profile());
  }

  Future setDefaults() async {
    form.getElement($User.username).focus();
  }

  Future setData() async {
    await super.setData();
    pass_but.setState(true);
  }

  void setActions() {
    menu
      ..add(cl_action.Button()
        ..setName('save_true')
        ..setState(false)
        ..setTitle(intl.Save_and_close())
        ..setIcon(cl.Icon.save)
        ..addClass('important')
        ..addAction((e) => saveIt(true)))
      ..add(cl_action.Button()
        ..setName('save')
        ..setState(false)
        ..setTitle(intl.Save())
        ..setIcon(cl.Icon.save)
        ..addClass('important')
        ..addAction((e) => saveIt(false)))
      ..add(cl_action.Button()
        ..setName('clear')
        ..setState(false)
        ..setTitle(intl.Refresh())
        ..setIcon(cl.Icon.sync)
        ..addAction((e) => get()));
  }

  void setUI() {
    pass_but = cl_action.Button()..setTitle(intl.New_password());
    final f1 = cl_gui.FormElement(form)..addClass('top');
    final t1 = createTab(null, f1);
    layout.contInner.activeTab(t1);
    final uploader = cl_action.FileUploader(ap)
      ..setTitle(intl.Upload())
      ..setIcon(cl.Icon.attach_file);
    final intro = cl_gui.ImageContainer(uploader, () => '${ap.baseurl}tmp',
        () => '${ap.baseurl}media/image200x200/user/${getId()}')
      ..setName($User.picture);
    f1
      ..addRow('', [intro])
      ..addRow(intl.User(), [
        cl_form.Input()
          ..setRequired(true)
          ..setName($User.username)
      ])
      ..addRow(intl.Name(), [cl_form.Input()..setName($User.name)])
      ..addRow(intl.Email(), [cl_form.Input()..setName($User.mail)])
      ..addRow('', [
        pass_but
          ..setState(false)
          ..addAction((e) => _password(this))
      ]);
  }
}
