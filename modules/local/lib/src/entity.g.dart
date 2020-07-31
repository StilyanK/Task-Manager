// GENERATED CODE - DO NOT MODIFY BY HAND

part of local.entity;

// **************************************************************************
// EntitySerializableGenerator
// **************************************************************************

abstract class $Address {
  static const String address_id = 'address_id';
  static const String street = 'street';
  static const String residential_complex = 'residential_complex';
  static const String number = 'number';
  static const String bloc = 'bloc';
  static const String entrance = 'entrance';
  static const String floor = 'floor';
  static const String apartment = 'apartment';
  static const String place_id = 'place_id';
  static const String zip = 'zip';
  static const String region_id = 'region_id';
  static const String city = 'city';
  static const String address = 'address';
  static const String state = 'state';
  static const String country_id = 'country_id';
  static const String rhif_id = 'rhif_id';
}

void _$AddressFromMap(Address obj, Map data) => obj
  ..address_id = data[$Address.address_id]
  ..street = data[$Address.street]
  ..residential_complex = data[$Address.residential_complex]
  ..number = data[$Address.number]
  ..bloc = data[$Address.bloc]
  ..entrance = data[$Address.entrance]
  ..floor = data[$Address.floor]
  ..apartment = data[$Address.apartment]
  ..place_id = data[$Address.place_id]
  ..zip = data[$Address.zip]
  ..region_id = data[$Address.region_id]
  ..city = data[$Address.city]
  ..address = data[$Address.address]
  ..state = data[$Address.state]
  ..country_id = data[$Address.country_id]
  ..rhif_id = data[$Address.rhif_id];

Map<String, dynamic> _$AddressToMap(Address obj, [asJson = false]) =>
    <String, dynamic>{
      $Address.address_id: obj.address_id,
      $Address.street: obj.street,
      $Address.residential_complex: obj.residential_complex,
      $Address.number: obj.number,
      $Address.bloc: obj.bloc,
      $Address.entrance: obj.entrance,
      $Address.floor: obj.floor,
      $Address.apartment: obj.apartment,
      $Address.place_id: obj.place_id,
      $Address.zip: obj.zip,
      $Address.region_id: obj.region_id,
      $Address.city: obj.city,
      $Address.address: obj.address,
      $Address.state: obj.state,
      $Address.country_id: obj.country_id,
      $Address.rhif_id: obj.rhif_id
    };

abstract class $Country {
  static const String country_id = 'country_id';
  static const String name = 'name';
  static const String iso = 'iso';
  static const String geo_lat = 'geo_lat';
  static const String geo_lng = 'geo_lng';
  static const String active = 'active';
}

void _$CountryFromMap(Country obj, Map data) => obj
  ..country_id = data[$Country.country_id]
  ..name = data[$Country.name]
  ..iso = data[$Country.iso]
  ..geo_lat = data[$Country.geo_lat]
  ..geo_lng = data[$Country.geo_lng]
  ..active = data[$Country.active];

Map<String, dynamic> _$CountryToMap(Country obj, [asJson = false]) =>
    <String, dynamic>{
      $Country.country_id: obj.country_id,
      $Country.name: obj.name,
      $Country.iso: obj.iso,
      $Country.geo_lat: obj.geo_lat,
      $Country.geo_lng: obj.geo_lng,
      $Country.active: obj.active
    };

abstract class $CountryIntl {
  static const String country_id = 'country_id';
  static const String language_id = 'language_id';
  static const String name = 'name';
}

void _$CountryIntlFromMap(CountryIntl obj, Map data) => obj
  ..country_id = data[$CountryIntl.country_id]
  ..language_id = data[$CountryIntl.language_id]
  ..name = data[$CountryIntl.name];

Map<String, dynamic> _$CountryIntlToMap(CountryIntl obj, [asJson = false]) =>
    <String, dynamic>{
      $CountryIntl.country_id: obj.country_id,
      $CountryIntl.language_id: obj.language_id,
      $CountryIntl.name: obj.name
    };

