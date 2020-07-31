part of hms_local.ctrl;

class IZone extends base.Item<App, CountryZone, int> {
  final String group = Group.Local;

  final String scope = Scope.Zone;

  IZone(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final zone = await manager.app.countryzone.find(id);
    if (zone == null) throw new base.ResourceNotFoundException();
    await zone.loadLanguages();
    final m = zone.toJson();
    m['languages'] = zone.languages;
    return m;
  }

  Future<int> doSave(int id, Map data) async {
    final zone = await manager.app.countryzone.prepare(id, data);
    await manager.persist();
    await new server.Set(manager).saveLanguageData(manager.app.countryzone_intl,
        'country_zone_id', zone.country_zone_id, {'name': data['languages']});
    await manager.commit();
    return zone.country_zone_id;
  }

  Future<bool> doDelete(int id) => manager.app.countryzone.deleteById(id);
}
