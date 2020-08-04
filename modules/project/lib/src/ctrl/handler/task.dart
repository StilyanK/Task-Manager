part of project.ctrl;

class ITask extends base.Item<App, Task, int> {
  final String group = Group.Document;
  final String scope = Scope.Commission;

  ITask(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final task = await manager.app.task.find(id);
    final ret = task.toJson();
    final modifiedBy = await manager.app.user.find(task.modified_by);
    if(modifiedBy != null){
      ret['modified_by_name'] = modifiedBy.name;
    }
    return ret;
  }

  Future<int> doSave(int id, Map data) async {
    final task = await manager.app.task.prepare(id, data);
    final user_id = req.session['client']['user_id'];
    if(id != null) {
      task
        ..modified_by = user_id
        ..date_modified = DateTime.now();
      manager.addDirty(task);
    }
    await manager.commit();
    return task.task_id;
  }

  Future updateTaskCard() async {
    final data = await getData();
    final taskId = data['id'];
    final userId = data['user_id'];
    manager = await new Database().init(new App());
    if (taskId == null) return response(null);
    final task = await manager.app.task.find(taskId);
    if (task != null) {
      if (task.assigned_to == userId && task.status != TaskStatus.Done) {
        final dto = new TaskDTO()
          ..id = task.task_id
          ..status = task.status
          ..longTitle = task.title
          ..longDescription = task.description
          ..assignedTo = task.assigned_to
          ..createdBy = task.created_by
          ..createdTime = task.date_created
          ..modifiedBy = task.modified_by
          ..deadLine = task.deadline
          ..progress = task.progress ?? 0
          ..priority = task.priority;

        if (task.title.length > 30)
          dto.shortTitle = '${task.title.substring(0, 30)}..';
        else
          dto.shortTitle = task.title;

        if (task.description != null) {
          if (task.description.length > 19) {
            dto.shortDescription = '${task.description.substring(0, 19)}..';
          } else {
            dto.shortDescription = task.description;
          }
        }
        return response(dto);
      } else {
        return response(null);
      }
    }
    return response(null);
  }

  Future<bool> doDelete(int id) => manager.app.task.deleteById(id);
}
