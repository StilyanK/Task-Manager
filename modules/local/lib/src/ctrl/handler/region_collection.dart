part of local.ctrl;

class CRegion extends base.Collection<App, Region, int> {
  final String group = Group.Local;

  final String scope = Scope.Region;

  CRegion(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.region.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.region.deleteById)).then((_) => true);

  Future pairCode() async {
    manager = await new Database().init(new App());

    final regions = await manager.app.region.findAll();
    return response(regions.pairCode());
  }
}
