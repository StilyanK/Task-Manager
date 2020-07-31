part of local.ctrl;

class CDictionary extends base.Collection<App, Dictionary, int> {
  final String group = Group.Local;

  final String scope = Scope.Dictionary;

  CDictionary(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.dictionary.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future getAllTR() => run(group, scope, 'create', () async {
        final pattern = new RegExp(r'{{#_}}([^}]+){{/_}}');
        final d =
            new Directory('${base.path}/web/packages').list(recursive: true);
        final matches = [];
        await for (final f in d) {
          if (f is File && f.path.endsWith('.html')) {
            final source = await f.readAsString();
            pattern.allMatches(source).forEach((match) {
              if (!matches.contains(match[1])) matches.add(match[1]);
            });
          }
        }
        manager = await new Database().init(new App());
        var n = 0;
        final col = await manager.app.dictionary.findAll();
        for (final key in matches) {
          final d = await manager.app.dictionary.findByKey(key);
          if (d == null) {
            n++;
            await manager.app.dictionary
                .insert(manager.app.dictionary.createObject()
                  ..name = key
                  ..intl = {});
          } else {
            col.remove(d);
          }
        }
        if (col.isNotEmpty)
          await Future.wait(col.map(manager.app.dictionary.delete));
        return response(n);
      });

  Future<Map> lister(covariant Dictionary o) async {
    final m = o.toJson();
    var count = 0;
    var tr = 0;
    o.intl.forEach((k, v) {
      count++;
      if (v != null && v.isNotEmpty) tr++;
    });
    m['translated'] = count == 0 ? '0%' : '${tr / count * 100}%';
    return m;
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.dictionary.deleteById)).then((_) => true);
}
