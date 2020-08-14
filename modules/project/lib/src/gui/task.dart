part of project.gui;

class TaskInit {
  int project_id;
  int assigned_to;
}

class TaskGui extends base.ItemBuilder<auth.Client> {
  UrlPattern contr_get = RoutesTask.itemGet;
  UrlPattern contr_save = RoutesTask.itemSave;
  UrlPattern contr_del = RoutesTask.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..icon = Icon.Task
    ..title = intl.Task_title
    ..width = 1000
    ..height = 800;

  TaskInit initData;
  cl_form.GridData gridSubTask;
  cl_action.Button addSubTaskBtn, parentTask, newTask;
  cl_action.Button comments;
  int parentId;
  bool isBound;

  TaskGui(app, {id, this.parentId, this.isBound = false, this.initData})
      : super(app, id) {
    registerServerListener(RoutesTask.eventUpdate, (id) {
      if (getId() != null && getId() == id && !isDirty) get();
    });
  }

  void registerServerListener(String event, Function f) {
    final subscr = ap.onServerCall.filter(event).listen(f);
    wapi.addCloseHook((_) {
      subscr.cancel();
      return true;
    });
  }

  void initLayout() {
    meta.type = isBound ? 'bound' : null;
    super.initLayout();
  }

  Future<void> setDefaults() async {
    if (initData != null) {
      form.getElement(entity.$Task.assigned_to).setValue(initData.assigned_to);
      form.getElement(entity.$Task.project_id).setValue(initData.project_id);
    } else {
      form.getElement(entity.$Task.assigned_to).setValue(ap.client.userId);
    }
    form.getElement(entity.$Task.created_by).setValue(ap.client.userId);
    form.getElement(entity.$Task.title).focus();
    gridSubTask.hide();
    newTask.disable();
    if (parentId != null) {
      form.getElement(entity.$Task.parent_task).setValue(parentId);
      parentTask.show();
    } else {
      parentTask.hide();
    }
    addSubTaskBtn.disable();
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
      int done = 0;
      if (data_response['sub_task_grid'] != null) {
        for (final o in data_response['sub_task_grid']) {
          if (o['status'].getValue() == TaskStatus.Done) {
            done++;
          }
        }
        form
            .getElement('sub_task_done')
            .setValue('$done/${data_response['sub_task_grid'].length}');
      }
      if (form.getElement(entity.$Task.parent_task).getValue() == null)
        parentTask.hide();
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
    final parentId = new cl_form.Data()..setName(entity.$Task.parent_task);

    form..add(createdById)..add(parentId);
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
          bar
            ..setValue(0)
            ..enable();
          if (listenForChange) dateDone.setValue(null);
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

    gridSubTask = new cl_form.GridData();
    final inputProject = new InputProject(ap)
      ..setName(entity.$Task.project_id)
      ..setRequired(true);

    final subTaskDone = new cl_form.Text()
      ..addClass('label-sub-task')
      ..setName('sub_task_done')
      ..setValue('0/0');

    gridSubTask
      ..setName('sub_task_grid')
      ..initGridHeader([
        new cl_form.GridColumn(entity.$Task.task_id)
          ..visible = false
          ..title = intl.Priority(),
        new cl_form.GridColumn(entity.$Task.priority)
          ..visible = false
          ..title = intl.Title(),
        new cl_form.GridColumn(entity.$Task.title)..title = intl.Title(),
        new cl_form.GridColumn(entity.$Task.description)
          ..title = intl.Description(),
        new cl_form.GridColumn(entity.$Task.status)
          ..width = '3%'
          ..title = intl.Status(),
        new cl_form.GridColumn(entity.$Task.progress)
          ..width = '10%'
          ..title = intl.Progress(),
      ])
      ..addHookRow((row, obj) {
        row.onClick.listen((event) {
          if (!isDirty) {
            new TaskGui(ap, id: obj[entity.$Task.task_id], isBound: true);
          }
        });
        obj[entity.$Task.progress] = new ProgressComponent()
          ..setValue(obj[entity.$Task.progress]);

        obj[entity.$Task.status] = new SelectTaskStatus()
          ..setValue(obj[entity.$Task.status])
          ..onValueChanged.listen((status) {
            if (status.getValue() == TaskStatus.Done) {
              obj[entity.$Task.progress].setValue(100);
            } else {
              obj[entity.$Task.progress].setValue(0);
            }
          });
      });

    addSubTaskBtn = new cl_action.Button()
      ..setIcon(Icon.Add)
      ..setTitle(intl.Add_sub_task())
      ..addAction((_) {
        new TaskGui(ap, parentId: getId(), isBound: true);
      });
    parentTask = new cl_action.Button()
      ..setIcon(Icon.Parent)
      ..setTitle('Таск родител')
      ..addClass('attention')
      ..addAction((_) {
        final s = form.getElement(entity.$Task.parent_task).getValue();
        if (s != null) new TaskGui(ap, id: s, isBound: true);
      });

    taskForm
      ..addRow(null, [docStampCreated, docStampModified, parentTask, comments])
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
      ..addSection('Подтаскове')
      ..addRow(null, [addSubTaskBtn]).addClass('col5')
      ..addRow(null, [subTaskDone]).addClass('col1')
      ..setStyle({'margin-left': 'auto'})
      ..addRow(null, [gridSubTask])
      ..addRow(fileuploader, [fu]);

    final cl_gui.TabElement mainTab = createTab(null, taskForm);
    layout.contInner.activeTab(mainTab);
  }

  void setActions() {
    super.setActions();

    newTask = new cl_action.Button()
      ..setStyle({'margin-right': 'auto'})
      ..setIcon(Icon.Add)
      ..setTitle(intl.Task_new())
      ..addClass('attention')
      ..addAction((_) {
        final projectId = form.getElement(entity.$Task.project_id).getValue();
        final assignedTo = form.getElement(entity.$Task.assigned_to).getValue();
        wapi.close();
        new TaskGui(ap,
            initData: new TaskInit()
              ..project_id = projectId
              ..assigned_to = assignedTo);
      });

    menu
      ..remove('del')
      ..add(newTask)
      ..add(new cl_action.Button()
        ..setName('del')
        ..setTitle(intl.Delete())
        ..setIcon(Icon.Delete)
        ..addClass('warning')
        ..addAction((e) => del()));
  }

  @override
  void setMenuState(bool way) {
    super.setMenuState(way);
    addSubTaskBtn.setState(!way);
    newTask.setState(!way);
  }
}
