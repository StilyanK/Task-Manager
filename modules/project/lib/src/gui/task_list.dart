part of project.gui;

class TaskList extends Listing {
  UrlPattern contr_get = RoutesTask.collectionGet;
  UrlPattern contr_del = RoutesTask.collectionDelete;
  String mode = Listing.MODE_LIST;
  String key = entity.$Task.task_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Списък със задачи'
    ..icon = Icon.Calendar
    ..width = 900
    ..height = 600;

  TaskList(ap, [bool autoload = false]) : super(ap, autoload: autoload ?? false);

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Task.date_created)
          ..title = 'Дата на създаване'
          ..sortable = true,
        new cl_form.GridColumn(entity.$Task.assigned_to)
          ..title = 'Поел'
          ..sortable = false,
        new cl_form.GridColumn(entity.$Task.title)
          ..title = 'Заглавие'
          ..sortable = false,
        new cl_form.GridColumn(entity.$Task.description)
          ..title = 'Описание'
          ..sortable = false,
        new cl_form.GridColumn(entity.$Task.status)
          ..title = 'Статус'
          ..sortable = false,
        new cl_form.GridColumn(entity.$Task.created_by)
          ..title = 'Зададена от'
          ..sortable = false,
        new cl_form.GridColumn(entity.$Task.modified_by)
          ..title = 'Модифицирана от'
          ..sortable = false,
        new cl_form.GridColumn(entity.$Task.date_modified)
          ..title = 'Дата на модифициране'
          ..sortable = false,
      ];

  TaskList onEdit(dynamic id) => null;

  void customRow(dynamic row, dynamic obj) {}
}
