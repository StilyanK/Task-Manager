part of local.mapper;

class TaxRateMapper extends Mapper<TaxRate, TaxRateCollection, App> {
  String table = 'tax_rate';

  TaxRateMapper(m) : super(m);

  CollectionBuilder<TaxRate, TaxRateCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['active']
        ..llike = ['name']);
    return cb;
  }
}

class TaxRate extends entity.TaxRate with Entity<App> {}

class TaxRateCollection extends entity.TaxRateCollection<TaxRate> {}
