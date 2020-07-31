part of local.ctrl;

class IRhif extends base.Item<App, Rhif, String> {
  final String group = Group.Local;

  final String scope = Scope.Rhif;

  IRhif(req) : super(req, new App());

  Future<Map> doGet(String id) async {
    final rhif = await manager.app.rhif.find(id);
    if (rhif == null) throw new base.ResourceNotFoundException();
    return rhif.toJson();
  }

  Future<String> doSave(String id, Map data) async {
    final rhif = await manager.app.rhif.prepare(id, data);
    await manager.commit();
    return rhif.rhif_id;
  }

  Future<bool> doDelete(String id) => manager.app.rhif.deleteById(id);
}
