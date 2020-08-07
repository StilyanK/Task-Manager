part of project.gui;

class Project extends base.ItemBuilder {
  UrlPattern contr_get = RoutesProject.itemGet;
  UrlPattern contr_save = RoutesProject.itemSave;
  UrlPattern contr_del = RoutesProject.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.Project
    ..title = 'Проект'
    ..width = 1100
    ..height = 800;

  Project(app, {id}) : super(app, id);

  Future<void> setDefaults() async {
    form.getElement(entity.$Project.title).focus();
  }

  Future setData() async {
    if (data_response != null) {
      form.setValue(data_response);
    }
  }

  void setUI() {
    final cl_gui.FormElement projectForm = new cl_gui.FormElement(form)
      ..addClass('top');

    final title = new cl_form.Input()
      ..setName(entity.$Project.title)
      ..setRequired(true);
    final from = new cl_form.InputDate()..setName(entity.$Project.from);
    final to = new cl_form.InputDate()..setName(entity.$Project.to);
    projectForm
      ..addRow('Име на проекта', [title]).addClass('col6')
      ..addRow('Начало', [from]).addClass('col3')
      ..addRow('До', [to]).addClass('col3');

    final cl_gui.TabElement mainTab = createTab(null, projectForm);
    layout.contInner.activeTab(mainTab);
  }
}
