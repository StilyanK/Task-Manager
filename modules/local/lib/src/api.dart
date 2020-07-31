library local.api;

import 'dart:async';

import 'package:cl_annotation/annotation.dart';
import 'package:cl_base/api.dart' as base_api;
import 'package:cl_base/server.dart' as base;
import 'package:epay/epay.dart' as epay;
import 'package:mapper/mapper.dart';
import 'package:paypalsdk/paypal.dart' as paypal;
import 'package:rpc/rpc.dart';

import 'mapper.dart';
import 'shared.dart' as shared;

part 'api/dto/address.dart';
part 'api/dto/currency.dart';
part 'api/dto/language.dart';
part 'api/dto/pair.dart';
part 'api/dto/payment_data.dart';
part 'api.g.dart';

abstract class ApiRequest {
  Future<PaymentDataDTO> getPayment(String name, int language_id);

  Future<Map> makeEpayPayment(PaymentEpayRequest request);

  Future<Map> makePaypalPayment(PaymentPaypalRequest request);

  Future<bool> executePaypalPayment(String payment_id, String payer_id);

  Future<Map> makeBankPayment();

  Future<List> getLanguages();

  Future<List> getCountries(int language_id);

  Future<List> getCountryZones(int country_id, int language_id);

  Future<CurrencyDTO> getCurrency(int currency_id);

  Future<Map> getDictionary(int language_id);
}

class ApiRequestImpl extends ApiRequest {
  ApiRequestImpl();

  Future<List> getLanguages() async =>
      base.dbWrap<List, App>(new App(), (manager) async {
        final ps = await getLanguagesRequest(manager);
        return ps.map((e) => e.toMap()).toList();
      });

  Future<PaymentDataDTO> getPayment(String name, int language_id) async =>
      base.dbWrap<PaymentDataDTO, App>(new App(),
          (manager) async => getPaymentRequest(manager, name, language_id));

  Future<Map> makeEpayPayment(PaymentEpayRequest request) async =>
      base.dbWrap<Map, App>(new App(), (manager) async {
        final ps = await makeEpayPaymentRequest(manager, request);
        return ps;
      });

  Future<Map> makePaypalPayment(PaymentPaypalRequest request) async =>
      base.dbWrap<Map, App>(new App(), (manager) async {
        final ps = await makePaypalPaymentRequest(manager, request);
        return ps;
      });

  Future<bool> executePaypalPayment(String payment_id, String payer_id) async =>
      base.dbWrap<bool, App>(new App(), (manager) async {
        final ps =
            await executePaypalPaymentRequest(manager, payment_id, payer_id);
        return ps;
      });

  Future<Map> makeBankPayment() async =>
      base.dbWrap<Map, App>(new App(), (manager) async {
        final ps = await makeBankPaymentRequest(manager);
        return ps;
      });

  Future<List> getCountries(int language_id) async =>
      base.dbWrap<List, App>(new App(), (manager) async {
        final ps = await getCountriesRequest(manager, language_id);
        return ps.map((p) => p.toMap()).toList();
      });

  Future<List> getCountryZones(int country_id, int language_id) async =>
      base.dbWrap<List, App>(new App(), (manager) async {
        final ps =
            await getCountryZonesRequest(manager, country_id, language_id);
        return ps.map((p) => p.toMap()).toList();
      });

  Future<CurrencyDTO> getCurrency(int currency_id) async =>
      getCurrencyDataRequest(currency_id);

  Future<Map> getDictionary(int language_id) async => base.dbWrap<Map, App>(
      new App(), (manager) async => getDictionaryRequest(manager, language_id));
}

class ApiRequestHttpImpl extends ApiRequest {
  base_api.RestRequest rest;

  ApiRequestHttpImpl(base.APIRemote apir,
      [String host, String scheme = 'https', port = 443]) {
    rest = new base_api.RestRequest(apir, host, scheme, port);
  }

  Future<List> getLanguages() async => rest.get('api/local/v1/languages');

  Future<PaymentDataDTO> getPayment(String name, int language_id) async {
    final ps = await rest.get('api/local/v1/payment_method/$name/$language_id');
    return new PaymentDataDTO.fromMap(ps);
  }

