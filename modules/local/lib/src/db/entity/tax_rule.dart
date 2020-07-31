part of hms_local.entity;

@MSerializable()
class TaxRule {
  String name;

  int tax_rule_id;

  Map tax_client;

  Map tax_product;

  Map tax_rate;

  int priority;

  int position;

  bool use_origin_location;

  bool tax_origin_location;

  bool active;

  TaxClientCollection tax_clients;
  TaxProductCollection tax_products;
  TaxRateCollection tax_rates;

  TaxRule();

  void init(Map data) => _$TaxRuleFromMap(this, data);

  Map<String, dynamic> toMap() => _$TaxRuleToMap(this);

  Map<String, dynamic> toJson() => _$TaxRuleToMap(this, true);

  bool containTaxClientId(int tax_client_id) =>
      tax_client.containsKey('$tax_client_id');

  bool containTaxProductId(int tax_product_id) =>
      tax_product.containsKey('$tax_product_id');

  TaxRate getTaxRate(
      int country_id, int origin_country_id, TaxRateCollection trc) {
    if (country_id == null && origin_country_id != null)
      country_id = origin_country_id;
    if (tax_origin_location &&
        country_id != null &&
        origin_country_id != null &&
        country_id != origin_country_id) return null;
    final trc_filtered = new TaxRateCollection();
    tax_rate.forEach((k, v) {
      final tr = trc.firstWhere((rate) => rate.tax_rate_id.toString() == k,
          orElse: () => null);
      if (tr != null) trc_filtered.add(tr);
    });
    final tr = trc_filtered.firstWhere((rate) => rate.country_id == country_id,
        orElse: () => null);
    if (tr != null && use_origin_location && origin_country_id != null)
      return trc_filtered.firstWhere(
          (rate) => rate.country_id == origin_country_id,
          orElse: () => null);
    return tr;
  }
}

class TaxRuleCollection<E extends TaxRule> extends Collection<E> {
  Iterable<Map<String, String>> toJson() => map((t) => t.toJson());

  void fromList(List data) {
    data.forEach((r) => add(new TaxRule()..init(r)));
  }
}
