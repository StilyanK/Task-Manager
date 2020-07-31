part of local.mapper;

class CountryZoneIntlMapper
    extends Mapper<CountryZoneIntl, CountryZoneIntlCollection, App> {
  String table = 'country_zone_loc';
  dynamic pkey = ['country_zone_id', 'language_id'];

  CountryZoneIntlMapper(m) : super(m);

  Future<CountryZoneIntlCollection> findAllByZone(int id) =>
      loadC(selectBuilder()
        ..where('country_zone_id = @id')
        ..setParameter('id', id));

  Future deleteByZone(int id) => execute(deleteBuilder()
    ..where('country_zone_id = @id')
    ..setParameter('id', id));
}

class CountryZoneIntl extends entity.CountryZoneIntl with Entity<App> {}

class CountryZoneIntlCollection
    extends entity.CountryZoneIntlCollection<CountryZoneIntl> {}
