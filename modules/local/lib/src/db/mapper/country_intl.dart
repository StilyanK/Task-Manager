part of local.mapper;

class CountryIntlMapper
    extends Mapper<CountryIntl, CountryIntlCollection, App> {
  String table = 'country_loc';
  dynamic pkey = ['country_id', 'language_id'];

  CountryIntlMapper(m) : super(m);

  Future<CountryIntlCollection> findAllByCountry(int id) =>
      loadC(selectBuilder()
        ..where('country_id = @id')
        ..setParameter('id', id));

  Future deleteByCountry(int id) => execute(deleteBuilder()
    ..where('country_id = @id')
    ..setParameter('id', id));
}

class CountryIntl extends entity.CountryIntl with Entity<App> {}

class CountryIntlCollection extends entity.CountryIntlCollection<CountryIntl> {}