  Future<Map> makeEpayPayment(PaymentEpayRequest request) async =>
      rest.post('api/local/v1/payment/make/epay', request);

  Future<Map> makePaypalPayment(PaymentPaypalRequest request) async =>
      rest.post('api/local/v1/payment/make/paypal', request);

  Future<bool> executePaypalPayment(String payment_id, String payer_id) async =>
      null;

  Future<Map> makeBankPayment() async =>
      rest.get('api/local/v1/payment/make/bank');

  Future<List> getCountries(int language_id) async {
    final ps = await rest.get('api/local/v1/countries/$language_id');
    return ps['countries'];
  }

  Future<List> getCountryZones(int country_id, int language_id) async {
    final ps = await rest.get('api/local/v1/zones/$country_id/$language_id');
    return ps['zones'];
  }

  Future<CurrencyDTO> getCurrency(int currency_id) async {
    final ps = await rest.get('api/local/v1/currency/$currency_id');
    return new CurrencyDTO.fromMap(ps);
  }

  Future<Map> getDictionary(int language_id) async =>
      rest.get('api/local/v1/dictionary/$language_id');
}

@ApiClass(version: 'v1', name: 'local')
class ApiLocal {
  @ApiMethod(path: 'languages', method: 'GET')
  Future<List<LanguageDTO>> languages() async =>
      base_api.restContextDb<List<LanguageDTO>, App>(
          new App(), getLanguagesRequest,
          auth: false);

  @ApiMethod(path: 'payment_method/{name}/{language_id}', method: 'GET')
  Future<PaymentDataDTO> payment(String name, int language_id) async =>
      base_api.restContextDb<PaymentDataDTO, App>(
          new App(), (manager) => getPaymentRequest(manager, name, language_id),
          auth: false);

  @ApiMethod(path: 'payment/make/epay', method: 'POST')
  Future<Map<String, String>> epay(PaymentEpayRequest request) async =>
      base_api.restContextDb<Map<String, String>, App>(
          new App(), (manager) => makeEpayPaymentRequest(manager, request),
          auth: false);

  @ApiMethod(path: 'payment/make/paypal', method: 'POST')
  Future<Map<String, String>> paypal(PaymentPaypalRequest request) async =>
      base_api.restContextDb<Map<String, String>, App>(
          new App(), (manager) => makePaypalPaymentRequest(manager, request),
          auth: false);

  @ApiMethod(path: 'payment/make/bank', method: 'GET')
  Future<Map<String, String>> bank() async =>
      base_api.restContextDb<Map<String, String>, App>(
          new App(), makeBankPaymentRequest,
          auth: false);

  @ApiMethod(path: 'countries/{language_id}', method: 'GET')
  Future<List<PairDTO>> countries(int language_id) async =>
      base_api.restContextDb<List<PairDTO>, App>(
          new App(), (manager) => getCountriesRequest(manager, language_id),
          auth: false);

  @ApiMethod(path: 'zones/{country_id}/{language_id}', method: 'GET')
  Future<List<PairDTO>> zones(int country_id, int language_id) async =>
      base_api.restContextDb<List<PairDTO>, App>(new App(),
          (manager) => getCountryZonesRequest(manager, country_id, language_id),
          auth: false);

  @ApiMethod(path: 'currency/{currency_id}', method: 'GET')
  Future<CurrencyDTO> currency(int currency_id) async =>
      base_api.restContextDb<CurrencyDTO, App>(
          new App(), (manager) => getCurrencyDataRequest(currency_id),
          auth: false);

  @ApiMethod(path: 'dictionary/{language_id}', method: 'GET')
  Future<Map<String, String>> dictionary(int language_id) async =>
      base_api.restContextDb<Map<String, String>, App>(
          new App(), (manager) => getDictionaryRequest(manager, language_id),
          auth: false);
}

class PaymentEpayRequest {
  int id;
  double amount;
  String amount_currency;
  int method;
  String description;
  String url_ok;
  String url_cancel;

  Map toJson() => {
        'id': id,
        'amount': amount,
        'amount_currency_id': amount_currency,
        'method': method,
        'description': description,
        'url_ok': url_ok,
        'url_cancel': url_cancel
      };
}

