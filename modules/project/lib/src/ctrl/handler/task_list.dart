part of project.ctrl;

class TaskCollection extends base.Collection<App, Task, int> {
  final String group = Group.Task;
  final String scope = Scope.Task;

  TaskCollection(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) async {
    final cb = manager.app.task.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  


  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.task.deleteById))
          .then((_) => true);
}
