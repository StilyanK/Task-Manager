part of hms_local.mapper;

class WeightUnitMapper extends Mapper<WeightUnit, WeightUnitCollection, App> {
  String table = 'weight_unit';

  WeightUnitMapper(m) : super(m);

  CollectionBuilder<WeightUnit, WeightUnitCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()..llike = ['unit']);
    return cb;
  }
}

class WeightUnit extends entity.WeightUnit with Entity<App> {}

class WeightUnitCollection extends entity.WeightUnitCollection<WeightUnit> {}
