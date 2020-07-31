part of hms_local.server;

class UpdaterECB extends CUpdater {
  final String _link =
      'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml';

  final String _pattern = r"currency='([A-Z]{3})'\s+rate='([0-9.]+)'";

  UpdaterECB(m) : super(m);

  Future<bool> doUpdate() async {
    final client = new HttpClient();
    final request = await client.getUrl(Uri.parse(_link));
    final response = await request.close();

    final data = await response.transform(utf8.decoder).toList();
    client.close();
    final c = <String, num>{};
    new RegExp(_pattern)
        .allMatches(data.join(''))
        .forEach((m) => c[m[1]] = num.tryParse(m[2]));
    if (c.isNotEmpty) {
      final col = await manager.app.currency.findAll();
      final ch = await _getHistory();
      for (final currency in col) {
        var rate = c[currency.title] ?? 1;
        if (currency.title == 'BGN') rate = 1.95583;
        await _setCurrencyData(currency, ch, rate);
      }
      return true;
    }
    return false;
  }
}
