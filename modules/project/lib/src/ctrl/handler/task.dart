part of project.ctrl;

class ITask extends base.Item<App, Task, int> {
  final String group = Group.Document;
  final String scope = Scope.Commission;

  ITask(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final task = await manager.app.task.find(id);
    final ret = task.toJson();
    return ret;
  }


  Future<int> doSave(int id, Map data) async {
    final task = await manager.app.task.prepare(id, data);

    ///Assign doctors to commission

    await manager.commit();
    return task.task_id;
  }

  Future<bool> doDelete(int id) => manager.app.task.deleteById(id);
}
