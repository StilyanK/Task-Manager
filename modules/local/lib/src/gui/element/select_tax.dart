part of local.gui;

class SelectTaxRate extends cl_form.Select {
  SelectTaxRate([first]) : super() {
    final q = new shared.TaxService();
    if (first != null) addOption(first[0], first[1]);
    q.getTaxRateCollection().forEach((t) => addOption(t.tax_rate_id, t.name));
  }
}

class SelectProductTaxClass extends cl_form.Select {
  SelectProductTaxClass([first]) : super() {
    final q = new shared.TaxService();
    if (first != null) addOption(first[0], first[1]);
    q
        .getTaxProductCollection()
        .forEach((t) => addOption(t.tax_product_id, t.name));
  }
}

class SelectClientTaxClass extends cl_form.Select {
  SelectClientTaxClass([first]) : super() {
    final q = new shared.TaxService();
    if (first != null) addOption(first[0], first[1]);
    q
        .getTaxClientCollection()
        .forEach((t) => addOption(t.tax_client_id, t.name));
  }
}
