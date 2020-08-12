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
    final picture = data.remove('picture');
    final project = await manager.app.project.prepare(id, data);
    await manager.persist();
    if (picture['insert'] != null) {
      final sync = base.FileSync()
        ..path_from = '${base.path}/tmp'
        ..path_to = '${base.path}/media/project/${project.project_id}'
        ..file_name = picture['insert']['source'];
      project.picture = await sync.sync();
      manager.addDirty(project);
    }
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
        } else {
          col =
              await manager.app.project.findBySuggestion(params['suggestion']);
        }
        return response(col.pair());
      });

  Future<void> pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final project = await manager.app.project.findAll();
        return response(project.pair());
      });
}
