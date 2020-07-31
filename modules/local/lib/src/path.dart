// ignore_for_file: type_annotate_public_apis, always_declare_return_types
import 'package:communicator/shared.dart';

import 'permission.dart';

const String EVENT_QUANTITY = '${Group.Local}:${Scope.Quantity}:on_change';
const String EVENT_WEIGHT = '${Group.Local}:${Scope.Weight}:on_change';
const String EVENT_CURRENCY = '${Group.Local}:${Scope.Currency}:on_change';
const String EVENT_TAX = '${Group.Local}:${Scope.Tax}:on_change';
const String EVENT_LANGUAGE = '${Group.Local}:${Scope.Language}:on_change';
const String EVENT_PAYMENT = '${Group.Local}:${Scope.Payment}:on_change';
const String EVENT_LAB_UNIT = '${Group.Local}:${Scope.LabUnit}:on_change';

class RoutesAddress {
  static get itemGet => new UrlPattern('r/local/address/item/get');

  static get itemSave => new UrlPattern(r'/local/address/item/save');

  static get itemDelete => new UrlPattern(r'/local/address/item/delete');

  static get collectionGet => new UrlPattern(r'/local/address/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/address/collection/delete');
}

class RoutesLabUnit {
  static get itemGet => new UrlPattern('r/local/lab-unit/item/get');

  static get itemSave => new UrlPattern(r'/local/lab-unit/item/save');

  static get itemDelete => new UrlPattern(r'/local/lab-unit/item/delete');

  static get collectionGet => new UrlPattern(r'/local/lab-unit/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/lab-unit/collection/delete');

  static get collectionPair =>
      new UrlPattern(r'/local/lab-unit/collection/pair');
}

class RoutesCountry {
  static get itemGet => new UrlPattern(r'/local/country/item/get');

  static get itemSave => new UrlPattern(r'/local/country/item/save');

  static get itemDelete => new UrlPattern(r'/local/country/item/delete');

  static get collectionGet => new UrlPattern(r'/local/country/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/country/collection/delete');

  static get collectionPair =>
      new UrlPattern(r'/local/country/collection/pair');

  static get collectionPairCodes =>
      new UrlPattern(r'/local/country/collection/pair_codes');

  static get collectionSuggest =>
      new UrlPattern(r'/local/country/collection/suggest');
}

class RoutesZone {
  static get itemGet => new UrlPattern(r'/local/zone/item/get');

  static get itemSave => new UrlPattern(r'/local/zone/item/save');

  static get itemDelete => new UrlPattern(r'/local/zone/item/delete');

  static get collectionGet => new UrlPattern(r'/local/zone/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/zone/collection/delete');

  static get collectionPair => new UrlPattern(r'/local/zone/collection/pair');
}

class RoutesCurrency {
  static get itemGet => new UrlPattern(r'/local/currency/item/get');

  static get itemSave => new UrlPattern(r'/local/currency/item/save');

  static get itemDelete => new UrlPattern(r'/local/currency/item/delete');

  static get collectionGet => new UrlPattern(r'/local/currency/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/currency/collection/delete');

  static get update => new UrlPattern(r'/local/currency/update');
}

class RoutesDictionary {
  static get itemGet => new UrlPattern(r'/local/dictionary/item/get');

  static get itemSave => new UrlPattern(r'/local/dictionary/item/save');

  static get itemDelete => new UrlPattern(r'/local/dictionary/item/delete');

  static get collectionGet =>
      new UrlPattern(r'/local/dictionary/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/dictionary/collection/delete');

  static get collectionPair =>
      new UrlPattern(r'/local/dictionary/collection/pair');

  static get getTR => new UrlPattern(r'/local/dictionary/get/tr');
}

class RoutesLanguage {
  static get itemGet => new UrlPattern(r'/local/language/item/get');

  static get itemSave => new UrlPattern(r'/local/language/item/save');

  static get itemDelete => new UrlPattern(r'/local/language/item/delete');

  static get collectionGet => new UrlPattern(r'/local/language/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/language/collection/delete');

  static get collectionPair =>
      new UrlPattern(r'/local/language/collection/pair');
}

class RoutesPayment {
  static get itemGet => new UrlPattern(r'/local/payment/item/get');

  static get itemSave => new UrlPattern(r'/local/payment/item/save');

  static get itemDelete => new UrlPattern(r'/local/payment/item/delete');

  static get genPaypalWebHook =>
      new UrlPattern(r'/local/payment/paypal/gen_webhook');

