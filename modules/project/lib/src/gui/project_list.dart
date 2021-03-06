part of project.gui;

class ProjectList extends base.Listing {
  UrlPattern contr_get = RoutesProject.collectionGet;
  UrlPattern contr_del = RoutesProject.collectionDelete;
  String mode = base.Listing.MODE_LIST;
  String key = entity.$Project.project_id;
  cl.Container listButtonsContainer;
  cl_action.Button newProject;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Projects()
    ..icon = Icon.ProjectList
    ..width = 900
    ..height = 600;

  ProjectList(ap, [bool autoload = true])
      : super(ap, autoload: autoload ?? true) {
    newProject = new cl_action.Button()
      ..addClass('important')
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add())
      ..setIcon(cl.Icon.add)
      ..addAction((_) => new Project(ap));

    registerServerListener(RoutesProject.eventCreate, debounceGet);
    registerServerListener(RoutesProject.eventUpdate, debounceInRangeGet);
    registerServerListener(RoutesProject.eventDelete, debounceInRangeGet);

    listButtonsContainer = new cl.Container()..append(newProject);

    layout.contMenu.append(listButtonsContainer);
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Project.picture)
          ..width = '1%'
          ..type = (grid, row, cell, object) =>
              new ProjectCell(ap, grid, row, cell, object),
        new cl_form.GridColumn(entity.$Project.title)..title = intl.Project(),
        new cl_form.GridColumn(entity.$Project.from)
          ..title = intl.Date_start()
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
        new cl_form.GridColumn(entity.$Project.to)
          ..title = intl.Date_end()
          ..type = (grid, row, cell, object) =>
              new local.DateTimeCell(grid, row, cell, object),
      ];

  void onEdit(dynamic id) => ap.run('project/item/$id');

  void customRow(TableRowElement row, Map obj) {}
}

class ProjectListChoose extends ProjectList {
  String mode = base.Listing.MODE_CHOOSE;

  void Function(Map) callback;

  ProjectListChoose(this.callback, ap) : super(ap);

  void onClick(TableRowElement row) {
    callback(gridList.grid.rowToMap(row));
    wapi.close();
  }
}
