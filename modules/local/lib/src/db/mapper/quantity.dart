part of local.mapper;

class QuantityUnitMapper
    extends Mapper<QuantityUnit, QuantityUnitCollection, App> {
  String table = 'quantity_unit';

  QuantityUnitMapper(m) : super(m);

  CollectionBuilder<QuantityUnit, QuantityUnitCollection, App>
      findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()..llike = ['unit']);
    return cb;
  }
}

class QuantityUnit extends entity.QuantityUnit with Entity<App> {}

class QuantityUnitCollection
    extends entity.QuantityUnitCollection<QuantityUnit> {}
