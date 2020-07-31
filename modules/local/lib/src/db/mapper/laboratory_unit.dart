part of local.mapper;

class LaboratoryUnitMapper
    extends Mapper<LaboratoryUnit, LaboratoryUnitCollection, App> {
  String table = 'laboratory_unit';

  LaboratoryUnitMapper(m) : super(m);

  CollectionBuilder<LaboratoryUnit, LaboratoryUnitCollection, App>
      findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder())
      ..filterRule = (new FilterRule()
        ..eq = [pkey, 'name', 'system']
        ..like = ['name', 'system']);

    return cb;
  }

  Future<LaboratoryUnit> findByName(String name, String system) =>
      loadE(selectBuilder()
        ..where('name = @p1')
        ..andWhere('system = @p2')
        ..setParameter('p1', name)
        ..setParameter('p2', system)
        ..limit(1));

/*  findBySuggestion(String sug) => loadC(selectBuilder()
    ..where('name ILIKE @p1')
    ..orWhere('abbreviation ILIKE @p1')
    ..setParameter('p1', '%$sug%')
    ..limit(10));*/
}

class LaboratoryUnit extends entity.LaboratoryUnit with Entity<App> {}

class LaboratoryUnitCollection
    extends entity.LaboratoryUnitCollection<LaboratoryUnit> {}
