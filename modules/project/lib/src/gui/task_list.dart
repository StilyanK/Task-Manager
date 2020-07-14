part of project.gui;

class Commission extends ItemBuilder {
  UrlPattern contr_get = RoutesCommission.itemGet;
  UrlPattern contr_save = RoutesCommission.itemSave;
  UrlPattern contr_del = RoutesCommission.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.CommissionTitle
    ..width = 500
    ..height = 350
    ..icon = Icon.Commission;

  Commission(ap, [id]) : super(ap, id);

  Future setDefaults() async {
    form.getElement(e.$Commission.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form)..addClass('top');
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Name(), [cl_form.Input()..setName(e.$Commission.name)])
      ..addRow(intl.Disease(),
          [InputDisease(ap)..setName(e.$Commission.disease_id)]);

    final dgrid = DoctorGrid(ap, e.Commission.$doctors);
    t1.addRow(intl.Doctors(), [dgrid]);
  }
}
