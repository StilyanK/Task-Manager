part of local.mapper;

class RegionMapper extends Mapper<Region, RegionCollection, App> {
  String table = 'region';
  dynamic pkey = 'code';

  RegionMapper(m) : super(m);

  CollectionBuilder<Region, RegionCollection, App> findAllByBuilder() {
    final cb = collectionBuilder();
    return cb;
  }

  Future<Region> findByCode(String code) => loadE(selectBuilder()
    ..where('code = @p1')
    ..setParameter('p1', code));
}

class Region extends entity.Region with Entity<App> {}

class RegionCollection extends entity.RegionCollection<Region> {
  List<Map<String, String>> pairCode() =>
      map((region) => {'k': region.code, 'v': '${region.code} ${region.name}'})
          .toList();
}
