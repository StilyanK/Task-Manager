part of project.ctrl;

class ITask extends base.Item<App, Task, int> {
  final String group = Group.Document;
  final String scope = Scope.Commission;

  ITask(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final task = await manager.app.task.find(id);
    final ret = task.toJson();
    final modifiedBy = await manager.app.user.find(task.modified_by);
    final createdBy = await manager.app.user.find(task.created_by);
    if(modifiedBy != null){
      ret['modified_by_name'] = modifiedBy.name;
      ret['created_by_name'] = createdBy.name;
    }
    return ret;
  }

  Future<int> doSave(int id, Map data) async {
    final task = await manager.app.task.prepare(id, data);
    final user_id = req.session['client']['user_id'];
    if (id != null) {
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
      if (task.assigned_to == userId) {
        final dto = new TaskCardDTOSetter(task).setDto();
        return response(dto);
      } else {
        return response(null);
      }
    }
    return response(null);
  }

  Future<bool> doDelete(int id) => manager.app.task.deleteById(id);
}
