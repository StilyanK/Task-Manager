part of auth.gui;

class UserGroup extends ItemBuilder {
  UrlPattern contr_get = RoutesG.itemGet;
  UrlPattern contr_save = RoutesG.itemSave;
  UrlPattern contr_del = RoutesG.itemDelete;

  cl_form.GridData table_permission;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.user_group_title
    ..icon = Icon.UserGroup;

  UserGroup(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {
    form.getElement($UserGroup.name).focus();
    final perms = await ap.serverCall(RoutesG.itemInit.reverse([]), null);
    form.getElement<PermissionsElement>($UserGroup.permissions).setValue(perms);
  }

  void setUI() {
    final f1 = cl_gui.FormElement(form);
    final p = PermissionsElement()..setName($UserGroup.permissions);
    form.add(p);
    final t1 = createTab(intl.Base(), f1);
    createTab(intl.Permissions(), p);
    layout.contInner.activeTab(t1);

    f1.addRow(intl.Name(), [
      cl_form.Input()
        ..setRequired(true)
        ..setName($UserGroup.name)
    ]);
  }
}

class PermissionsElement extends cl_form.DataElement<Map, DivElement> {
  cl_gui.Accordion accordion;
  List<cl_gui.FormElement> forms = [];

  PermissionsElement() {
    accordion = cl_gui.Accordion();
    dom = accordion.dom;
  }

  void setValue(Map value) {
    accordion
      ..nodes = []
      ..removeChilds();
    value.forEach((k, v) {
      final node = accordion.createNode(_capitalize(k));
      final f = cl_gui.FormElement()..setName(k);
      f.onValueChanged.listen((e) {
        contrValue.add(this);
      });
      forms.add(f);
      node.contentDom.append(f);
      v.forEach((k1, v1) {
        final r = [];
        v1.forEach((k2, v2) {
          r.add(cl_form.Check('bool')
            ..setContext(k1)
            ..setName(k2)
            ..setValue(v2)
            ..setLabel(_capitalize(k2)));
        });
        f
          ..addSection(_capitalize(k1))
          ..addRow(null, r);
      });
    });
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Map getValue() {
    final m = {};
    forms.forEach((f) => m[f.getName()] = f.getValue());
    return m;
  }
}
