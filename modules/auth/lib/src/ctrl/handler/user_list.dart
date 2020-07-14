part of auth.ctrl;

class CUser extends base.Collection<App, User, int> {
  final String group = Group.Auth;

  final String scope = Scope.User;

  CUser(req) : super(req, App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    filter[entity.$User.hidden] = false;
    final cb = manager.app.user.findAllByBuilder(filter.remove('uin'))
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.user.deleteById)).then((_) => true);

  Future<Map<String, dynamic>> lister(User o) async {
    final group = await o.loadUserGroup();
    final m = o.toJson();
    m['group'] = group.name;
    return m;
  }

  Future<dynamic> suggest() => run(group, scope, 'read', () async {
        final params = await getData();
        manager = await Database().init(App());
        UserCollection col;
        if (params['id'] != null) {
          col = UserCollection()
            ..add(await manager.app.user.find(params['id']));
        } else {
          col = await manager.app.user.findBySuggestion(params['suggestion']);
        }
        return response(col.pair());
      });

  Future<dynamic> pair() => run(group, scope, 'read', () async {
        manager = await Database().init(App());
        final c = await manager.app.user.findAll();
        return response(c.pair());
      });
}
