part of local.mapper;

class LanguageMapper extends Mapper<Language, LanguageCollection, App> {
  String table = 'language';

  LanguageMapper(m) : super(m);

  CollectionBuilder<Language, LanguageCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['language_id', 'active']
        ..llike = ['name', 'code', 'locale']);
    return cb;
  }

  Future<LanguageCollection> findAllActive() => loadC(selectBuilder()
    ..where('active = TRUE')
    ..orderBy('position'));
}

class Language extends entity.Language with Entity<App> {}

class LanguageCollection extends entity.LanguageCollection<Language> {}
