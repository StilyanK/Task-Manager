part of project.ctrl;

class IProject extends base.Item<App, Project, int> {
  final String group = Group.Project;
  final String scope = Scope.Project;

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

  Future<void> suggest() => run(group, scope, 'read', () async {
    final params = await getData();
    manager = await new Database().init(new App());
    entity.ProjectCollection col;
    if (params['id'] != null) {
      col = new ProjectCollection()
        ..add(await manager.app.project.find(params['id']));
    }
    else {
      col = await manager.app.project
          .findBySuggestion(params['suggestion']);
    }
    return response(col.pair());
  });
}
