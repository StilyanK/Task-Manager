part of project.gui;

class TaskList extends base.Listing {
  UrlPattern contr_get = RoutesTask.collectionGet;
  UrlPattern contr_del = RoutesTask.collectionDelete;
  String mode = base.Listing.MODE_LIST;
  String key = entity.$Task.task_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Списък със задачи'
    ..icon = Icon.Tasks
    ..width = 900
    ..height = 600;

  TaskList(ap, [bool autoload = true]) : super(ap, autoload: autoload ?? true);

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Task.date_created)
          ..title = 'Дата на създаване'
          ..sortable = true
          ..filter =
              (new cl_form.InputDateRange()..setName(entity.$Task.date_created))
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Task.assigned_to)
          ..title = 'Поел'
          ..filter = (new MultiSelectUser(ap, [null, 'All'])
            ..setName(entity.$Task.assigned_to)
            ..load())
          ..sortable = true,
        new cl_form.GridColumn(entity.$Task.title)
          ..title = 'Заглавие'
          ..filter = (new cl_form.Input()..setName(entity.$Task.title)),
        new cl_form.GridColumn(entity.$Task.description)
          ..title = 'Описание'
          ..filter = (new cl_form.Input()..setName(entity.$Task.description)),
        new cl_form.GridColumn(entity.$Task.priority)
          ..title = 'Приоритет'
          ..filter = (new SelectMultiPriority([null, 'All'])
            ..setName(entity.$Task.priority)),
        new cl_form.GridColumn(entity.$Task.status)
          ..title = 'Статус'
          ..filter = (new SelectMultiTaskStatus([null, 'All'])
            ..setName(entity.$Task.status)),
        new cl_form.GridColumn(entity.$Task.created_by)
          ..title = 'Зададена от'
          ..filter = (new MultiSelectUser(ap, [null, 'All'])
            ..setName(entity.$Task.created_by)
            ..load()),
        new cl_form.GridColumn(entity.$Task.modified_by)
          ..title = 'Модифициран от'
          ..filter = (new MultiSelectUser(ap, [null, 'All'])
            ..setName(entity.$Task.modified_by)
            ..load()),
        new cl_form.GridColumn(entity.$Task.date_modified)
          ..title = 'Дата на модифициране'
          ..filter = (new cl_form.InputDateRange()
            ..setName(entity.$Task.date_modified))
          ..sortable = true
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
      ];

  void onEdit(dynamic id) => TaskGui(ap, id: id);

  void customRow(dynamic row, dynamic obj) {}
}
