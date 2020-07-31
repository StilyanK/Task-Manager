part of hms_local.ctrl;

class CZone extends base.Collection<App, CountryZone, int> {
  final String group = Group.Local;

  final String scope = Scope.Zone;

  CZone(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.countryzone.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<Map> lister(CountryZone o) async {
    final c = await manager.app.country.find(o.country_id);
    final d = o.toJson();
    d['country'] = c.name;
    return d;
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.countryzone.deleteById))
          .then((_) => true);

  Future pair() => run(group, scope, 'read', () async {
        final params = await getData();
        manager = await new Database().init(new App());
        final c =
            await manager.app.countryzone.findAllByCountryId(params['param']);
        return response(c.pair());
      });
}
