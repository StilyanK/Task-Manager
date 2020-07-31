part of local.ctrl;

class CPlace extends base.Collection<App, Place, int> {
  final String group = Group.Local;

  final String scope = Scope.Place;

  CPlace(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.place.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.region.deleteById)).then((_) => true);

  Future<Map> lister(Place o) async {
    final m = o.toMap();
    await o.loadRegion();
    await o.loadRHIF();

    m['region_name'] = o.region?.name;
    m['rhif_name'] = o.rhif.name;

    return m;
  }

  Future pair() async {
    manager = await new Database().init(new App());
    final params = await getData();

    final places =
        await manager.app.place.findAllByRegion(params['region_code']);
    return response(places.pair());
  }

  Future suggest() => run(group, scope, 'read', () async {
        final params = await getData();
        manager = await new Database().init(new App());
        var places = new PlaceCollection();

        final id = params['id'];
        final region_code = params['region_code'];
        final suggestion = params['suggestion'];

        if (id != null) {
          final place = await manager.app.place.find(id);
          if (region_code == null || place.region_code == region_code)
            places.add(place);
        } else if (suggestion != null && suggestion.isNotEmpty) {
          places = await manager.app.place
              .findBySuggestionAndRegion(suggestion, region_code);
        }
        return response(await places.pair());
      });
}
