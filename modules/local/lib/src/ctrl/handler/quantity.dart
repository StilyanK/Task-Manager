part of local.ctrl;

class IQuantity extends base.Item<App, QuantityUnit, int> {
  final String group = Group.Local;

  final String scope = Scope.Quantity;

  IQuantity(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final ent = await manager.app.quantity_unit.find(id);
    if (ent == null) throw new base.ResourceNotFoundException();
    return ent.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final quantity = await manager.app.quantity_unit.prepare(id, data);
    await manager.commit();
    return quantity.quantity_unit_id;
  }

  Future<bool> doDelete(int id) => manager.app.quantity_unit.deleteById(id);
}
