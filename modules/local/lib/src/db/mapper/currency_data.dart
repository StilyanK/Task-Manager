part of local.mapper;

class CurrencyDataMapper
    extends Mapper<CurrencyData, CurrencyDataCollection, App> {
  String table = 'currency_data';
  dynamic pkey = ['currency_id', 'currency_history_id'];

  CurrencyDataMapper(m) : super(m);

  Future<CurrencyDataCollection> findByLastHistory() async {
    final result = await manager.app.currency_hitory.findLatest();
    if (result == null) return null;
    return loadC(selectBuilder()
      ..where('currency_history_id = @id')
      ..setParameter('id', result.currency_history_id));
  }
}

class CurrencyData extends entity.CurrencyData with Entity<App> {
  Future<CurrencyHistory> loadHistory() async => currency_history =
      await manager.app.currency_hitory.find(currency_history_id);

  Future<Currency> loadCurrency() async =>
      currency = await manager.app.currency.find(currency_id);
}

class CurrencyDataCollection
    extends entity.CurrencyDataCollection<CurrencyData> {}
