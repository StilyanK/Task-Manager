part of auth.gui;

class User extends ItemBuilder<Client> {
  UrlPattern contr_get = RoutesU.itemGet;
  UrlPattern contr_save = RoutesU.itemSave;
  UrlPattern contr_del = RoutesU.itemDelete;

  cl_action.Button passBut;
  cl_form.GridData gridAddress;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = ((dynamic _) => intl.Profile())
    ..width = 600
    ..height = 600
    ..icon = Icon.User;

  User(ap, [id]) : super(ap, id);

  Future setDefaults() async {
    form.getElement($User.active).setValue(1);
    form.getElement($User.username).focus();
  }

  Future setData() async {
    await super.setData();
    passBut.setState(true);
  }

  void setUI() {
    passBut = cl_action.Button()..setTitle(intl.New_password());

    final f1 = cl_gui.FormElement(form)..addClass('top');
    final f2 = cl_gui.FormElement(form)..addClass('top');
    final t1 = createTab(intl.Profile(), f1);
    createTab(intl.Access_control(), f2);
    layout.contInner.activeTab(t1);

    final uploader = cl_action.FileUploader(ap)
      ..setTitle(intl.Upload())
      ..setIcon(cl.Icon.attach_file);
    final intro = cl_gui.ImageContainer(uploader, () => '${ap.baseurl}tmp',
        () => '${ap.baseurl}media/image200x200/user/${getId()}')
      ..setName($User.picture);
    f1
      ..addRow('', [intro])
      ..addRow(null, [
        cl_form.Check('bool')
          ..setLabel(intl.Active())
          ..setName($User.active)
      ])
      ..addRow(intl.User(), [
        cl_form.Input()
          ..setRequired(true)
          ..setName($User.username),
        passBut
          ..setState(false)
          ..addAction((e) => _password(this))
      ])
      ..addRow(intl.Name(), [cl_form.Input()..setName($User.name)])
      ..addRow(intl.Email(), [cl_form.Input()..setName($User.mail)])
      ..addRow(intl.Group(), [
        SelectGroup(ap)
          ..setName($User.user_group_id)
          ..load()
      ]);

    f2.addRow(null, rowAddresses());
  }

  List rowAddresses() {
    gridAddress = cl_form.GridData()
      ..setName('access')
      ..setContext($User.settings)
      ..fullData = true
      ..initGridHeader([
        cl_form.GridColumn('address')..title = intl.Address(),
        cl_form.GridColumn('access')..title = intl.Access(),
        cl_form.GridColumn('del')
          ..title = ''
          ..send = false
      ])
      ..hide()
      ..addHookRow((row, obj) {
        obj['address'] = InputIPAddress()
          ..setRequired(true)
          ..setValue(obj['address']);
        obj['access'] = cl_form.Select()
          ..addOption(0, intl.User())
          ..addOption(1, '${intl.User()} + ${intl.Password()}')
          ..addOption(2, intl.Denied())
          ..addClass('l')
          ..setValue(obj['access']);
        obj['del'] = cl_action.Button()
          ..setIcon(cl.Icon.delete)
          ..addAction((e) => gridAddress.rowRemove(row));
      });
    return [
      gridAddress,
      cl_action.Button()
        ..setTitle(intl.Add())
        ..setIcon(cl.Icon.add)
        ..addAction((e) {
          gridAddress
            ..rowAdd({})
            ..show();
        })
    ];
  }
}

void _password(ItemBuilder context) {
  final cont = cl.Container();
  final form = cl_gui.FormElement()..addClass('top');
  final inp = InputPassword();
  final inp2 = InputPassword();
  form..addRow(intl.Password(), [inp])..addRow(intl.Password_confirm(), [inp2]);
  cont.append(form);
  cl_app.Confirmer(context.ap, cont)
    ..icon = cl.Icon.lock
    ..title = intl.New_password()
    ..onOk = () {
      if (inp.getValue() == null ||
          !inp.isReady() ||
          inp.getValue() != inp2.getValue()) {
        inp.addClass('error');
        inp2.addClass('error');
        return false;
      }
      final dto = PasswordDTO()
        ..id = context.getId()
        ..password = inp.getValue();
      return context.ap
          .serverCall(RoutesU.itemPassword.reverse([]), dto.toJson())
          .then((_) => true);
    }
    ..render(width: 300, height: 300);
  inp.focus();
}
