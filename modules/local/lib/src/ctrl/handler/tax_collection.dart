part of hms_local.ctrl;

class CTaxRate extends base.Collection<App, TaxRate, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  CTaxRate(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.tax_rate.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.tax_rate.deleteById)).then((_) => true);
}

class CTaxClient extends base.Collection<App, TaxClient, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  CTaxClient(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.tax_client.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.tax_client.deleteById)).then((_) => true);
}

class CTaxProduct extends base.Collection<App, TaxProduct, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  CTaxProduct(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.tax_product.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.tax_product.deleteById))
          .then((_) => true);
}

class CTaxRule extends base.Collection<App, TaxRule, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  CTaxRule(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.tax_rule.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<Map> lister(TaxRule o) async {
    await Future.wait(
        [o.loadTaxClients(), o.loadTaxProducts(), o.loadTaxRates()]);
    final m = o.toJson();
    m['tax_clients'] = o.tax_clients.toFString();
    m['tax_products'] = o.tax_products.toFString();
    m['tax_rates'] = o.tax_rates.toFString();
    return m;
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.tax_rule.deleteById)).then((_) => true);
}
