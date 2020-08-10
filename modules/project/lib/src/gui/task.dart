part of project.gui;

class TaskGui extends base.ItemBuilder<auth.Client> {
  UrlPattern contr_get = RoutesTask.itemGet;
  UrlPattern contr_save = RoutesTask.itemSave;
  UrlPattern contr_del = RoutesTask.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.Task
    ..title = intl.Task_title
    ..width = 1100
    ..height = 800;

  TaskGui(app, {id}) : super(app, id);

  Future<void> setDefaults() async {
    form.getElement(entity.$Task.created_by).setValue(ap.client.userId);
    form.getElement(entity.$Task.assigned_to).setValue(ap.client.userId);
    form.getElement(entity.$Task.title).focus();
  }

  Future setData() async {
    if (data_response != null) {
      form.setValue(data_response);
    }
  }

  void setUI() {
    final cl_gui.FormElement taskForm = new cl_gui.FormElement(form)
      ..addClass('top');

    final comments = new cl_action.Button()
      ..setTitle(intl.Comment())
      ..addClass('attention')
      ..addAction((e) {
        ap.client.ch.showChat();
        if (ap.client.ch.focused) {
          ap.client.ch.controller
              .showRoom(new chat.Room(room_id: 1, members: []));
        }
      });

    final createdById = cl_form.Data()..setName(entity.$Task.created_by);
    form.add(createdById);

    final title = new cl_form.Input()
      ..setName(entity.$Task.title)
      ..setRequired(true);

    final priority = new SelectTaskPriority()
      ..setName(entity.$Task.priority)
      ..setRequired(true);

    final dateDone = new cl_form.InputDate()..setName(entity.$Task.date_done);

    final bar = new ProgressComponent()..setName(entity.$Task.progress);

    final status = new SelectTaskStatus()
      ..setName(entity.$Task.status)
      ..setRequired(true)
      ..onValueChanged.listen((e) {
        if (e.getValue() == TaskStatus.Done) {
          bar
            ..setValue(100)
            ..disable();
          if (listenForChange) dateDone.setValue(new DateTime.now());
        } else {
          bar.enable();
        }
      });

    final deadline = new cl_form.InputDate()
      ..setName(entity.$Task.deadline)
      ..setRequired(true);

    final assignedTo = new SelectUser(ap)
      ..load()
      ..setName(entity.$Task.assigned_to)
      ..setRequired(true);

    final description = new cl_form.Editor(ap,
        options: cl_form.Editor.lightOptions()
          ..add(cl_form.EditorOptions().fullscreen),
        showFooter: false)
      ..setName(entity.$Task.description);

    final docStampCreated = new DocumentStamp(0)..setName('doc_stamp_created');

    final docStampModified = new DocumentStamp(1)
      ..setName('doc_stamp_modified');

    final fileuploader = new cl_action.FileUploader(ap)
      ..setTitle(intl.Attach_file())
      ..setIcon(cl.Icon.attach_file);

    final fu = new cl_gui.FileAttach<FileContainer>(
        fileuploader,
        () => '${ap.baseurl}tmp',
        () => '${ap.baseurl}media/task/${getId()}',
        (p) => new FileContainer(p))
      ..setName('files');

    final inputProject = new InputProject(ap)
      ..setName(entity.$Task.project_id)
      ..setRequired(true);

    taskForm
      ..addRow(null, [docStampCreated, docStampModified, comments])
          .addClass('col6')
      ..addRow(intl.Title(), [title]).addClass('col6')
      ..addRow(intl.Project(), [inputProject]).addClass('col2')
      ..addRow(intl.Assigned_to(), [assignedTo]).addClass('col2')
      ..addRow(intl.Deadline(), [deadline]).addClass('col2')
      ..addRow(intl.Priority(), [priority]).addClass('col2')
      ..addRow(intl.Status(), [status]).addClass('col2')
      ..addRow(intl.Progress(), [bar]).addClass('col1')
      ..addRow(intl.Date_done(), [dateDone]).addClass('col1')
      ..addRow(intl.Description(), [description]).addClass('col6')
      ..addRow(fileuploader, [fu]);

    final cl_gui.TabElement mainTab = createTab(null, taskForm);
    layout.contInner.activeTab(mainTab);
  }
}
