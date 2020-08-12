part of project.gui;

class Project extends base.ItemBuilder {
  UrlPattern contr_get = RoutesProject.itemGet;
  UrlPattern contr_save = RoutesProject.itemSave;
  UrlPattern contr_del = RoutesProject.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.Project
    ..title = intl.Project_title
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
    final manager = new SelectUser(ap, [null, ''])
      ..setName(entity.$Project.manager_id)
      ..setRequired(true)
      ..load();
    final uploader = cl_action.FileUploader(ap)
      ..setTitle(intl.Upload())
      ..setIcon(cl.Icon.attach_file);
    final intro = cl_gui.ImageContainer(uploader, () => '${ap.baseurl}tmp',
        () => '${ap.baseurl}media/image200x200/project/${getId()}')
      ..setName(entity.$Project.picture);
    final from = new cl_form.InputDate()..setName(entity.$Project.from);
    final to = new cl_form.InputDate()..setName(entity.$Project.to);
    projectForm
      ..addRow('', [intro])
      ..addRow(intl.Project(), [title]).addClass('col6')
      ..addRow(intl.Manager(), [manager]).addClass('col6')
      ..addRow(intl.Date_start(), [from]).addClass('col3')
      ..addRow(intl.Date_end(), [to]).addClass('col3');

    final cl_gui.TabElement mainTab = createTab(null, projectForm);
    layout.contInner.activeTab(mainTab);
  }
}
