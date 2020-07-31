part of local.mapper;

class CurrencyHistoryMapper
    extends Mapper<CurrencyHistory, CurrencyHistoryCollection, App> {
  String table = 'currency_history';

  CurrencyHistoryMapper(m) : super(m);

  Future<CurrencyHistory> findToday() =>
      loadE(selectBuilder()..where('date::date = CURRENT_DATE'));

  Future<CurrencyHistory> findLatest() => loadE(selectBuilder()
    ..orderBy('currency_history_id', 'DESC')
    ..limit(1));
}

class CurrencyHistory extends entity.CurrencyHistory with Entity<App> {}

class CurrencyHistoryCollection
    extends entity.CurrencyHistoryCollection<CurrencyHistory> {}
