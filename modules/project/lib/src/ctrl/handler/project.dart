part of project.ctrl;

class IProject extends base.Item<App, Project, int> {
  final String group = Group.Document;
  final String scope = Scope.Commission;

  IProject(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final project = await manager.app.project.find(id);
    final ret = project.toJson();
    return ret;
  }

  Future<int> doSave(int id, Map data) async {
    final project = await manager.app.project.prepare(id, data);
    await manager.commit();
    return project.project_id;
  }

  Future<bool> doDelete(int id) => manager.app.task.deleteById(id);
}
