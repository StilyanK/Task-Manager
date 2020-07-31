part of local.mapper;

class CountryZoneMapper
    extends Mapper<CountryZone, CountryZoneCollection, App> {
  String table = 'country_zone';

  CountryZoneMapper(m) : super(m);

  Future<CountryZoneCollection> findAllByCountryId(int id) =>
      loadC(selectBuilder()
        ..where('country_id = @id')
        ..setParameter('id', id));

  Future<CountryZone> findByISO(String iso) => loadE(selectBuilder()
    ..where('iso = @iso')
    ..setParameter('iso', iso));

  CollectionBuilder<CountryZone, CountryZoneCollection, App>
      findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder()
      ..select('country_zone.*')
      ..join('country', 'country.country_id = country_zone.country_id'))
      ..filterRule = (new FilterRule()
        ..eq = ['active']
        ..llike = ['name', 'country']
        ..map = {
          'name': 'country_zone.name',
          'country': 'country.name',
          'active': 'country.active'
        });
    return cb;
  }
}

class CountryZone extends entity.CountryZone with Entity<App> {
  Future<Country> loadCountry() async =>
      country = await manager.app.country.find(country_id);

  Future<CountryZoneIntlCollection> loadLanguages() async => languages =
      await manager.app.countryzone_intl.findAllByZone(country_zone_id);
}

class CountryZoneCollection extends entity.CountryZoneCollection<CountryZone> {}
