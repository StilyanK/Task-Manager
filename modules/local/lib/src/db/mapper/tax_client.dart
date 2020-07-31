part of hms_local.mapper;

class TaxClientMapper extends Mapper<TaxClient, TaxClientCollection, App> {
  String table = 'tax_client';

  TaxClientMapper(m) : super(m);

  CollectionBuilder<TaxClient, TaxClientCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()..llike = ['name']);
    return cb;
  }
}

class TaxClient extends entity.TaxClient with Entity<App> {}

class TaxClientCollection extends entity.TaxClientCollection<TaxClient> {}
