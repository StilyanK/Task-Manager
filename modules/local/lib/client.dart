import 'package:cl/app.dart' as cl_app;

import 'intl/client.dart' as intl;
import 'src/gui.dart';
import 'src/path.dart';
import 'src/permission.dart';

export 'src/gui.dart';
export 'src/path.dart';
export 'src/shared.dart';

abstract class MenuItem {
  static final cl_app.MenuElement Localization = new cl_app.MenuElement()
    ..title = intl.Localization()
    ..icon = Icon.Localization;

  static final cl_app.MenuElement Country = new cl_app.MenuElement()
    ..title = intl.Countries()
    ..icon = Icon.Country
    ..scope = '${Group.Local}:${Scope.Country}:read'
    ..action = (ap) => ap.run('country/list');

  static final cl_app.MenuElement Zones = new cl_app.MenuElement()
    ..title = intl.Zones()
    ..icon = Icon.Zone
    ..scope = '${Group.Local}:${Scope.Zone}:read'
    ..action = (ap) => ap.run('zone/list');

  static final cl_app.MenuElement Currencies = new cl_app.MenuElement()
    ..title = intl.Currencies()
    ..icon = Icon.Currency
    ..scope = '${Group.Local}:${Scope.Currency}:read'
    ..action = (ap) => ap.run('currency/list');

  static final cl_app.MenuElement PaymentMethods = new cl_app.MenuElement()
    ..title = intl.Payment_methods()
    ..icon = Icon.PaymentMethod
    ..scope = '${Group.Local}:${Scope.Payment}:read'
    ..action = (ap) => ap.run('payment_method/list');

  static final cl_app.MenuElement Taxes = new cl_app.MenuElement()
    ..title = intl.Taxes()
    ..icon = Icon.Tax;

  static final cl_app.MenuElement TaxClient = new cl_app.MenuElement()
    ..title = intl.Tax_client_class()
    ..icon = Icon.TaxClient
    ..scope = '${Group.Local}:${Scope.Tax}:read'
    ..action = (ap) => ap.run('tax_client/list');

  static final cl_app.MenuElement TaxProduct = new cl_app.MenuElement()
    ..title = intl.Tax_product_class()
    ..icon = Icon.TaxProduct
    ..scope = '${Group.Local}:${Scope.Tax}:read'
    ..action = (ap) => ap.run('tax_product/list');

  static final cl_app.MenuElement TaxRate = new cl_app.MenuElement()
    ..title = intl.Tax_rate()
    ..icon = Icon.TaxRate
    ..scope = '${Group.Local}:${Scope.Tax}:read'
    ..action = (ap) => ap.run('tax_rate/list');

  static final cl_app.MenuElement TaxRule = new cl_app.MenuElement()
    ..title = intl.Tax_rule()
    ..icon = Icon.TaxRule
    ..scope = '${Group.Local}:${Scope.Tax}:read'
    ..action = (ap) => ap.run('tax_rule/list');

  static final cl_app.MenuElement Languages = new cl_app.MenuElement()
    ..title = intl.Languages()
    ..icon = Icon.Language
    ..scope = '${Group.Local}:${Scope.Language}:read'
    ..action = (ap) => ap.run('language/list');

  static final cl_app.MenuElement Dictionary = new cl_app.MenuElement()
    ..title = intl.Dictionary()
    ..icon = Icon.Dictionary
    ..scope = '${Group.Local}:${Scope.Dictionary}:read'
    ..action = (ap) => ap.run('dictionary/list');

  static final cl_app.MenuElement Quantity = new cl_app.MenuElement()
    ..title = intl.Quantity()
    ..icon = Icon.Quantity
    ..scope = '${Group.Local}:${Scope.Quantity}:read'
    ..action = (ap) => ap.run('quantity_units/list');

  static final cl_app.MenuElement Weight = new cl_app.MenuElement()
    ..title = intl.Weight()
    ..icon = Icon.Weight
    ..scope = '${Group.Local}:${Scope.Weight}:read'
    ..action = (ap) => ap.run('weight_units/list');

  static final cl_app.MenuElement Rhif = new cl_app.MenuElement()
    ..title = intl.Rhif()
    ..icon = Icon.Rhif
    ..scope = '${Group.Local}:${Scope.Rhif}:read'
    ..action = (ap) => ap.run('rhif/list');

  static final cl_app.MenuElement LabUnit = new cl_app.MenuElement()
    ..title = intl.Unit()
    ..icon = Icon.LabUnit
    ..scope = '${Group.Local}:${Scope.LabUnit}:read'
    ..action = (ap) => ap.run('laboratory_units/list');
}

