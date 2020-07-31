part of local.ctrl;

class IWeight extends base.Item<App, WeightUnit, int> {
  final String group = Group.Local;

  final String scope = Scope.Weight;

  IWeight(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final ent = await manager.app.weight_unit.find(id);
    if (ent == null) throw new base.ResourceNotFoundException();
    return ent.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final weight = await manager.app.weight_unit.prepare(id, data);
    await manager.commit();
    return weight.weight_unit_id;
  }

  Future<bool> doDelete(int id) => manager.app.weight_unit.deleteById(id);
}