abstract class $Currency {
  static const String currency_id = 'currency_id';
  static const String title = 'title';
  static const String symbol = 'symbol';
  static const String symbol_position = 'symbol_position';
  static const String active = 'active';
}

void _$CurrencyFromMap(Currency obj, Map data) => obj
  ..currency_id = data[$Currency.currency_id]
  ..title = data[$Currency.title]
  ..symbol = data[$Currency.symbol]
  ..symbol_position = data[$Currency.symbol_position]
  ..active = data[$Currency.active];

Map<String, dynamic> _$CurrencyToMap(Currency obj, [asJson = false]) =>
    <String, dynamic>{
      $Currency.currency_id: obj.currency_id,
      $Currency.title: obj.title,
      $Currency.symbol: obj.symbol,
      $Currency.symbol_position: obj.symbol_position,
      $Currency.active: obj.active
    };

abstract class $CurrencyData {
  static const String currency_id = 'currency_id';
  static const String currency_history_id = 'currency_history_id';
  static const String rate = 'rate';
}

void _$CurrencyDataFromMap(CurrencyData obj, Map data) => obj
  ..currency_id = data[$CurrencyData.currency_id]
  ..currency_history_id = data[$CurrencyData.currency_history_id]
  ..rate = data[$CurrencyData.rate];

Map<String, dynamic> _$CurrencyDataToMap(CurrencyData obj, [asJson = false]) =>
    <String, dynamic>{
      $CurrencyData.currency_id: obj.currency_id,
      $CurrencyData.currency_history_id: obj.currency_history_id,
      $CurrencyData.rate: obj.rate
    };

abstract class $CurrencyHistory {
  static const String currency_history_id = 'currency_history_id';
  static const String date = 'date';
}

void _$CurrencyHistoryFromMap(CurrencyHistory obj, Map data) => obj
  ..currency_history_id = data[$CurrencyHistory.currency_history_id]
  ..date = data[$CurrencyHistory.date] is String
      ? DateTime.tryParse(data[$CurrencyHistory.date])
      : data[$CurrencyHistory.date];

Map<String, dynamic> _$CurrencyHistoryToMap(CurrencyHistory obj,
        [asJson = false]) =>
    <String, dynamic>{
      $CurrencyHistory.currency_history_id: obj.currency_history_id,
      $CurrencyHistory.date: asJson ? obj.date?.toIso8601String() : obj.date
    };

abstract class $Dictionary {
  static const String dictionary_id = 'dictionary_id';
  static const String name = 'name';
  static const String intl = 'intl';
}

void _$DictionaryFromMap(Dictionary obj, Map data) => obj
  ..dictionary_id = data[$Dictionary.dictionary_id]
  ..name = data[$Dictionary.name]
  ..intl = data[$Dictionary.intl];

Map<String, dynamic> _$DictionaryToMap(Dictionary obj, [asJson = false]) =>
    <String, dynamic>{
      $Dictionary.dictionary_id: obj.dictionary_id,
      $Dictionary.name: obj.name,
      $Dictionary.intl: obj.intl
    };

abstract class $LaboratoryUnit {
  static const String laboratory_unit_id = 'laboratory_unit_id';
  static const String name = 'name';
  static const String system = 'system';
}

void _$LaboratoryUnitFromMap(LaboratoryUnit obj, Map data) => obj
  ..laboratory_unit_id = data[$LaboratoryUnit.laboratory_unit_id]
  ..name = data[$LaboratoryUnit.name]
  ..system = data[$LaboratoryUnit.system];

Map<String, dynamic> _$LaboratoryUnitToMap(LaboratoryUnit obj,
        [asJson = false]) =>
    <String, dynamic>{
      $LaboratoryUnit.laboratory_unit_id: obj.laboratory_unit_id,
      $LaboratoryUnit.name: obj.name,
      $LaboratoryUnit.system: obj.system
    };

