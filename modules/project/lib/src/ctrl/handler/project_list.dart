part of project.ctrl;

class CProject extends base.Collection<App, Project, int> {
  final String group = Group.Task;
  final String scope = Scope.Task;

  CProject(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) async {
    final cb = manager.app.project.findAllByBuilder();
//      ..filterRule = (new FilterRule()
//        ..eq = [
//          entity.$Task.status,
//          entity.$Task.assigned_to,
//          entity.$Task.modified_by,
//          entity.$Task.priority,
//          entity.$Task.status
//        ]
//        ..llike = [entity.$Task.title]
//        ..like = [entity.$Task.description]
//        ..date = [entity.$Task.date_created, entity.$Task.date_modified])
//      ..filter = filter
//      ..order(order['field'], order['way'])
//      ..page = paginator['page']
//      ..limit = paginator['limit'];
    return cb.process(true);
  }


  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.project.deleteById)).then((_) => true);


}
