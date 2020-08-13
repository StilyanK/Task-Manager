part of project.ctrl;

class TaskCollection extends base.Collection<App, Task, int> {
  final String group = Group.Project;
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
          entity.$Task.task_id,
          entity.$Task.project_id,
        ]
        ..tsvector = ['tsv']
        ..date = [
          entity.$Task.date_done,
          entity.$Task.date_created,
          entity.$Task.date_modified,
          entity.$Task.deadline,
        ])
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];

    cb.query
      ..andWhere('${entity.$Task.is_deleted} = @p1')
      ..setParameter('p1', false);
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
    final createdBy = await manager.app.user.find(data['created_by']);
    final modifiedBy = await manager.app.user.find(data['modified_by']);
    final assignedTo = await manager.app.user.find(data['assigned_to']);
    final project = await manager.app.project.find(o.project_id);
    data['number'] = [o.task_id, o.parent_task];
    data['created_by'] = createdBy.name;
    data['status'] = [data['status'], data['progress']];
    data['modified_by'] = modifiedBy?.name;
    data['assigned_to'] = assignedTo.name;
    data['task'] = [o.title, o.description];
    data['deadline'] = [
      o.date_created.toIso8601String(),
      o.deadline.toIso8601String()
    ];
    data['date_done'] = [
      o.date_done?.toIso8601String(),
      o.deadline.toIso8601String()
    ];
    final chatRoom = await auth.Chat(manager.convert(new auth.App()))
        .loadRoomByContext(
            'task${o.task_id}', req.session['client']['user_id']);
    data['chat_room'] = chatRoom;
    if (project != null)
      data['project'] = project.getPictureView();
    return data;
  }
}