abstract class $Language {
  static const String language_id = 'language_id';
  static const String name = 'name';
  static const String code = 'code';
  static const String locale = 'locale';
  static const String active = 'active';
  static const String position = 'position';
}

void _$LanguageFromMap(Language obj, Map data) => obj
  ..language_id = data[$Language.language_id]
  ..name = data[$Language.name]
  ..code = data[$Language.code]
  ..locale = data[$Language.locale]
  ..active = data[$Language.active]
  ..position = data[$Language.position];

Map<String, dynamic> _$LanguageToMap(Language obj, [asJson = false]) =>
    <String, dynamic>{
      $Language.language_id: obj.language_id,
      $Language.name: obj.name,
      $Language.code: obj.code,
      $Language.locale: obj.locale,
      $Language.active: obj.active,
      $Language.position: obj.position
    };

abstract class $PaymentMethod {
  static const String payment_method_id = 'payment_method_id';
  static const String name = 'name';
  static const String intl = 'intl';
  static const String settings = 'settings';
  static const String active = 'active';
}

void _$PaymentMethodFromMap(PaymentMethod obj, Map data) => obj
  ..payment_method_id = data[$PaymentMethod.payment_method_id]
  ..name = data[$PaymentMethod.name]
  ..intl = data[$PaymentMethod.intl]
  ..settings = data[$PaymentMethod.settings]
  ..active = data[$PaymentMethod.active];

Map<String, dynamic> _$PaymentMethodToMap(PaymentMethod obj,
        [asJson = false]) =>
    <String, dynamic>{
      $PaymentMethod.payment_method_id: obj.payment_method_id,
      $PaymentMethod.name: obj.name,
      $PaymentMethod.intl: obj.intl,
      $PaymentMethod.settings: obj.settings,
      $PaymentMethod.active: obj.active
    };

abstract class $Place {
  static const String place_id = 'place_id';
  static const String name = 'name';
  static const String region_code = 'region_code';
  static const String rhif_id = 'rhif_id';
  static const String is_city = 'is_city';
}

void _$PlaceFromMap(Place obj, Map data) => obj
  ..place_id = data[$Place.place_id]
  ..name = data[$Place.name]
  ..region_code = data[$Place.region_code]
  ..rhif_id = data[$Place.rhif_id]
  ..is_city = data[$Place.is_city];

Map<String, dynamic> _$PlaceToMap(Place obj, [asJson = false]) =>
    <String, dynamic>{
      $Place.place_id: obj.place_id,
      $Place.name: obj.name,
      $Place.region_code: obj.region_code,
      $Place.rhif_id: obj.rhif_id,
      $Place.is_city: obj.is_city
    };

abstract class $QuantityUnit {
  static const String quantity_unit_id = 'quantity_unit_id';
  static const String unit = 'unit';
  static const String intl = 'intl';
  static const String value = 'value';
}

void _$QuantityUnitFromMap(QuantityUnit obj, Map data) => obj
  ..quantity_unit_id = data[$QuantityUnit.quantity_unit_id]
  ..unit = data[$QuantityUnit.unit]
  ..intl = data[$QuantityUnit.intl]
  ..value = data[$QuantityUnit.value];

Map<String, dynamic> _$QuantityUnitToMap(QuantityUnit obj, [asJson = false]) =>
    <String, dynamic>{
      $QuantityUnit.quantity_unit_id: obj.quantity_unit_id,
      $QuantityUnit.unit: obj.unit,
      $QuantityUnit.intl: obj.intl,
      $QuantityUnit.value: obj.value
    };

abstract class $Region {
  static const String code = 'code';
  static const String country_id = 'country_id';
  static const String language_id = 'language_id';
  static const String name = 'name';
}

void _$RegionFromMap(Region obj, Map data) => obj
  ..code = data[$Region.code]
  ..country_id = data[$Region.country_id]
  ..language_id = data[$Region.language_id]
  ..name = data[$Region.name];

