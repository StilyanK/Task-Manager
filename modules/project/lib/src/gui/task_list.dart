part of project.gui;

class TaskList extends base.Listing {
  UrlPattern contr_get = RoutesTask.collectionGet;
  UrlPattern contr_del = RoutesTask.collectionDelete;
  String mode = base.Listing.MODE_LIST;
  String key = entity.$Task.task_id;
  cl.Container listButtonsContainer;
  cl_action.Button newTaskBtn;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tasks()
    ..icon = Icon.Tasks
    ..width = 900
    ..height = 600;

  TaskList(ap, [bool autoload = true])
      : super(ap,
            autoload: autoload ?? true,
            order: new cl_form.GridOrder(entity.$Task.task_id, 'DESC'),
            useCache: true) {
    newTaskBtn = new cl_action.Button()
      ..addClass('important')
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add())
      ..setIcon(cl.Icon.add)
      ..addAction((_) => new TaskGui(ap));

    listButtonsContainer = new cl.Container()..append(newTaskBtn);

    layout.contMenu.append(listButtonsContainer);

    registerServerListener(RoutesTask.eventCreate, debounceGet);
    registerServerListener(RoutesTask.eventUpdate, debounceInRangeGet);
    registerServerListener(RoutesTask.eventDelete, debounceInRangeGet);
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn('number')
          ..title = '#'
          ..filter = (new cl_form.Input(new cl_form.InputTypeInt())
            ..setName(entity.$Task.task_id)),
        new cl_form.GridColumn('project')
          ..title = intl.Project()
          ..filter = (new ProjectSelect(ap, [null, intl.All()])
            ..setName(entity.$Task.project_id)
            ..load()),
        new cl_form.GridColumn(entity.$Task.deadline)
          ..title = intl.Deadline()
          ..filter =
              (new cl_form.InputDateRange()..setName(entity.$Task.deadline))
          ..type = (grid, row, cell, object) =>
              new DateAndRemainingDays(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.assigned_to)
          ..title = intl.Assigned_to()
          ..filter = (new MultiSelectUser(ap)
            ..setName(entity.$Task.assigned_to)
            ..load())
          ..sortable = true,
        new cl_form.GridColumn('task')
          ..title = intl.Content()
          ..filter = (new cl_form.Input()..setName('tsv'))
          ..type = (grid, row, cell, object) =>
              new DescriptionCeil(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.priority)
          ..title = intl.Priority()
          ..filter = (new SelectMultiPriority()..setName(entity.$Task.priority))
          ..type = (grid, row, cell, object) =>
              new PriorityCell(ap, grid, row, cell, object),
        new cl_form.GridColumn('chat_room')
          ..title = intl.Comments()
          ..type = (grid, row, cell, object) =>
              new CommentsCell(ap, grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.date_created)
          ..title = intl.Created()
          ..sortable = true
          ..filter =
              (new cl_form.InputDateRange()..setName(entity.$Task.date_created))
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.created_by)
          ..title = intl.Created_by()
          ..filter = (new MultiSelectUser(ap)
            ..setName(entity.$Task.created_by)
            ..load()),
        new cl_form.GridColumn(entity.$Task.date_modified)
          ..title = intl.Modified()
          ..filter = (new cl_form.InputDateRange()
            ..setName(entity.$Task.date_modified))
          ..sortable = true
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.modified_by)
          ..title = intl.Modified_by()
          ..filter = (new MultiSelectUser(ap)
            ..setName(entity.$Task.modified_by)
            ..load()),
        new cl_form.GridColumn(entity.$Task.status)
          ..title = intl.Status()
          ..filter = (new SelectMultiTaskStatus()..setName(entity.$Task.status))
          ..type = (grid, row, cell, object) =>
              new StatusCell(ap, grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.date_done)
          ..title = intl.Done()
          ..sortable = true
          ..filter =
              (new cl_form.InputDateRange()..setName(entity.$Task.date_done))
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
      ];

  void onEdit(dynamic id) => ap.run('task/item/$id');

  void customRow(dynamic row, dynamic obj) {
    obj[entity.$Task.description] =
        removeHtmlTags(obj[entity.$Task.description]);
    if (obj[entity.$Task.parent_task] != null) {
      obj['number'] = '${obj[entity.$Task.task_id]} (п)';
    } else {
      obj['number'] = obj[entity.$Task.task_id];
    }
  }
}