void init(cl_app.Application ap) {
  initCurrencies(ap.client.data['currency']);
  initTaxes(ap.client.data['tax']);
  initQuantityUnits(ap.client.data['quantity']);
  initWeightUnits(ap.client.data['weight']);
  initLanguages(ap.client.data['language']);
  initPaymentMethods(ap.client.data['payments']);
  initLabUnits(ap.client.data['lab_units']);

  ap.onServerCall.filter(EVENT_QUANTITY).listen(initQuantityUnits);
  ap.onServerCall.filter(EVENT_WEIGHT).listen(initWeightUnits);
  ap.onServerCall.filter(EVENT_TAX).listen(initTaxes);
  ap.onServerCall.filter(EVENT_CURRENCY).listen(initCurrencies);
  ap.onServerCall.filter(EVENT_PAYMENT).listen(initPaymentMethods);
  ap.onServerCall.filter(EVENT_LANGUAGE).listen(initLanguages);
  ap.onServerCall.filter(EVENT_LAB_UNIT).listen(initLabUnits);

  ap
    ..addRoute(new cl_app.Route('country/list', (ap, p) => new CountryList(ap)))
    ..addRoute(new cl_app.Route('zone/list', (ap, p) => new ZoneList(ap)))
    ..addRoute(
        new cl_app.Route('currency/list', (ap, p) => new CurrencyList(ap)))
    ..addRoute(new cl_app.Route(
        'payment_method/list', (ap, p) => new PaymentMethodList(ap)))
    ..addRoute(
        new cl_app.Route('tax_client/list', (ap, p) => new TaxClientList(ap)))
    ..addRoute(
        new cl_app.Route('tax_product/list', (ap, p) => new TaxProductList(ap)))
    ..addRoute(
        new cl_app.Route('tax_rate/list', (ap, p) => new TaxRateList(ap)))
    ..addRoute(
        new cl_app.Route('tax_rule/list', (ap, p) => new TaxRuleList(ap)))
    ..addRoute(
        new cl_app.Route('language/list', (ap, p) => new LanguageList(ap)))
    ..addRoute(
        new cl_app.Route('dictionary/list', (ap, p) => new DictionaryList(ap)))
    ..addRoute(new cl_app.Route(
        'quantity_units/list', (ap, p) => new QuantityUnitList(ap)))
    ..addRoute(new cl_app.Route(
        'weight_units/list', (ap, p) => new WeightUnitList(ap)))
    ..addRoute(new cl_app.Route('rhif/list', (ap, p) => new RhifList(ap)))
    ..addRoute(
        new cl_app.Route('country/:int', (ap, p) => new Country(ap, p[0])))
    ..addRoute(new cl_app.Route('zone/:int', (ap, p) => new Zone(ap, p[0])))
    ..addRoute(
        new cl_app.Route('currency/:int', (ap, p) => new Currency(ap, p[0])))
    ..addRoute(
        new cl_app.Route('language/:int', (ap, p) => new Language(ap, p[0])))
    ..addRoute(new cl_app.Route(
        'dictionary/:int', (ap, p) => new Dictionary(ap, p[0])))
    ..addRoute(new cl_app.Route('rhif/:int', (ap, p) => new Rhif(ap, p[0])))
    ..addRoute(
        new cl_app.Route('tax_client/:int', (ap, p) => new TaxClient(ap, p[0])))
    ..addRoute(new cl_app.Route(
        'tax_product/:int', (ap, p) => new TaxProduct(ap, p[0])))
    ..addRoute(
        new cl_app.Route('tax_rate/:int', (ap, p) => new TaxRate(ap, p[0])))
    ..addRoute(
        new cl_app.Route('tax_rule/:int', (ap, p) => new TaxRule(ap, p[0])))
    ..addRoute(new cl_app.Route('payment/in_cash/:int',
        (ap, p) => new PaymentCash(ap, intl.In_cash(), p[0])))
    ..addRoute(new cl_app.Route('payment/bank_transfer/:int',
        (ap, p) => new PaymentBank(ap, intl.Bank_transfer(), p[0])))
    ..addRoute(new cl_app.Route('payment/pay_on_delivery/:int',
        (ap, p) => new PaymentDelivery(ap, intl.Pay_on_delivery(), p[0])))
    ..addRoute(new cl_app.Route(
        'payment/epay/:int', (ap, p) => new PaymentEpay(ap, 'Epay', p[0])))
    ..addRoute(new cl_app.Route('payment/paypal/:int',
        (ap, p) => new PaymentPaypal(ap, 'Paypal', p[0])))
    ..addRoute(new cl_app.Route('payment/stripe/:int', (ap, p) => new PaymentStripe(ap, 'Stripe', p[0])))
    ..addRoute(new cl_app.Route('quantity_units/:int', (ap, p) => new QuantityUnit(ap, p[0])))
    ..addRoute(new cl_app.Route('weight_units/:int', (ap, p) => new WeightUnit(ap, p[0])))
    ..addRoute(new cl_app.Route('laboratory_units/item/:int', (ap, p) => new LaboratoryUnit(ap, p[0])))
    ..addRoute(new cl_app.Route('laboratory_units/list', (ap, p) => new LaboratoryUnitList(ap)));
}
