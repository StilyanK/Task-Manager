part of hms_local.ctrl;

class ILabUnit extends base.Item<App, LaboratoryUnit, int> {
  final String group = Group.Local;
  final String scope = Scope.LabUnit;

  ILabUnit(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final ent = await manager.app.laboratoryUnit.find(id);
    if (ent == null) throw new base.ResourceNotFoundException();
    return ent.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final ent = await manager.app.laboratoryUnit.prepare(id, data);
    await manager.commit();
    return ent.laboratory_unit_id;
  }

  Future<bool> doDelete(int id) => manager.app.laboratoryUnit.deleteById(id);
}
