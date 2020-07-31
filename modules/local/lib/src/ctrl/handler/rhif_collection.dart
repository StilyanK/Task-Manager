part of hms_local.ctrl;

class CRhif extends base.Collection<App, Rhif, int> {
  final String group = Group.Local;

  final String scope = Scope.Rhif;

  CRhif(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.rhif.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.rhif.deleteById)).then((_) => true);

  Future pairCode() async {
    manager = await new Database().init(new App());
    final params = await getData();

    final rhifs = await manager.app.rhif.findAllByRegion(params['region_code']);

    return response(rhifs.pairCode());
  }
}
