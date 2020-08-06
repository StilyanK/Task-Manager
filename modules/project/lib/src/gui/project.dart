part of project.gui;

class Project extends base.ItemBuilder {
  UrlPattern contr_get = RoutesProject.itemGet;
  UrlPattern contr_save = RoutesProject.itemSave;
  UrlPattern contr_del = RoutesProject.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.User
    ..title = 'Проект'
    ..width = 1100
    ..height = 800
    ..type = 'bound';

  Project(app, {id}) : super(app, id);

  Future<void> setDefaults() async {}

  Future setData() async {
    if (data_response != null) {
      form.setValue(data_response);
    }
  }

  void setUI() {
    final cl_gui.FormElement projectForm = new cl_gui.FormElement(form)
      ..addClass('top');

    final title = new cl_form.Input()..setName(entity.$Project.title);
    final from = new cl_form.InputDate()..setName(entity.$Project.from);
    final to = new cl_form.InputDate()..setName(entity.$Project.to);
    projectForm
      ..addRow('Име на проекта', [title]).addClass('col6')
      ..addRow('Начало', [from]).addClass('col3')
      ..addRow('До', [to]).addClass('col3');

    final cl_gui.TabElement mainTab = createTab(null, projectForm);
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