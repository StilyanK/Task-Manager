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
      ..addClass('important')
      ..setStyle({'margin-left': 'auto'})
      ..setTitle('Добави проект')
      ..setIcon(cl.Icon.add)
      ..addAction((_) => new Project(ap));

    registerServerListener(RoutesProject.eventCreate, debounceGet);
    registerServerListener(RoutesProject.eventUpdate, debounceInRangeGet);
    registerServerListener(RoutesProject.eventDelete, debounceInRangeGet);

    listButtonsContainer = new cl.Container()..append(newProject);

    layout.contMenu.append(listButtonsContainer);
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$Project.title)..title = 'Име на проект',
        new cl_form.GridColumn(entity.$Project.from)..title = 'От',
        new cl_form.GridColumn(entity.$Project.to)..title = 'До'
      ];

  void onEdit(dynamic id) => ap.run('project/item/$id');

  void customRow(dynamic row, dynamic obj) {}
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
