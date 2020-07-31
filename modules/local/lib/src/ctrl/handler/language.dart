part of hms_local.ctrl;

class ILanguage extends base.Item<App, Language, int> {
  final String group = Group.Local;

  final String scope = Scope.Language;

  ILanguage(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final ent = await manager.app.language.find(id);
    if (ent == null) throw new base.ResourceNotFoundException();
    return ent.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final language = await manager.app.language.prepare(id, data);
    await manager.commit();
    return language.language_id;
  }

  Future<bool> doDelete(int id) => manager.app.language.deleteById(id);
}
