part of hms_local.mapper;

class CurrencyMapper extends Mapper<Currency, CurrencyCollection, App> {
  String table = 'currency';

  CurrencyMapper(m) : super(m);

  CollectionBuilder<Currency, CurrencyCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()..llike = ['title']);
    return cb;
  }
}

class Currency extends entity.Currency with Entity<App> {}

class CurrencyCollection extends entity.CurrencyCollection<Currency> {}
