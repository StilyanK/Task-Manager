part of hms_local.ctrl;

class IPlace extends base.Item<App, Place, int> {
  final String group = Group.Local;

  final String scope = Scope.Place;

  IPlace(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final place = await manager.app.place.find(id);
    if (place == null) throw new base.ResourceNotFoundException();
    return place.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final place = await manager.app.place.prepare(id, data);
    await manager.commit();
    return place.place_id;
  }

  Future<bool> doDelete(int id) => manager.app.place.deleteById(id);
}
