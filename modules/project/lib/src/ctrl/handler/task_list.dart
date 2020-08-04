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
            ..longTitle = o.title
            ..longDescription = o.description
            ..assignedTo = o.assigned_to
            ..createdBy = o.created_by
            ..createdTime = o.date_created
            ..modifiedBy = o.modified_by
            ..deadLine = o.deadline
            ..progress = o.progress ?? 0
            ..priority = o.priority;

          if (o.title.length > 30)
            dto.shortTitle = '${o.title.substring(0, 30)}..';
          else
            dto.shortTitle = o.title;

          if (o.description != null) {
            if (o.description.length > 19) {
              dto.shortDescription = '${o.description.substring(0, 19)}..';
            } else {
              dto.shortDescription = o.description;
            }
          }

          resData.add(dto);
        }

        return response(resData);
      });

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.task.deleteById)).then((_) => true);

  Future<void> pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final users = await manager.app.user.findAll();
        return response(users.pair());
      });

  Future<Map> lister(Task o) async {
    final data = o.toJson();
    final priority = TaskPriority.getTaskPriorityByID(data['priority']);
    final createdBy = await manager.app.user.find(data['created_by']);
    final modifiedBy = await manager.app.user.find(data['modified_by']);
    final status = TaskStatus.getTaskTitleByID(data['status']);
    data['priority'] = priority;
    data['created_by'] = createdBy.name;
    data['status'] = status;
    data['modified_by'] = modifiedBy?.name;
    return data;
  }
}
