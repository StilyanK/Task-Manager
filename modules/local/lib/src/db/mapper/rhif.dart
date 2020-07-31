part of local.mapper;

class RhifMapper extends Mapper<Rhif, RhifCollection, App> {
  String table = 'rhif';

  RhifMapper(m) : super(m);

  CollectionBuilder<Rhif, RhifCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['region_code']
        ..llike = ['name']);
    return cb;
  }

  Future<RhifCollection> findAllByRegion(String r_code) => loadC(selectBuilder()
    ..where('region_code = @p1')
    ..setParameter('p1', r_code));

  Future<Rhif> findByCodeAndRegionCode(String code, String r_code) =>
      loadE(selectBuilder()
        ..where('code = @p1')
        ..andWhere('region_code = @p2')
        ..setParameter('p2', r_code)
        ..setParameter('p1', code));

  Future<Rhif> findByName(String name) => loadE(selectBuilder()
    ..where('name ILIKE @p1')
    ..setParameter('p1', name)
    ..orderBy(pkey)
    ..limit(1));
}

class Rhif extends entity.Rhif with Entity<App> {}

class RhifCollection extends entity.RhifCollection<Rhif> {
  List<Map<String, String>> pairCode() =>
      map((rhif) => {'k': rhif.rhif_id, 'v': '${rhif.code} ${rhif.name}'})
          .toList();
}
