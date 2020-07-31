part of local.mapper;

class TaxProductMapper extends Mapper<TaxProduct, TaxProductCollection, App> {
  String table = 'tax_product';

  TaxProductMapper(m) : super(m);

  CollectionBuilder<TaxProduct, TaxProductCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()..llike = ['name']);
    return cb;
  }
}

class TaxProduct extends entity.TaxProduct with Entity<App> {}

class TaxProductCollection extends entity.TaxProductCollection<TaxProduct> {}
