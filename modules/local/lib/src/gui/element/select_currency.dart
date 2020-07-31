part of local.gui;

class SelectCurrency extends cl_form.Select {
  SelectCurrency() : super() {
    final cur = new shared.CurrencyService();
    cur.getCollection().forEach((v) {
      if (v.currency.active) addOption(v.currency_id, v.currency.title);
    });
    setValue(cur.getCurrencyBaseId());
  }
}