Map<String, dynamic> _$RegionToMap(Region obj, [asJson = false]) =>
    <String, dynamic>{
      $Region.code: obj.code,
      $Region.country_id: obj.country_id,
      $Region.language_id: obj.language_id,
      $Region.name: obj.name
    };

abstract class $Rhif {
  static const String rhif_id = 'rhif_id';
  static const String region_code = 'region_code';
  static const String code = 'code';
  static const String name = 'name';
}

void _$RhifFromMap(Rhif obj, Map data) => obj
  ..rhif_id = data[$Rhif.rhif_id]
  ..region_code = data[$Rhif.region_code]
  ..code = data[$Rhif.code]
  ..name = data[$Rhif.name];

Map<String, dynamic> _$RhifToMap(Rhif obj, [asJson = false]) =>
    <String, dynamic>{
      $Rhif.rhif_id: obj.rhif_id,
      $Rhif.region_code: obj.region_code,
      $Rhif.code: obj.code,
      $Rhif.name: obj.name
    };

abstract class $TaxClient {
  static const String tax_client_id = 'tax_client_id';
  static const String name = 'name';
}

void _$TaxClientFromMap(TaxClient obj, Map data) => obj
  ..tax_client_id = data[$TaxClient.tax_client_id]
  ..name = data[$TaxClient.name];

Map<String, dynamic> _$TaxClientToMap(TaxClient obj, [asJson = false]) =>
    <String, dynamic>{
      $TaxClient.tax_client_id: obj.tax_client_id,
      $TaxClient.name: obj.name
    };

abstract class $TaxProduct {
  static const String tax_product_id = 'tax_product_id';
  static const String name = 'name';
}

void _$TaxProductFromMap(TaxProduct obj, Map data) => obj
  ..tax_product_id = data[$TaxProduct.tax_product_id]
  ..name = data[$TaxProduct.name];

Map<String, dynamic> _$TaxProductToMap(TaxProduct obj, [asJson = false]) =>
    <String, dynamic>{
      $TaxProduct.tax_product_id: obj.tax_product_id,
      $TaxProduct.name: obj.name
    };

abstract class $TaxRate {
  static const String tax_rate_id = 'tax_rate_id';
  static const String name = 'name';
  static const String intl = 'intl';
  static const String rate = 'rate';
  static const String country_id = 'country_id';
  static const String country_zone_id = 'country_zone_id';
}

void _$TaxRateFromMap(TaxRate obj, Map data) => obj
  ..tax_rate_id = data[$TaxRate.tax_rate_id]
  ..name = data[$TaxRate.name]
  ..intl = data[$TaxRate.intl]
  ..rate = data[$TaxRate.rate]
  ..country_id = data[$TaxRate.country_id]
  ..country_zone_id = data[$TaxRate.country_zone_id];

Map<String, dynamic> _$TaxRateToMap(TaxRate obj, [asJson = false]) =>
    <String, dynamic>{
      $TaxRate.tax_rate_id: obj.tax_rate_id,
      $TaxRate.name: obj.name,
      $TaxRate.intl: obj.intl,
      $TaxRate.rate: obj.rate,
      $TaxRate.country_id: obj.country_id,
      $TaxRate.country_zone_id: obj.country_zone_id
    };

abstract class $TaxRule {
  static const String name = 'name';
  static const String tax_rule_id = 'tax_rule_id';
  static const String tax_client = 'tax_client';
  static const String tax_product = 'tax_product';
  static const String tax_rate = 'tax_rate';
  static const String priority = 'priority';
  static const String position = 'position';
  static const String use_origin_location = 'use_origin_location';
  static const String tax_origin_location = 'tax_origin_location';
  static const String active = 'active';
}

