part of hms_local.ctrl;

class ICurrency extends base.Item<App, Currency, int> {
  final String group = Group.Local;

  final String scope = Scope.Currency;

  ICurrency(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final ent = await manager.app.currency.find(id);
    if (ent == null) throw new base.ResourceNotFoundException();
    return ent.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final currency = await manager.app.currency.prepare(id, data);
    await manager.commit();
    return currency.currency_id;
  }

  Future<bool> doDelete(int id) => manager.app.currency.deleteById(id);
}
