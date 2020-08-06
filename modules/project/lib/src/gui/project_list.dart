part of project.gui;

class ProjectList extends base.Listing {
  UrlPattern contr_get = RoutesProject.collectionGet;
  UrlPattern contr_del = RoutesProject.collectionDelete;
  String mode = base.Listing.MODE_LIST;
  String key = entity.$Project.project_id;
  cl.Container listButtonsContainer;
  cl_action.Button newProject;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Списък проекти'
    ..icon = Icon.User
    ..width = 900
    ..height = 600;

  ProjectList(ap, [bool autoload = true])
      : super(ap, autoload: autoload ?? true) {
    newProject = new cl_action.Button()
      ..addClass('attention')
      ..setStyle({'margin-left': 'auto'})
      ..setTitle('Добави проект')
      ..setIcon(cl.Icon.add)
      ..addAction((_) => new Project(ap));

    listButtonsContainer = new cl.Container()..append(newProject);

    layout.contMenu.append(listButtonsContainer);
  }

  List<cl_form.GridColumn> initHeader() => [
//    new cl_form.GridColumn(entity.$Task.date_created)
//      ..title = 'Дата на създаване'
//      ..sortable = true
//      ..filter =
//      (new cl_form.InputDateRange()..setName(entity.$Task.date_created))
//      ..type = (grid, row, cell, object) =>
//      new local.DateTimeCell(grid, row, cell, object),
//    new cl_form.GridColumn(entity.$Task.assigned_to)
//      ..title = 'Поел'
//      ..filter = (new MultiSelectUser(ap, [null, 'All'])
//        ..setName(entity.$Task.assigned_to)
//        ..load())
//      ..sortable = true,
//    new cl_form.GridColumn(entity.$Task.title)
//      ..title = 'Заглавие'
//      ..filter = (new cl_form.Input()..setName(entity.$Task.title)),
      ];

  void onEdit(dynamic id) => ap.run('project/item/$id');

  void customRow(dynamic row, dynamic obj) {}
}
