library local.mapper;

import 'dart:async';

import 'package:mapper/mapper.dart';

import 'entity.dart' as entity;

part 'db/mapper/address.dart';
part 'db/mapper/country.dart';
part 'db/mapper/country_intl.dart';
part 'db/mapper/currency.dart';
part 'db/mapper/currency_data.dart';
part 'db/mapper/currency_history.dart';
part 'db/mapper/dictionary.dart';
part 'db/mapper/laboratory_unit.dart';
part 'db/mapper/language.dart';
part 'db/mapper/payment_method.dart';
part 'db/mapper/place.dart';
part 'db/mapper/quantity.dart';
part 'db/mapper/region.dart';
part 'db/mapper/rhif.dart';
part 'db/mapper/tax_client.dart';
part 'db/mapper/tax_product.dart';
part 'db/mapper/tax_rate.dart';
part 'db/mapper/tax_rule.dart';
part 'db/mapper/weight.dart';
part 'db/mapper/zone.dart';
part 'db/mapper/zone_intl.dart';

mixin AppMixin {
  Manager m;

  CountryMapper get country => new CountryMapper(m.convert(new App()))
    ..entity = (() => new Country())
    ..collection = () => new CountryCollection();

  CountryIntlMapper get country_intl =>
      new CountryIntlMapper(m.convert(new App()))
        ..entity = (() => new CountryIntl())
        ..collection = () => new CountryIntlCollection();

  CountryZoneMapper get countryzone =>
      new CountryZoneMapper(m.convert(new App()))
        ..entity = (() => new CountryZone())
        ..collection = () => new CountryZoneCollection();

  CountryZoneIntlMapper get countryzone_intl =>
      new CountryZoneIntlMapper(m.convert(new App()))
        ..entity = (() => new CountryZoneIntl())
        ..collection = () => new CountryZoneIntlCollection();

  QuantityUnitMapper get quantity_unit =>
      new QuantityUnitMapper(m.convert(new App()))
        ..entity = (() => new QuantityUnit())
        ..collection = (() => new QuantityUnitCollection())
        ..notifier = entityQuantity;

  WeightUnitMapper get weight_unit => new WeightUnitMapper(m.convert(new App()))
    ..entity = (() => new WeightUnit())
    ..collection = (() => new WeightUnitCollection())
    ..notifier = entityWeight;

  CurrencyMapper get currency => new CurrencyMapper(m.convert(new App()))
    ..entity = (() => new Currency())
    ..collection = (() => new CurrencyCollection())
    ..notifier = entityCurrency;

  LanguageMapper get language => new LanguageMapper(m.convert(new App()))
    ..entity = (() => new Language())
    ..collection = (() => new LanguageCollection())
    ..notifier = entityLanguage;

  CurrencyDataMapper get currency_data =>
      new CurrencyDataMapper(m.convert(new App()))
        ..entity = (() => new CurrencyData())
        ..collection = (() => new CurrencyDataCollection());

  CurrencyHistoryMapper get currency_hitory =>
      new CurrencyHistoryMapper(m.convert(new App()))
        ..entity = (() => new CurrencyHistory())
        ..collection = (() => new CurrencyHistoryCollection())
        ..notifier = entityCurrencyHistory;

  PaymentMethodMapper get payment_method =>
      new PaymentMethodMapper(m.convert(new App()))
        ..entity = (() => new PaymentMethod())
        ..collection = (() => new PaymentMethodCollection())
        ..notifier = entityPaymentMethod;

  TaxRateMapper get tax_rate => new TaxRateMapper(m.convert(new App()))
    ..entity = (() => new TaxRate())
    ..collection = (() => new TaxRateCollection())
    ..notifier = entityTaxRate;

  TaxClientMapper get tax_client => new TaxClientMapper(m.convert(new App()))
    ..entity = (() => new TaxClient())
    ..collection = (() => new TaxClientCollection())
    ..notifier = entityTaxClient;

  TaxProductMapper get tax_product => new TaxProductMapper(m.convert(new App()))
    ..entity = (() => new TaxProduct())
    ..collection = (() => new TaxProductCollection())
    ..notifier = entityTaxProduct;

  TaxRuleMapper get tax_rule => new TaxRuleMapper(m.convert(new App()))
    ..entity = (() => new TaxRule())
    ..collection = (() => new TaxRuleCollection())
    ..notifier = entityTaxRule;

  DictionaryMapper get dictionary => new DictionaryMapper(m.convert(new App()))
    ..entity = (() => new Dictionary())
    ..collection = (() => new DictionaryCollection())
    ..notifier = entityDictionary;

  AddressMapper get address => new AddressMapper(m.convert(new App()))
    ..entity = (() => new Address())
    ..collection = () => new AddressCollection();

  RhifMapper get rhif => new RhifMapper(m.convert(new App()))
    ..entity = (() => new Rhif())
    ..collection = () => new RhifCollection();

  RegionMapper get region => new RegionMapper(m.convert(new App()))
    ..entity = (() => new Region())
    ..collection = () => new RegionCollection();

  PlaceMapper get place => new PlaceMapper(m.convert(new App()))
    ..entity = (() => new Place())
    ..collection = () => new PlaceCollection();

  LaboratoryUnitMapper get laboratoryUnit =>
      new LaboratoryUnitMapper(m.convert(new App()))
        ..notifier = entityLaboratoryUnit
        ..entity = (() => new LaboratoryUnit())
        ..collection = () => new LaboratoryUnitCollection();
}

class App extends Application with AppMixin {}

class EntityNotifierCustom extends EntityNotifier<PaymentMethod> {
  StreamController contr_status = new StreamController.broadcast();

  Stream onStatus;

  EntityNotifierCustom() : super() {
    onStatus = contr_status.stream;
  }
}

EntityNotifierCustom entityPaymentMethod = new EntityNotifierCustom();
EntityNotifier<Dictionary> entityDictionary = new EntityNotifier();
EntityNotifier<Currency> entityCurrency = new EntityNotifier();
EntityNotifier<CurrencyHistory> entityCurrencyHistory = new EntityNotifier();
EntityNotifier<QuantityUnit> entityQuantity = new EntityNotifier();
EntityNotifier<WeightUnit> entityWeight = new EntityNotifier();
EntityNotifier<TaxRule> entityTaxRule = new EntityNotifier();
EntityNotifier<TaxClient> entityTaxClient = new EntityNotifier();
EntityNotifier<TaxProduct> entityTaxProduct = new EntityNotifier();
EntityNotifier<TaxRate> entityTaxRate = new EntityNotifier();
EntityNotifier<Language> entityLanguage = new EntityNotifier();
EntityNotifier<LaboratoryUnit> entityLaboratoryUnit =
    new EntityNotifier<LaboratoryUnit>();
