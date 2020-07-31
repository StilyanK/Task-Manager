part of local.mapper;

class TaxRuleMapper extends Mapper<TaxRule, TaxRuleCollection, App> {
  String table = 'tax_rule';

  TaxRuleMapper(m) : super(m);

  CollectionBuilder<TaxRule, TaxRuleCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['active']
        ..llike = ['name']);
    return cb;
  }

  Future<TaxRuleCollection> findAllByPriority() => loadC(selectBuilder()
    ..orderBy('priority', 'ASC')
    ..where('active = TRUE'));
}

class TaxRule extends entity.TaxRule with Entity<App> {
  Future<TaxProductCollection> loadTaxProducts() async {
    tax_products = new TaxProductCollection();
    for (final k in tax_product.keys) {
      final r = await manager.app.tax_product.find(k);
      if (r != null) tax_products.add(r);
    }
    return tax_products;
  }

  Future<TaxClientCollection> loadTaxClients() async {
    tax_clients = new TaxClientCollection();
    for (final k in tax_client.keys) {
      final r = await manager.app.tax_client.find(k);
      if (r != null) tax_clients.add(r);
    }
    return tax_clients;
  }

  Future<TaxRateCollection> loadTaxRates() async {
    tax_rates = new TaxRateCollection();
    for (final k in tax_rate.keys) {
      final r = await manager.app.tax_rate.find(k);
      if (r != null) tax_rates.add(r);
    }
    return tax_rates;
  }
}

class TaxRuleCollection extends entity.TaxRuleCollection<TaxRule> {}
