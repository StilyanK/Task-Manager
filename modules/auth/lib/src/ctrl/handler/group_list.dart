part of auth.ctrl;

class CGroup extends base.Collection<App, UserGroup, int> {
  final String group = Group.Auth;

  final String scope = Scope.Group;

  CGroup(req) : super(req, App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.user_group.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.user_group.deleteById)).then((_) => true);

  Future<dynamic> pair() => run(group, scope, 'read', () async {
        manager = await Database().init(App());
        final c = await manager.app.user_group.findAll();
        return response(c.pair());
      });
}
