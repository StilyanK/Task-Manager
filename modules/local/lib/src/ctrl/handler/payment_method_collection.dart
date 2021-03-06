part of local.ctrl;

class CPayment extends base.Collection<App, PaymentMethod, int> {
  final String group = Group.Local;

  final String scope = Scope.Payment;

  CPayment(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.payment_method.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) async => true;

  Future pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final c = await manager.app.payment_method.findAll();
        return response(c.pair());
      });
}
