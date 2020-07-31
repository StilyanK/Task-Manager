part of hms_local.shared;

class TaxApplied {
  int tax_rate_id;
  num rate;
  int priority;
}

class TaxContract {
  /// Country - customer part
  int country_id;

  /// Country - the seller part
  int origin_country_id;

  TaxContract();

  factory TaxContract.fromMap(Map data) => new TaxContract()
    ..country_id = data['country_id']
    ..origin_country_id = data['origin_country_id'];

  Map<String, int> toMap() =>
      {'country_id': country_id, 'origin_country_id': origin_country_id};

  Map toJson() => toMap();
}

class TaxService {
  static TaxService instance;

  TaxRuleCollection _trc;

  TaxClientCollection _tc;

  TaxProductCollection _tp;

  TaxRateCollection _tr;

  factory TaxService(
      [TaxRuleCollection trc,
      TaxClientCollection tc,
      TaxProductCollection tp,
      TaxRateCollection tr]) {
    if (instance == null || trc != null)
      instance = new TaxService._(trc, tc, tp, tr);
    return instance;
  }

  TaxService._(this._trc, this._tc, this._tp, this._tr);

  TaxRuleCollection<TaxRule> getCollection() => _trc;

  TaxClientCollection<TaxClient> getTaxClientCollection() => _tc;

  TaxProductCollection<TaxProduct> getTaxProductCollection() => _tp;

  TaxRateCollection<TaxRate> getTaxRateCollection() => _tr;

  List<TaxApplied> getAppliedTaxes(int tax_product_id, TaxContract contract) {
    final t = <TaxApplied>[];
    if (contract == null) return t;
    _trc.forEach((rule) {
      if (rule.containTaxProductId(tax_product_id)) {
        final tax_rate = rule.getTaxRate(
            contract.country_id, contract.origin_country_id, _tr);
        if (tax_rate != null) {
          t.add(new TaxApplied()
            ..tax_rate_id = tax_rate.tax_rate_id
            ..rate = tax_rate.rate
            ..priority = rule.priority);
        }
      }
    });
    return t;
  }

  Price getTaxedPrice(Price price, List<TaxApplied> taxes) {
    int current;
    var init_total = price.clone();
    var comp_total = price.clone();
    taxes.forEach((tax) {
      current ??= tax.priority;
      if (tax.priority != current) {
        current = tax.priority;
        init_total = comp_total;
      }
      comp_total += init_total * (tax.rate / 100);
    });
    return comp_total;
  }

  Price getPriceFromTaxedPrice(Price taxed_price, List<TaxApplied> taxes) {
    if (taxes.isEmpty) return taxed_price;
    var current = taxes.first.priority;
    var init_total = taxed_price.clone();
    var comp_total = taxed_price.clone();
    num sum_rates = 0;
    for (var i = taxes.length - 1; i >= 0; i--) {
      final tax = taxes[i];
      if (tax.priority != current) {
        current = tax.priority;
        comp_total -= init_total - init_total / (1 + sum_rates / 100);
        sum_rates = 0;
        init_total = comp_total;
      }
      sum_rates += tax.rate;
    }
    return comp_total -= init_total - init_total / (1 + sum_rates / 100);
  }

  TaxRate getTaxRateById(int tax_rate_id) =>
      _tr.firstWhere((t) => t.tax_rate_id == tax_rate_id, orElse: () => null);

  String taxesToString(List<TaxApplied> taxes, [dynamic localeOrLanguageId]) {
    final language_id = (localeOrLanguageId is String)
        ? new LanguageService().getLanguageId(localeOrLanguageId)
        : localeOrLanguageId;
    return taxes
        .map((ta) =>
            getTaxRateById(ta.tax_rate_id).toFormattedString(language_id))
        .join(', ');
  }
}
