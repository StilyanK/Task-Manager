part of hms_local.ctrl;

class ITaxRate extends base.Item<App, TaxRate, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  ITaxRate(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final ent = await manager.app.tax_rate.find(id);
    if (ent == null) throw new base.ResourceNotFoundException();
    return ent.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final tax = await manager.app.tax_rate.prepare(id, data);
    await manager.commit();
    return tax.tax_rate_id;
  }

  Future<bool> doDelete(int id) => manager.app.tax_rate.deleteById(id);
}

class ITaxClient extends base.Item<App, TaxClient, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  ITaxClient(req) : super(req, new App());

  Future<Map> doGet(int id) async =>
      (await manager.app.tax_client.find(id)).toJson();

  Future<int> doSave(int id, Map data) async {
    final tax = await manager.app.tax_client.prepare(id, data);
    await manager.commit();
    return tax.tax_client_id;
  }

  Future<bool> doDelete(int id) => manager.app.tax_client.deleteById(id);
}

class ITaxProduct extends base.Item<App, TaxProduct, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  ITaxProduct(req) : super(req, new App());

  Future<Map> doGet(int id) async =>
      (await manager.app.tax_product.find(id)).toJson();

  Future<int> doSave(int id, Map data) async {
    final tax = await manager.app.tax_product.prepare(id, data);
    await manager.commit();
    return tax.tax_product_id;
  }

  Future<bool> doDelete(int id) => manager.app.tax_product.deleteById(id);
}

class ITaxRule extends base.Item<App, TaxRule, int> {
  final String group = Group.Local;

  final String scope = Scope.Tax;

  ITaxRule(req) : super(req, new App());

  Future<Map> doGet(int id) async =>
      (await manager.app.tax_rule.find(id)).toJson();

  Future<int> doSave(int id, Map data) async {
    data['tax_client'] = _cleanMap(data['tax_client']);
    data['tax_product'] = _cleanMap(data['tax_product']);
    data['tax_rate'] = _cleanMap(data['tax_rate']);
    final tax = await manager.app.tax_rule.prepare(id, data);
    await manager.commit();
    return tax.tax_rule_id;
  }

  Map _cleanMap(Map data) {
    final m = {};
    data.forEach((k, v) {
      if (v != false) m[k] = v;
    });
    return m;
  }

  Future<bool> doDelete(int id) => manager.app.tax_rule.deleteById(id);
}
