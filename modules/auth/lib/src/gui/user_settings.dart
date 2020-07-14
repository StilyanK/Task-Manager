part of auth.gui;

class Settings extends ItemBuilder<Client> {
  UrlPattern contr_get = RoutesU.itemGet;
  UrlPattern contr_save = RoutesU.itemSave;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = ((dynamic _) => intl.Settings())
    ..width = 450
    ..height = 400
    ..icon = Icon.Settings;

  Settings(ap) : super(ap, 0);

  Future setDefaults() async {
    if (ap.client.settings != null) form.setValue(ap.client.settings);
  }

  void setActions() {
    menu
      ..add(cl_action.Button()
        ..setName('save')
        ..setState(false)
        ..setTitle(intl.Save_and_apply())
        ..addClass('important')
        ..setIcon(cl.Icon.save)
        ..addAction((e) => saveSettings()))
      ..add(cl_action.Button()
        ..setName('clear')
        ..setState(false)
        ..setTitle(intl.Refresh())
        ..setIcon(cl.Icon.sync)
        ..addAction((e) => setDefaults()));
  }

  void setMenuState(bool way) {
    menu['save'].setState(way);
    menu['clear'].setState(way);
  }

  Future<void> saveSettings() async {
    final data = SettingsDTO()
      ..settings = ((ap.client.settings ?? {})..addAll(form.getValue()));
    await ap.serverCall(ap.client.settingsSaveRoute, data.toJson());
    setMenuState(false);
    resetListeners();
    window.location.reload();
  }

  void setUI() {
    final f = ap.client._getSettingsForm(form);
    final t1 = createTab(null, f);

    layout.contInner.activeTab(t1);
  }
}
