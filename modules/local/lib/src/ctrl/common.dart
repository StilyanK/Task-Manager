part of hms_local.ctrl;

void schedCurrencyUpdate() {
  new task.ScheduleManager()
      .get('currency')
      .addEvent(new task.ScheduleEvent('update', () {
        schedCurrencyUpdate();
        updateCurrencies();
      }, execute_after: const Duration(days: 1)));
}

Future<void> updateCurrencies([bool force = false]) =>
    base.dbWrap<void, App>(new App(), (manager) async {
      await manager.begin();
      await currencyUpdater(manager).update(force);
      await manager.commit();
    });

server.CUpdater Function(Manager) currencyUpdater =
    (manager) => new server.UpdaterECB(manager);

Future<void> preloadCurrencies(Manager<App> manager) async {
  final col = await manager.app.currency_data.findByLastHistory();
  if (col == null) return updateCurrencies();
  for (final cd in col) {
    await cd.loadCurrency();
    await cd.loadHistory();
  }
  new shared.CurrencyService(col, 1);
}

Future preloadUnits(Manager<App> manager) => manager.app.quantity_unit
    .findAll()
    .then((c) => new shared.QuantityService(c));

Future preloadWeights(Manager<App> manager) =>
    manager.app.weight_unit.findAll().then((c) => new shared.WeightService(c));

Future preloadTaxes(Manager<App> manager) async {
  final tc = await manager.app.tax_client.findAll();
  final tp = await manager.app.tax_product.findAll();
  final tr = await manager.app.tax_rate.findAll();
  final col = await manager.app.tax_rule.findAllByPriority();
  return new shared.TaxService(col, tc, tp, tr);
}

Future preloadLanguages(Manager<App> manager) => manager.app.language
    .findAllActive()
    .then((c) => new shared.LanguageService(c));

Future preloadPayments(Manager<App> manager) => manager.app.payment_method
    .findAll()
    .then((c) => new shared.PaymentMethodService(c));

Future preloadLabUnits(Manager<App> manager) => manager.app.laboratoryUnit
    .findAll()
    .then((c) => new shared.LabUnitService(c));

QuantityUnitCollection fetchQuantityUnits() =>
    new shared.QuantityService().getCollection();

WeightUnitCollection fetchWeightUnits() =>
    new shared.WeightService().getCollection();

List<Map> fetchCurrency() =>
    new shared.CurrencyService().getCollection().toJson();

LanguageCollection fetchLanguage() =>
    new shared.LanguageService().getCollection();

PaymentMethodCollection fetchPaymentMethod() =>
    new shared.PaymentMethodService().getCollection();

LaboratoryUnitCollection fetchLabUnits() =>
    new shared.LabUnitService().getCollection();

Map fetchTax() => {
      'rule': new shared.TaxService().getCollection(),
      'client': new shared.TaxService().getTaxClientCollection(),
      'product': new shared.TaxService().getTaxProductCollection(),
      'rate': new shared.TaxService().getTaxRateCollection()
    };
