part of project.gui;

class TaskGui extends ItemBuilder<auth.Client> {
  UrlPattern contr_get = RoutesTask.itemGet;
  UrlPattern contr_save = RoutesTask.itemSave;
  UrlPattern contr_del = RoutesTask.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.Calendar
    ..title = 'Задача'
    ..width = 1100
    ..height = 800
    ..type = 'bound';


  TaskGui(app, {id}) : super(app, id);

  Future<void> setDefaults() async {

  }

  Future setData() async {
    if (data_response != null) {
      form.setValue(data_response);
    }
  }



  void setUI() {


    final cl_gui.FormElement inVitroForm = new cl_gui.FormElement(form)
      ..addClass('top');
//
//    inVitroForm
//      ..addRow(intl.Patient(), [inputSource]).addClass('col2');
//

    final cl_gui.TabElement mainTab = createTab(null, inVitroForm);
    layout.contInner.activeTab(mainTab);
  }

  void setActions() {
    super.setActions();
    menu
      ..remove('clear')
      ..remove('del')
      ..add(new cl_action.Button()
        ..setName('del')
        ..setState(false)
        ..setTitle('Изтрий')
        ..setIcon(cl.Icon.delete)
        ..setStyle({'margin-left': 'auto'})
        ..addClass('warning')
        ..addAction((e) => del()));
  }

  void setMenuState(bool way) {
    super.setMenuState(way);
  }
}
