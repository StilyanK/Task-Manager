part of local.mapper;

class PlaceMapper extends Mapper<Place, PlaceCollection, App> {
  String table = 'place';

  PlaceMapper(m) : super(m);

  CollectionBuilder<Place, PlaceCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['region_code']
        ..tsquery = ['name']);
    return cb;
  }

  Future<PlaceCollection> findBySuggestion(String sug) => loadC(selectBuilder()
    ..where('to_tsvector(coalesce(name,\'\')) @@ to_tsquery(@sug)')
    ..setParameter('sug', new TSquery(sug).toString())
    ..orderBy('name', 'ASC')
    ..limit(10));

  Future<PlaceCollection> findAllByRegion(String region_code) =>
      loadC(selectBuilder()
        ..where('region_code = @p1')
        ..setParameter('p1', region_code)
        ..orderBy(pkey));

  Future<PlaceCollection> findAllByRHIF(String rhif_id) => loadC(selectBuilder()
    ..where('rhif_id = @p1')
    ..setParameter('p1', rhif_id)
    ..orderBy(pkey));

  Future<PlaceCollection> findAllByName(String name) => loadC(selectBuilder()
    ..where('name = @n')
    ..setParameter('n', name));

  Future<PlaceCollection> findBySuggestionAndRegion(
      String sug, String region_code) {
    final q = selectBuilder()
      ..where('to_tsvector(coalesce(name,\'\')) @@ to_tsquery(@sug)')
      ..setParameter('sug', new TSquery(sug).toString());
    if (region_code != null) {
      q
        ..andWhere('region_code = @p1')
        ..setParameter('p1', region_code);
    }
    return loadC(q
      ..orderBy('name', 'ASC')
      ..limit(10));
  }

  /// Used in hms_import
  Future<Place> findByName(String name) => loadE(selectBuilder()
    ..where('name ILIKE @p1')
    ..setParameter('p1', name)
    ..orderBy(pkey)
    ..limit(1));

  /// Used in hms_import
  Future<Place> findByNameAndRegion(String name, String region_code) =>
      loadE(selectBuilder()
        ..where('name ILIKE @p1')
        ..andWhere('region_code = @p2')
        ..setParameter('p1', name)
        ..setParameter('p2', region_code)
        ..limit(1));
}

class Place extends entity.Place with Entity<App> {
  Future<entity.Region> loadRegion() async =>
      region = await manager.app.region.findByCode(region_code);

  Future<entity.Rhif> loadRHIF() async =>
      rhif = await manager.app.rhif.find(rhif_id);
}

class PlaceCollection extends entity.PlaceCollection<Place> {
  Future<List> pair() async {
    final res = [];
    for (final place in innerList) {
      await place.loadRegion();
      res.add(
          {'k': place.place_id, 'v': '${place.name} (${place.region.name})'});
    }
    return res;
  }
}
