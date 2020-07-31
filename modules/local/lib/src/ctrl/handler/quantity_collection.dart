part of hms_local.ctrl;

class CQuantity extends base.Collection<App, QuantityUnit, int> {
  final String group = Group.Local;

  final String scope = Scope.Quantity;

  CQuantity(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.quantity_unit.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.quantity_unit.deleteById))
          .then((_) => true);

  Future pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final c = await manager.app.quantity_unit.findAll();
        return response(c.pair());
      });
}
