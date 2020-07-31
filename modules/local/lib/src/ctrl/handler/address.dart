part of hms_local.ctrl;

class IAddress extends base.Item<App, Address, int> {
  final String group = Group.Local;

  final String scope = Scope.Address;

  IAddress(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final address = await manager.app.address.find(id);
    if (address == null) throw new base.ResourceNotFoundException();
    return address.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final address = await manager.app.address.prepare(id, data);
    await manager.commit();
    return address.address_id;
  }

  Future<bool> doDelete(int id) => manager.app.address.deleteById(id);
}
