part of project.gui;

class TaskGui extends base.ItemBuilder {
  UrlPattern contr_get = RoutesTask.itemGet;
  UrlPattern contr_save = RoutesTask.itemSave;
  UrlPattern contr_del = RoutesTask.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.Tasks
    ..title = 'Задача'
    ..width = 1100
    ..height = 800
    ..type = 'bound';


  TaskGui(app, {id}) : super(app, id);

  Future<void> setDefaults() async {
    form.getElement(entity.$Task.created_by).setValue(ap.client.userId);
  }

  Future setData() async {
    if (data_response != null) {
      form.setValue(data_response);
    }
  }

  void setUI() {
    final cl_gui.FormElement taskForm = new cl_gui.FormElement(form)
      ..addClass('top');

    final createdById = cl_form.Data()
    ..setName(entity.$Task.created_by);
    form.add(createdById);

    final title = new cl_form.Input()
      ..setName(entity.$Task.title)
      ..setRequired(true);

    final priority = new SelectTaskPriority()
      ..setName(entity.$Task.priority)
      ..setRequired(true);

    final status = new SelectTaskStatus()
      ..setName(entity.$Task.status)
      ..setRequired(true);

    final deadline = new cl_form.InputDateTime()
      ..setName(entity.$Task.deadline)
      ..setRequired(true);

    final assignedTo = new SelectUser(ap)
      ..load()
      ..setName(entity.$Task.assigned_to)
      ..setRequired(true);

    taskForm
      ..addRow('Заглавие', [title]).addClass('col6')
      ..addRow('Поет от', [assignedTo]).addClass('col3')
      ..addRow('Краен срок', [deadline]).addClass('col3')
      ..addRow('Приоритет', [priority]).addClass('col3')
      ..addRow('Статус', [status]).addClass('col3');

    final cl_gui.TabElement mainTab = createTab(null, taskForm);
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
