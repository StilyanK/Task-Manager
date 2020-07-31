part of local.ctrl;

class CCountry extends base.Collection<App, Country, int> {
  final String group = Group.Local;

  final String scope = Scope.Country;

  CCountry(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.country.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.country.deleteById)).then((_) => true);

  Future pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final c = await manager.app.country.findAll();
        return response(c.pair());
      });

  Future pairCodes() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final c = await manager.app.country.findAll();
        return response(c.pairCodes());
      });

  Future suggest() => run(group, scope, 'read', () async {
        final params = await getData();
        manager = await new Database().init(new App());
        CountryCollection countries = new CountryCollection();

        if (params['id'] != null) {
          countries.add(await manager.app.country.find(params['id']));
        } else {
          countries =
              await manager.app.country.findBySuggestion(params['suggestion']);
        }

        return response(countries.pair());
      });
}
