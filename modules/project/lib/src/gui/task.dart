part of project.gui;

class TaskGui extends base.ItemBuilder<auth.Client> {
  UrlPattern contr_get = RoutesTask.itemGet;
  UrlPattern contr_save = RoutesTask.itemSave;
  UrlPattern contr_del = RoutesTask.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.Task
    ..title = intl.Task_title
    ..width = 600
    ..height = 800;

  cl_action.Button addSubTaskBtn;
  cl_action.Button comments;

  TaskGui(app, {id}) : super(app, id);

  Future<void> setDefaults() async {
    form.getElement(entity.$Task.created_by).setValue(ap.client.userId);
    form.getElement(entity.$Task.assigned_to).setValue(ap.client.userId);
    form.getElement(entity.$Task.title).focus();
  }

  Future setData() async {
    if (data_response != null) {
      form.setValue(data_response);
      if (data_response['chat_room'] != null) {
        final room = new auth.ChatRoomDTO.fromMap(data_response['chat_room']);
        comments
          ..setTitle('${intl.Comments()} ${room.unseen}/${room.messages}')
          ..removeActionsAll()
          ..addAction((e) async {
            ap.client.ch.renderChat();
            if (ap.client.ch.focused)
              ap.client.ch.renderRoom(new chat.Room.fromMap(room.toJson())
                ..title = '${intl.Task()} #${getId()}');
          });
      }
    }
    comments.enable();
  }

  void setUI() {
    final cl_gui.FormElement taskForm = new cl_gui.FormElement(form)
      ..addClass('top');

    comments = new cl_action.Button()
      ..setTitle('${intl.Comments()} 0/0')
      ..setIcon(cl.Icon.message)
      ..disable()
      ..addAction((e) async {
        ap.client.ch.renderChat();
        if (ap.client.ch.focused) {
          final room = new chat.Room(
              title: '${intl.Task()} #${getId()}',
              context: 'task${getId()}',
              members: [
                new chat.Member()
                  ..user_id = ap.client.userId
                  ..picture = ap.client.picture
                  ..name = ap.client.name
              ]);
          ap.client.ch.renderRoom(room);
        }
      });

    final createdById = cl_form.Data()..setName(entity.$Task.created_by);
    form.add(createdById);

    final title = new cl_form.Input()
      ..setName(entity.$Task.title)
      ..setRequired(true);

    final hoursDone = new cl_form.Input(new cl_form.InputTypeInt())
      ..setName(entity.$Task.hours_done);

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

    final grid = new cl_form.GridData();
    grid
      ..initGridHeader([
        new cl_form.GridColumn('hadis')..title = 'Заглавие',
        new cl_form.GridColumn('insurance')..title = 'Описание',
        new cl_form.GridColumn('patient_name')
          ..width = '3%'
          ..title = 'Статус',
        new cl_form.GridColumn('dep_journal_number')
          ..width = '10%'
          ..title = 'Прогрес',
      ])
      ..addHookRow((row, obj) {
        grid.show();
        obj['dep_journal_number'] = new ProgressComponent();
      });

    addSubTaskBtn = new cl_action.Button()
      ..setIcon(cl.Icon.add)
      ..setTitle(intl.Add_sub_task())
      ..addAction((_) {
        grid
          ..show()
          ..rowAdd({'dep_journal_number': null});
        ap.run('task/item/0');
      });


    taskForm
      ..addRow(null, [docStampCreated, docStampModified, comments])
          .addClass('col6')
      ..addRow(intl.Title(), [title]).addClass('col6')
      ..addRow(intl.Project(), [inputProject]).addClass('col2')
      ..addRow(intl.Assigned_to(), [assignedTo]).addClass('col2')
      ..addRow(intl.Deadline(), [deadline]).addClass('col1')
      ..addRow(intl.Hours_done(), [hoursDone]).addClass('col1')
      ..addRow(intl.Priority(), [priority]).addClass('col2')
      ..addRow(intl.Status(), [status]).addClass('col2')
      ..addRow(intl.Progress(), [bar]).addClass('col1')
      ..addRow(intl.Date_done(), [dateDone]).addClass('col1')
      ..addRow(intl.Description(), [description]).addClass('col6')
      ..addRow(fileuploader, [fu]);
//      ..addSection(intl.Sub_tasks())
//      ..addRow(null, [addSubTaskBtn])
//      ..addRow(null, [grid]);

    final cl_gui.TabElement mainTab = createTab(null, taskForm);
    layout.contInner.activeTab(mainTab);
  }

  @override
  void setMenuState(bool way) {
//    addSubTaskBtn.setState(!way);
    super.setMenuState(way);
  }
}
