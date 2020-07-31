// GENERATED CODE - DO NOT MODIFY BY HAND

part of hms_local.api;

// **************************************************************************
// DTOSerializableGenerator
// **************************************************************************

abstract class $AddressDTO {
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
}

AddressDTO _$AddressDTOFromMap(Map data) => new AddressDTO()
  ..street = data[$AddressDTO.street]
  ..residential_complex = data[$AddressDTO.residential_complex]
  ..number = data[$AddressDTO.number]
  ..bloc = data[$AddressDTO.bloc]
  ..entrance = data[$AddressDTO.entrance]
  ..floor = data[$AddressDTO.floor]
  ..apartment = data[$AddressDTO.apartment]
  ..place_id = data[$AddressDTO.place_id]
  ..zip = data[$AddressDTO.zip]
  ..region_id = data[$AddressDTO.region_id]
  ..city = data[$AddressDTO.city]
  ..address = data[$AddressDTO.address]
  ..state = data[$AddressDTO.state]
  ..country_id = data[$AddressDTO.country_id];

Map<String, dynamic> _$AddressDTOToMap(AddressDTO obj) => <String, dynamic>{
      $AddressDTO.street: obj.street,
      $AddressDTO.residential_complex: obj.residential_complex,
      $AddressDTO.number: obj.number,
      $AddressDTO.bloc: obj.bloc,
      $AddressDTO.entrance: obj.entrance,
      $AddressDTO.floor: obj.floor,
      $AddressDTO.apartment: obj.apartment,
      $AddressDTO.place_id: obj.place_id,
      $AddressDTO.zip: obj.zip,
      $AddressDTO.region_id: obj.region_id,
      $AddressDTO.city: obj.city,
      $AddressDTO.address: obj.address,
      $AddressDTO.state: obj.state,
      $AddressDTO.country_id: obj.country_id
    };

abstract class $CurrencyDTO {
  static const String currency_symbol = 'currency_symbol';
  static const String currency_position = 'currency_position';
  static const String currency_code = 'currency_code';
}

CurrencyDTO _$CurrencyDTOFromMap(Map data) => new CurrencyDTO()
  ..currency_symbol = data[$CurrencyDTO.currency_symbol]
  ..currency_position = data[$CurrencyDTO.currency_position]
  ..currency_code = data[$CurrencyDTO.currency_code];

Map<String, dynamic> _$CurrencyDTOToMap(CurrencyDTO obj) => <String, dynamic>{
      $CurrencyDTO.currency_symbol: obj.currency_symbol,
      $CurrencyDTO.currency_position: obj.currency_position,
      $CurrencyDTO.currency_code: obj.currency_code
    };

abstract class $LanguageDTO {
  static const String language_id = 'language_id';
  static const String name = 'name';
  static const String code = 'code';
  static const String locale = 'locale';
  static const String active = 'active';
}

LanguageDTO _$LanguageDTOFromMap(Map data) => new LanguageDTO()
  ..language_id = data[$LanguageDTO.language_id]
  ..name = data[$LanguageDTO.name]
  ..code = data[$LanguageDTO.code]
  ..locale = data[$LanguageDTO.locale]
  ..active = data[$LanguageDTO.active];

Map<String, dynamic> _$LanguageDTOToMap(LanguageDTO obj) => <String, dynamic>{
      $LanguageDTO.language_id: obj.language_id,
      $LanguageDTO.name: obj.name,
      $LanguageDTO.code: obj.code,
      $LanguageDTO.locale: obj.locale,
      $LanguageDTO.active: obj.active
    };

abstract class $PairDTO {
  static const String k = 'k';
  static const String v = 'v';
}

PairDTO _$PairDTOFromMap(Map data) => new PairDTO()
  ..k = data[$PairDTO.k]
  ..v = data[$PairDTO.v];

Map<String, dynamic> _$PairDTOToMap(PairDTO obj) =>
    <String, dynamic>{$PairDTO.k: obj.k, $PairDTO.v: obj.v};

abstract class $PaymentDataDTO {
  static const String id = 'id';
  static const String key = 'key';
  static const String title = 'title';
}

PaymentDataDTO _$PaymentDataDTOFromMap(Map data) => new PaymentDataDTO()
  ..id = data[$PaymentDataDTO.id]
  ..key = data[$PaymentDataDTO.key]
  ..title = data[$PaymentDataDTO.title];

Map<String, dynamic> _$PaymentDataDTOToMap(PaymentDataDTO obj) =>
    <String, dynamic>{
      $PaymentDataDTO.id: obj.id,
      $PaymentDataDTO.key: obj.key,
      $PaymentDataDTO.title: obj.title
    };