  static get delPaypalWebHook =>
      new UrlPattern(r'/local/payment/paypal/del_webhook');

  static get collectionGet => new UrlPattern(r'/local/payment/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/payment/collection/delete');

  static get collectionPair =>
      new UrlPattern(r'/local/payment/collection/pair');

  static get paymentEpay => new UrlPattern(r'/noauth/local/payment/epay');

  static get paymentPaypal => new UrlPattern(r'/noauth/local/payment/paypal');

  static get paymentStripe => new UrlPattern(r'/noauth/local/payment/stripe');
}

class RoutesQuantity {
  static get itemGet => new UrlPattern(r'/local/quantity/item/get');

  static get itemSave => new UrlPattern(r'/local/quantity/item/save');

  static get itemDelete => new UrlPattern(r'/local/quantity/item/delete');

  static get collectionGet => new UrlPattern(r'/local/quantity/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/quantity/collection/delete');

  static get collectionPair =>
      new UrlPattern(r'/local/quantity/collection/pair');
}

class RoutesTRate {
  static get itemGet => new UrlPattern(r'/local/taxRate/item/get');

  static get itemSave => new UrlPattern(r'/local/taxRate/item/save');

  static get itemDelete => new UrlPattern(r'/local/taxRate/item/delete');

  static get collectionGet => new UrlPattern(r'/local/taxRate/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/taxRate/collection/delete');
}

class RoutesTClient {
  static get itemGet => new UrlPattern(r'/local/taxClient/item/get');

  static get itemSave => new UrlPattern(r'/local/taxClient/item/save');

  static get itemDelete => new UrlPattern(r'/local/taxClient/item/delete');

  static get collectionGet =>
      new UrlPattern(r'/local/taxClient/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/taxClient/collection/delete');
}

class RoutesTProduct {
  static get itemGet => new UrlPattern(r'/local/taxProduct/item/get');

  static get itemSave => new UrlPattern(r'/local/taxProduct/item/save');

  static get itemDelete => new UrlPattern(r'/local/taxProduct/item/delete');

  static get collectionGet =>
      new UrlPattern(r'/local/taxProduct/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/taxProduct/collection/delete');
}

class RoutesTRule {
  static get itemGet => new UrlPattern(r'/local/taxRule/item/get');

  static get itemSave => new UrlPattern(r'/local/taxRule/item/save');

  static get itemDelete => new UrlPattern(r'/local/taxRule/item/delete');

  static get collectionGet => new UrlPattern(r'/local/taxRule/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/taxRule/collection/delete');
}

class RoutesWeight {
  static get itemGet => new UrlPattern(r'/local/weight/item/get');

  static get itemSave => new UrlPattern(r'/local/weight/item/save');

  static get itemDelete => new UrlPattern(r'/local/weight/item/delete');

  static get collectionGet => new UrlPattern(r'/local/weight/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/weight/collection/delete');

  static get collectionPair => new UrlPattern(r'/local/weight/collection/pair');

  static get reload => new UrlPattern(r'/local/weight/reload');
}

class RoutesRhif {
  static get itemGet => new UrlPattern('r/local/rhif/item/get');

  static get itemSave => new UrlPattern(r'/local/rhif/item/save');

  static get itemDelete => new UrlPattern(r'/local/rhif/item/delete');

  static get collectionGet => new UrlPattern(r'/local/rhif/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/rhif/collection/delete');

  static get collectionPairCode =>
      new UrlPattern(r'/local/rhif/collection/pair-code');
}

class RoutesRegion {
  static get itemGet => new UrlPattern('r/local/region/item/get');

  static get itemSave => new UrlPattern(r'/local/region/item/save');

  static get itemDelete => new UrlPattern(r'/local/region/item/delete');

  static get collectionGet => new UrlPattern(r'/local/region/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/region/collection/delete');

  static get collectionPairCode =>
      new UrlPattern(r'/local/region/collection/pair-code');
}

class RoutesPlace {
  static get itemGet => new UrlPattern('r/local/place/item/get');

  static get itemSave => new UrlPattern(r'/local/place/item/save');

  static get itemDelete => new UrlPattern(r'/local/place/item/delete');

  static get collectionGet => new UrlPattern(r'/local/place/collection/get');

  static get collectionDelete =>
      new UrlPattern(r'/local/place/collection/delete');

  static get collectionPair => new UrlPattern(r'/local/place/collection/pair');

  static get collectionSuggest =>
      new UrlPattern(r'/local/place/collection/suggest');
}
