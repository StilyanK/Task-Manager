part of hms_local.ctrl;

class CAddress extends base.Collection<App, Address, int> {
  final String group = Group.Local;

  final String scope = Scope.Address;

  CAddress(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.address.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.address.deleteById)).then((_) => true);
}
