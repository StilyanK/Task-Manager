part of auth.ctrl;

class IGroup extends base.Item<App, UserGroup, int> {
  final String group = Group.Auth;

  final String scope = Scope.Group;

  IGroup(req) : super(req, App());

  Future<Map<String, dynamic>> doGet(int id) async {
    final group = await manager.app.user_group.find(id);
    if (group == null) throw base.ResourceNotFoundException();
    final d = group.toJson();
    d['permissions'] =
        PermissionManager().permission(id).merge(group.permissions);
    return d;
  }

  Future<int> doSave(int id, Map data) async {
    final group = await manager.app.user_group.prepare(id, data);
    await manager.commit();
    return group.user_group_id;
  }

  Future<bool> doDelete(int id) => manager.app.user_group.deleteById(id);

  Future<void> init() => run(
      group,
      scope,
      'create',
      () async =>
          response(PermissionManager().permission(null).getBlank()));
}
