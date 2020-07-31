part of hms_local.ctrl;

class CCurrency extends base.Collection<App, Currency, int> {
  final String group = Group.Local;

  final String scope = Scope.Currency;

  CCurrency(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.currency.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<Map> lister(dynamic o) {
    final cur = new shared.CurrencyService().getCurrency(o.currency_id);
    final d = o.toJson()..addAll(cur.toJson());
    var r = '';
    switch (d['round']) {
      case 4:
        r = '#.25';
        break;
      case 3:
        r = '#.50';
        break;
      case 2:
        r = '#.##';
        break;
      case 1:
        r = '#.#0';
        break;
      case 0:
        r = '#.00';
        break;
      default:
        r = '#.##';
        break;
    }
    d['round'] = r;
    return new Future.value(d);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.currency.deleteById)).then((_) => true);

  void update() => run(group, scope, 'update',
      () => updateCurrencies(true).then((_) => response(null)));
}