class PaymentPaypalRequest {
  int id;
  double amount;
  String amount_currency;

  //paypal|credit_card

  String method;

  String number;
  int expire_year;
  int expire_month;
  String type;
  String cvv2;

  String description;
  String url_ok;
  String url_cancel;

  Map toJson() => {
        'id': id,
        'amount': amount,
        'amount_currency_id': amount_currency,
        'method': method,
        'number': number,
        'expire_year': expire_year,
        'expire_month': expire_month,
        'type': type,
        'cvv2': cvv2,
        'description': description,
        'url_ok': url_ok,
        'url_cancel': url_cancel
      };
}

class PaymentStripeRequest {
  int id;
  double amount;
  String amount_currency;

  String number;
  int expire_year;
  int expire_month;
  int cvv2;

  String description;

  Map toJson() => {
        'id': id,
        'amount': amount,
        'amount_currency_id': amount_currency,
        'number': number,
        'expire_year': expire_year,
        'expire_month': expire_month,
        'cvv2': cvv2,
        'description': description
      };
}

/*class PaymentDataDTO {
  int id;
  String key;
  String title;
  toMap() => {'id': id, 'key': key, 'title': title};
  fromMap(Map d) {
    id = d['id'];
    key = d['key'];
    title = d['title'];
  }
}

class LanguageDTO {
  int language_id;
  String name;
  String code;
  String locale;
  bool active;
  toMap() => {
        'language_id': language_id,
        'name': name,
        'code': code,
        'locale': locale,
        'active': active
      };
  fromLanguage(Language lang) {
    language_id = lang.language_id;
    name = lang.name;
    code = lang.code;
    locale = lang.locale;
    active = lang.active;
  }
}

class PairDTO {
  int k;
  String v;
  toMap() => {'k': k, 'v': v};
  fromPair(p) {
    k = p['k'];
    v = p['v'];
  }
}

class CurrencyDTO {
  String currency_symbol;
  int currency_position;
  String currency_code;
  toMap() => {
        'currency_symbol': currency_symbol,
        'currency_position': currency_position,
        'currency_code': currency_code,
      };
  fromMap(Map d) {
    currency_symbol = d['currency_symbol'];
    currency_position = d['currency_position'];
    currency_code = d['currency_code'];
  }

  fromCurrency(Currency c) {
    currency_symbol = c.symbol;
    currency_position = c.symbol_position;
    currency_code = c.title;
  }
}*/

class DictionaryResponse {
  bool success;
  Map<String, String> dictionary;

  Map toMap() => {'success': success, 'dictionary': dictionary};
}

Future<Map<String, String>> makeBankPaymentRequest(Manager<App> manager) async {
  final p = await manager.app.payment_method.findByName('bank_transfer');
  return p.settings;
}

Future<Map<String, String>> makeEpayPaymentRequest(
    Manager<App> manager, PaymentEpayRequest request) async {
  final p = await manager.app.payment_method.findByName('epay');
  dynamic method;
  if (request.method == 1)
    method = epay.Payment.paylogin;
  else if (request.method == 2) method = epay.Payment.credit_paydirect;
  final ep = new epay.Epay(p.settings['min'], p.settings['secret'])
    ..demo_mode = p.settings['demo']
    ..sum = request.amount
    ..currency = request.amount_currency
    ..invoice = request.id.toString()
    ..exp_date = new DateTime.now().add(const Duration(days: 1))
    ..descr = request.description;
  if (method != null) {
    ep.payment_mode = method;
    final form =
        '${ep.form(request.url_ok, request.url_cancel, 'epay_payment')} <script>document.getElementById("epay_payment").submit();</script>';
    return {'redirect': form};
  } else {
    return {'data': await ep.idn()};
  }
}

