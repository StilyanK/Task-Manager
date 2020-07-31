part of hms_local.mapper;

class CountryMapper extends Mapper<Country, CountryCollection, App> {
  String table = 'country';

  CountryMapper(m) : super(m);

  Future<CountryCollection> findAll() =>
      loadC(selectBuilder()..orderBy('name', 'ASC'));

  Future<CountryCollection> findAllActive() => loadC(selectBuilder()
    ..where('active = 1')
    ..orderBy('name', 'ASC'));

  CollectionBuilder<Country, CountryCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['country_id', 'active']
        ..llike = ['name']);
    return cb;
  }

  Future<Country> findByISO(String iso) => loadE(selectBuilder()
    ..where('iso = @iso')
    ..setParameter('iso', iso));

  Future<CountryCollection> findBySuggestion(String sug) =>
      loadC(selectBuilder()
        ..where('to_tsvector(name) @@ to_tsquery(@s)')
        ..setParameter('s', new TSquery(sug).toString())
        ..orderBy('name', 'ASC')
        ..limit(10));
}

class Country extends entity.Country with Entity<App> {
  Future<CountryZoneCollection> loadZones() async =>
      zones = await manager.app.countryzone.findAllByCountryId(country_id);

  Future<CountryIntlCollection> loadLanguages() async =>
      languages = await manager.app.country_intl.findAllByCountry(country_id);
}

class CountryCollection extends entity.CountryCollection<Country> {}
