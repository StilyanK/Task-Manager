part of local.ctrl;

class CWeight extends base.Collection<App, WeightUnit, int> {
  final String group = Group.Local;

  final String scope = Scope.Weight;

  CWeight(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.weight_unit.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.weight_unit.deleteById))
          .then((_) => true);

  Future pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final c = await manager.app.weight_unit.findAll();
        return response(c.pair());
      });
}
