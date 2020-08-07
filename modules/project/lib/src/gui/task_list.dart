part of project.gui;

class TaskList extends base.Listing {
  UrlPattern contr_get = RoutesTask.collectionGet;
  UrlPattern contr_del = RoutesTask.collectionDelete;
  String mode = base.Listing.MODE_LIST;
  String key = entity.$Task.task_id;
  cl.Container listButtonsContainer;
  cl_action.Button newTaskBtn;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Списък със задачи'
    ..icon = Icon.Tasks
    ..width = 900
    ..height = 600;

  TaskList(ap, [bool autoload = true])
      : super(ap,
            autoload: autoload ?? true,
            order: new cl_form.GridOrder(entity.$Task.task_id, 'DESC')) {
    newTaskBtn = new cl_action.Button()
      ..addClass('attention')
      ..setStyle({'margin-left': 'auto'})
      ..setTitle('Добави задача')
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
          ..filter = (new cl_form.Input()..setName(entity.$Task.task_id)),
        new cl_form.GridColumn('project')
          ..title = 'Проект'
          ..filter = (new ProjectSelect(ap, [null, 'Всички'])
            ..setName(entity.$Task.project_id)
            ..load()),
        new cl_form.GridColumn(entity.$Task.deadline)
          ..title = 'Срок'
          ..filter =
              (new cl_form.InputDateRange()..setName(entity.$Task.deadline))
          ..type = (grid, row, cell, object) =>
              new DateAndRemainingDays(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.assigned_to)
          ..title = 'Приел'
          ..filter = (new MultiSelectUser(ap, [null, 'All'])
            ..setName(entity.$Task.assigned_to)
            ..load())
          ..sortable = true,
        new cl_form.GridColumn(entity.$Task.title)
          ..title = 'Заглавие'
          ..filter = (new cl_form.Input()..setName(entity.$Task.title)),
        new cl_form.GridColumn(entity.$Task.description)
          ..title = 'Описание'
          ..filter = (new cl_form.Input()..setName(entity.$Task.description))
          ..type = (grid, row, cell, object) =>
              new DescriptionCeil(ap, grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.priority)
          ..title = 'Приоритет'
          ..filter = (new SelectMultiPriority([null, 'All'])
            ..setName(entity.$Task.priority))
          ..type = (grid, row, cell, object) =>
              new PriorityCell(ap, grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.status)
          ..title = 'Статус'
          ..filter = (new SelectMultiTaskStatus([null, 'All'])
            ..setName(entity.$Task.status))
          ..type = (grid, row, cell, object) =>
              new StatusCell(ap, grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.date_created)
          ..title = 'Създаден'
          ..sortable = true
          ..filter =
              (new cl_form.InputDateRange()..setName(entity.$Task.date_created))
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.created_by)
          ..title = 'Създал'
          ..filter = (new MultiSelectUser(ap, [null, 'All'])
            ..setName(entity.$Task.created_by)
            ..load()),
        new cl_form.GridColumn(entity.$Task.date_modified)
          ..title = 'Обновен'
          ..filter = (new cl_form.InputDateRange()
            ..setName(entity.$Task.date_modified))
          ..sortable = true
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.modified_by)
          ..title = 'Обновил'
          ..filter = (new MultiSelectUser(ap, [null, 'All'])
            ..setName(entity.$Task.modified_by)
            ..load()),
        new cl_form.GridColumn(entity.$Task.date_done)
          ..title = 'Изпълнен'
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
    obj['number'] = obj[entity.$Task.task_id];
  }
}
