part of local.ctrl;

class IDictionary extends base.Item<App, Dictionary, int> {
  final String group = Group.Local;

  final String scope = Scope.Dictionary;

  IDictionary(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final e = await manager.app.dictionary.find(id);
    if (e == null) throw new base.ResourceNotFoundException();
    return e.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final e = await manager.app.dictionary.prepare(id, data);
    await manager.commit();
    return e.dictionary_id;
  }

  Future<bool> doDelete(int id) => manager.app.dictionary.deleteById(id);
}
