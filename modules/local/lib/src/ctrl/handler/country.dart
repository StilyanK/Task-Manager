part of local.ctrl;

class ICountry extends base.Item<App, Country, int> {
  final String group = Group.Local;

  final String scope = Scope.Country;

  ICountry(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final country = await manager.app.country.find(id);
    if (country == null) throw new base.ResourceNotFoundException();
    await country.loadLanguages();
    final m = country.toJson();
    m['languages'] = country.languages;
    return m;
  }

  Future<int> doSave(int id, Map data) async {
    final country = await manager.app.country.prepare(id, data);
    await manager.persist();
    await new server.Set(manager).saveLanguageData(manager.app.country_intl,
        'country_id', country.country_id, {'name': data['languages']});
    await manager.commit();
    return country.country_id;
  }

  Future<bool> doDelete(int id) => manager.app.country.deleteById(id); //look
}
