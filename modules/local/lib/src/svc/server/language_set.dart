part of local.server;

class Set {
  final Manager _manager;

  Set([this._manager]);

  Map _setLangRows(Map data) {
    final rows = {};
    data.forEach((k, v) {
      if (v is Map) {
        v.forEach((k2, v2) {
          if (rows[k2] == null) rows[k2] = {};
          rows[k2][k] = v2;
        });
      }
    });
    return rows;
  }

  Future saveLanguageData(Mapper mapper, String key, int key_value, Map data) {
    final l = <Future>[];
    _setLangRows(data).forEach((k, v) {
      l.add(mapper.find([key_value, k]).then((lang) {
        if (lang != null) {
          if (v.values.every((e) => e == null)) {
            _manager.addDelete(lang);
            return;
          } else {
            v[key] = key_value;
            v['language_id'] = int.parse(k);
            lang.init(v);
            _manager.addDirty(lang);
          }
        } else if (v.values.any((e) => e != null)) {
          v[key] = key_value;
          v['language_id'] = int.parse(k);
          lang = mapper.createObject(v);
          _manager.addNew(lang);
        }
      }));
    });
    return Future.wait(l);
  }
}
