part of hms_local.server;

abstract class CUpdater {
  Manager<App> manager;

  CUpdater(this.manager);

  Future<void> update([bool force = false]) async {
    if (force || await manager.app.currency_hitory.findToday() == null)
      await doUpdate();
  }

  Future<void> doUpdate();

  Future<CurrencyHistory> _getHistory() async {
    final ent = manager.app.currency_hitory.createObject();
    await manager.app.currency_hitory.insert(ent);
    return ent;
  }

  Future<void> _setCurrencyData(
      Currency currency, CurrencyHistory history, num rate) async {
    final cd = manager.app.currency_data.createObject()
      ..currency_id = currency.currency_id
      ..currency_history_id = history.currency_history_id
      ..rate = rate;
    await manager.app.currency_data.insert(cd);
  }
}
