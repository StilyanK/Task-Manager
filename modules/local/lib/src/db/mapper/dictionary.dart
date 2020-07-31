part of local.mapper;

class DictionaryMapper extends Mapper<Dictionary, DictionaryCollection, App> {
  String table = 'dictionary';

  DictionaryMapper(m) : super(m);

  CollectionBuilder<Dictionary, DictionaryCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()..llike = ['name']);
    return cb;
  }

  Future<Dictionary> findByKey(String key) => loadE(selectBuilder()
    ..where('name = @key')
    ..setParameter('key', key));
}

class Dictionary extends entity.Dictionary with Entity<App> {}

class DictionaryCollection extends entity.DictionaryCollection<Dictionary> {}
