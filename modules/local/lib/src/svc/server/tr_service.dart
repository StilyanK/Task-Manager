part of local.server;

class Yandex {
  int _index;
  Map _slug_cache;
  final _slug_pattern = new RegExp(r'{[^}]*}|%s');
  String api_key;
  int limit;

  Yandex(
      [this.api_key = 'trnsl.1.1.20170126T230658Z.5bb9474a5f035843.'
          '3a02ea8295673f2b82a1adbed1a3a5627b361218',
      this.limit = 10000]);

  String _encode(String text) {
    final matches = _slug_pattern.allMatches(text);
    var text_new = text;
    matches.forEach((match) {
      text_new = text_new.replaceAll(match[0], '{$_index}');
      _slug_cache['{$_index}'] = match[0];
      _index++;
    });
    return text_new;
  }

  String _decode(String text) {
    final matches = _slug_pattern.allMatches(text);
    var text_orig = text;
    matches.forEach((match) {
      if (_slug_cache.containsKey(match[0]))
        text_orig = text_orig.replaceAll(match[0], _slug_cache[match[0]]);
    });
    return text_orig;
  }

  Future<List<String>> translate(
      List<String> text, String lang_from, String lang_to) async {
    _index = 0;
    _slug_cache = {};
    var size = 0;
    final requests = [];
    var current = [];
    requests.add(current);
    text.forEach((part) {
      part = _encode(part);
      size += part.length;
      if (size > limit) {
        current = [];
        requests.add(current);
        size = 0;
      }
      current.add(part);
    });
    final result = <String>[];
    for (final request in requests) {
      final resp = await http.post(
          new Uri(
              scheme: 'https',
              port: 443,
              host: 'translate.yandex.net',
              path: 'api/v1.5/tr.json/translate',
              queryParameters: {'key': api_key, 'lang': '$lang_from-$lang_to'}),
          body: 'text=${request.join('&text=')}',
          headers: {'content-type': 'application/x-www-form-urlencoded'});
      final res = json.decode(resp.body);
      if (res is Map && res['code'] != 200) {
        switch (res['code']) {
          case 401:
            throw new Exception('Invalid API key');
            break;
          case 402:
            throw new Exception('Blocked API key');
            break;
          case 404:
            throw new Exception(
                'Exceeded the daily limit on the amount of translated text');
            break;
          case 413:
            throw new Exception('Exceeded the maximum text size');
            break;
          case 422:
            throw new Exception('The text cannot be translated');
            break;
          case 501:
            throw new Exception(
                'The specified translation direction is not supported');
            break;
        }
      }
      res['text'].forEach((text) {
        result.add(_decode(text));
      });
    }
    return result;
  }
}
