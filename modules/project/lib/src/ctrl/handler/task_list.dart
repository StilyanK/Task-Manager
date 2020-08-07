part of project.ctrl;

class TaskCollection extends base.Collection<App, Task, int> {
  final String group = Group.Task;
  final String scope = Scope.Task;

  TaskCollection(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) async {
    final cb = manager.app.task.findAllByBuilder()
      ..filterRule = (new FilterRule()
        ..eq = [
          entity.$Task.status,
          entity.$Task.assigned_to,
          entity.$Task.modified_by,
          entity.$Task.priority,
          entity.$Task.status
        ]
        ..llike = [entity.$Task.title]
        ..like = [entity.$Task.description]
        ..date = [entity.$Task.date_created, entity.$Task.date_modified])
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<void> getCardInfo() async => run(group, scope, 'read', () async {
        final data = await getData();
        manager = await new Database().init(new App());
        final userId = data['user_id'];
        final cardDate = DateTime.parse(data['date']);
        final res = await manager.app.task.findByAllToDo(userId);
        final List<TaskDTO> resData = [];
        for (final o in res) {
          final dateCreated = new DateTime(
              o.date_created.year, o.date_created.month, o.date_created.day);
          final dateDeadline =
              new DateTime(o.deadline.year, o.deadline.month, o.deadline.day);
          final dateCreatedCheck = cardDate.isAfter(dateCreated) ||
              cardDate.isAtSameMomentAs(dateCreated);
          final dateDeadlineCheck = cardDate.isBefore(dateDeadline) ||
              cardDate.isAtSameMomentAs(dateDeadline);
          if (dateCreatedCheck) {
            final dto = new TaskCardDTOSetter(o).setDto();
            resData.add(dto);
          }
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
    final assignedTo = await manager.app.user.find(data['assigned_to']);
    final status = TaskStatus.getTaskTitleByID(data['status']);
    data['priority'] = priority;
    data['created_by'] = createdBy.name;
    data['status'] = data['status'];
    data['modified_by'] = modifiedBy?.name;
    data['assigned_to'] = assignedTo.name;
    return data;
  }
}
