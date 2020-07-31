part of hms_local.ctrl;

class IRegion extends base.Item<App, Region, String> {
  final String group = Group.Local;

  final String scope = Scope.Region;

  IRegion(req) : super(req, new App());

  Future<Map> doGet(String id) async {
    final region = await manager.app.region.find(id);
    if (region == null) throw new base.ResourceNotFoundException();
    return region.toJson();
  }

  Future<String> doSave(String id, Map data) async {
    final region = await manager.app.region.prepare(id, data);
    await manager.commit();
    return region.code;
  }

  Future<bool> doDelete(String id) => manager.app.region.deleteById(id);
}