Future<Map<String, String>> makePaypalPaymentRequest(
    Manager<App> manager, PaymentPaypalRequest request) async {
  final p = await manager.app.payment_method.findByName('paypal');
  final api_context = new paypal.ApiContext(new paypal.OAuthTokenCredential(
      p.settings['client_id'], p.settings['client_secret']))
    ..setConfig({'mode': p.settings['demo'] ? 'sandbox' : 'live'});
  request.method ??= 'paypal';

  final payer = new paypal.Payer()..payment_method = request.method;

  final amount = new paypal.Amount()
    ..currency = request.amount_currency
    ..total = request.amount;

  final transaction = new paypal.Transaction()
    ..invoice_number = request.id.toString()
    ..amount = amount;

  var payment = new paypal.Payment()
    ..intent = 'sale'
    ..payer = payer
    ..transactions = [transaction];

  if (request.method == 'paypal') {
    payment.redirect_urls = new paypal.RedirectUrls()
      ..return_url = request.url_ok
      ..cancel_url = request.url_cancel;

    payment = await payment.create(api_context);

    return {'redirect': payment.getApprovalLink()};
  } else if (request.method == 'credit_card') {
    final cc = new paypal.CreditCard()
      ..number = request.number
      ..expire_year = request.expire_year
      ..expire_month = request.expire_month
      ..type = request.type
      ..cvv2 = request.cvv2;

    final fi = new paypal.FundingInstrument()..credit_card = cc;

    payer.funding_instruments = [fi];

    payment = await payment.create(api_context);

    return {'data': 'paid'};
  }
  return null;
}

Future<bool> executePaypalPaymentRequest(
    Manager<App> manager, String payment_id, String payer_id) async {
  final p = await manager.app.payment_method.findByName('paypal');
  final api_context = new paypal.ApiContext(new paypal.OAuthTokenCredential(
      p.settings['client_id'], p.settings['client_secret']))
    ..setConfig({'mode': p.settings['demo'] ? 'sandbox' : 'live'});
  final exec = new paypal.PaymentExecution()..payer_id = payer_id;
  final payment = new paypal.Payment()..id = payment_id;
  await payment.execute(exec, api_context);
  return true;
}

Future<Map<String, String>> makeStripePaymentRequest(
    Manager<App> manager, PaymentStripeRequest request) async {
//  final p = await manager.app.payment_method.findByName('epay');
//  stripe.StripeService.apiKey = p.settings['demo']
//      ? p.settings['api_key_test']
//      : p.settings['api_key_live'];
//  final st = new stripe.CardCreation()
//    ..number = request.number
//    ..cvc = request.cvv2
//    ..expMonth = request.expire_month
//    ..expYear = request.expire_year;
//  final ch = new stripe.ChargeCreation()
//    ..currency = request.amount_currency
//    ..amount = (request.amount * 100).toInt()
//    ..source = st;
//  await ch.create();
//  return {'data': 'paid'};
}

Future<PaymentDataDTO> getPaymentRequest(
    Manager<App> manager, String name, int language_id) async {
  final payment = await manager.app.payment_method.findByName(name);
  if (payment == null) return null;
  return new PaymentDataDTO()
    ..id = payment.payment_method_id
    ..key = name
    ..title = payment.getTitle(language_id);
}

Future<List<LanguageDTO>> getLanguagesRequest(Manager<App> manager) async {
  final c = await manager.app.language.findAllActive();
  return c.map((e) => new LanguageDTO.fromLanguage(e)).toList();
}

Future<List<PairDTO>> getCountriesRequest(Manager<App> manager,
    [int language_id]) async {
  final c = await manager.app.country.findAllActive();
  if (language_id != null)
    await Future.wait(c.map((country) => country.loadLanguages()));
  return c.pair(language_id).map((p) => new PairDTO.fromMap(p)).toList();
}

Future<List<PairDTO>> getCountryZonesRequest(Manager<App> manager, int id,
    [int language_id]) async {
  final c = await manager.app.countryzone.findAllByCountryId(id);
  if (language_id != null)
    await Future.wait(c.map((zone) => zone.loadLanguages()));
  return c.pair(language_id).map((p) => new PairDTO.fromMap(p)).toList();
}

Future<CurrencyDTO> getCurrencyDataRequest(int currency_id) async {
  final cur = new shared.CurrencyService().getCurrency(currency_id);
  return new CurrencyDTO.fromCurrency(cur.currency);
}

Future<Map<String, String>> getDictionaryRequest(
    Manager<App> manager, int language_id) async {
  final col = await manager.app.dictionary.findAll();
  return col.getMap(language_id);
}