void _$TaxRuleFromMap(TaxRule obj, Map data) => obj
  ..name = data[$TaxRule.name]
  ..tax_rule_id = data[$TaxRule.tax_rule_id]
  ..tax_client = data[$TaxRule.tax_client]
  ..tax_product = data[$TaxRule.tax_product]
  ..tax_rate = data[$TaxRule.tax_rate]
  ..priority = data[$TaxRule.priority]
  ..position = data[$TaxRule.position]
  ..use_origin_location = data[$TaxRule.use_origin_location]
  ..tax_origin_location = data[$TaxRule.tax_origin_location]
  ..active = data[$TaxRule.active];

Map<String, dynamic> _$TaxRuleToMap(TaxRule obj, [asJson = false]) =>
    <String, dynamic>{
      $TaxRule.name: obj.name,
      $TaxRule.tax_rule_id: obj.tax_rule_id,
      $TaxRule.tax_client: obj.tax_client,
      $TaxRule.tax_product: obj.tax_product,
      $TaxRule.tax_rate: obj.tax_rate,
      $TaxRule.priority: obj.priority,
      $TaxRule.position: obj.position,
      $TaxRule.use_origin_location: obj.use_origin_location,
      $TaxRule.tax_origin_location: obj.tax_origin_location,
      $TaxRule.active: obj.active
    };

abstract class $WeightUnit {
  static const String weight_unit_id = 'weight_unit_id';
  static const String unit = 'unit';
  static const String intl = 'intl';
  static const String value = 'value';
}

void _$WeightUnitFromMap(WeightUnit obj, Map data) => obj
  ..weight_unit_id = data[$WeightUnit.weight_unit_id]
  ..unit = data[$WeightUnit.unit]
  ..intl = data[$WeightUnit.intl]
  ..value = data[$WeightUnit.value];

Map<String, dynamic> _$WeightUnitToMap(WeightUnit obj, [asJson = false]) =>
    <String, dynamic>{
      $WeightUnit.weight_unit_id: obj.weight_unit_id,
      $WeightUnit.unit: obj.unit,
      $WeightUnit.intl: obj.intl,
      $WeightUnit.value: obj.value
    };

abstract class $CountryZone {
  static const String country_zone_id = 'country_zone_id';
  static const String country_id = 'country_id';
  static const String name = 'name';
  static const String iso = 'iso';
  static const String geo_lat = 'geo_lat';
  static const String geo_lng = 'geo_lng';
  static const String active = 'active';
}

void _$CountryZoneFromMap(CountryZone obj, Map data) => obj
  ..country_zone_id = data[$CountryZone.country_zone_id]
  ..country_id = data[$CountryZone.country_id]
  ..name = data[$CountryZone.name]
  ..iso = data[$CountryZone.iso]
  ..geo_lat = data[$CountryZone.geo_lat]
  ..geo_lng = data[$CountryZone.geo_lng]
  ..active = data[$CountryZone.active];

Map<String, dynamic> _$CountryZoneToMap(CountryZone obj, [asJson = false]) =>
    <String, dynamic>{
      $CountryZone.country_zone_id: obj.country_zone_id,
      $CountryZone.country_id: obj.country_id,
      $CountryZone.name: obj.name,
      $CountryZone.iso: obj.iso,
      $CountryZone.geo_lat: obj.geo_lat,
      $CountryZone.geo_lng: obj.geo_lng,
      $CountryZone.active: obj.active
    };

abstract class $CountryZoneIntl {
  static const String country_zone_id = 'country_zone_id';
  static const String language_id = 'language_id';
  static const String name = 'name';
}

void _$CountryZoneIntlFromMap(CountryZoneIntl obj, Map data) => obj
  ..country_zone_id = data[$CountryZoneIntl.country_zone_id]
  ..language_id = data[$CountryZoneIntl.language_id]
  ..name = data[$CountryZoneIntl.name];

Map<String, dynamic> _$CountryZoneIntlToMap(CountryZoneIntl obj,
        [asJson = false]) =>
    <String, dynamic>{
      $CountryZoneIntl.country_zone_id: obj.country_zone_id,
      $CountryZoneIntl.language_id: obj.language_id,
      $CountryZoneIntl.name: obj.name
    };
