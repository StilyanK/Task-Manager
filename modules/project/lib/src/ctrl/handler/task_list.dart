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

  Future<void> getCardInfo() async => run(group, scope, 'read', () async {
        final data = await getData();
        manager = await new Database().init(new App());
        final res = await manager.app.task.findAll();
        final List<TaskDTO> resData = [];
        for (final o in res) {
          final dto = new TaskDTO()
            ..id = o.task_id
            ..status = o.status
            ..title = o.title
            ..description = o.description
            ..assignedTo = o.assigned_to
            ..createdBy = o.created_by
            ..createdTime = o.date_created
            ..modifiedBy = o.modified_by
            ..priority = o.priority;
          resData.add(dto);
        }
        resData.forEach((element) => print(element.toMap()));
        return response(resData);
      });

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.task.deleteById)).then((_) => true);
}