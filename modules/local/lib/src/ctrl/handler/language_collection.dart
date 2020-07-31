part of hms_local.ctrl;

class CLanguage extends base.Collection<App, Language, int> {
  final String group = Group.Local;

  final String scope = Scope.Language;

  CLanguage(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.language.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.language.deleteById)).then((_) => true);

  Future pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final c = await manager.app.language.findAllActive();
        return response(c.pair());
      });
}
