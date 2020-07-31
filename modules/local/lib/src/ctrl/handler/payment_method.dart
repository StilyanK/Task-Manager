part of hms_local.ctrl;

class IPayment extends base.Item<App, PaymentMethod, int> {
  final String group = Group.Local;

  final String scope = Scope.Payment;

  IPayment(req) : super(req, new App());

  Future<Map> doGet(dynamic id) async {
    final payment = await manager.app.payment_method.find(id);
    if (payment == null) throw new base.ResourceNotFoundException();
    final js = payment.toJson();
    if (payment.settings != null) js.addAll(payment.settings);
    return js;
  }

  Future<int> doSave(dynamic id, Map data) async {
    final payment = await manager.app.payment_method.prepare(id, data);
    await manager.commit();
    return payment.payment_method_id;
  }

  Future<bool> doDelete(dynamic id) async => null;

  Future<dynamic> generatePaypalWebhook() =>
      run(group, scope, 'create', () async {
        final data = await getData();
        manager = await new Database().init(new App());
        final p = await manager.app.payment_method.findByName('paypal');
        final api_context = new paypal.ApiContext(
            new paypal.OAuthTokenCredential(
                p.settings['client_id'], p.settings['client_secret']))
          ..setConfig({'mode': data['mode']});
        final wh = new paypal.Webhook()
          ..url =
              'https://${base.meta.host}/centryl/noauth/local/payment/paypal'
          ..event_types = [
            new paypal.WebhookEventType()..name = 'PAYMENT.SALE.PENDING'
          ];
        final w = await wh.create(api_context);
        return response(w.id);
      });

  Future<bool> deletePaypalWebhook() => run(group, scope, 'create', () async {
        final data = await getData();
        manager = await new Database().init(new App());
        final p = await manager.app.payment_method.findByName('paypal');
        final api_context = new paypal.ApiContext(
            new paypal.OAuthTokenCredential(
                p.settings['client_id'], p.settings['client_secret']))
          ..setConfig({'mode': data['mode']});
        final wh = new paypal.Webhook()
          ..id = data['id']
          ..event_types = [
            new paypal.WebhookEventType()..name = 'PAYMENT.SALE.PENDING'
          ];
        await wh.delete(api_context);
        return response(true);
      });

  Future<void> paymentEpay() async {
    final data = await getData();
    manager = await new Database().init(new App());
    if (data['encoded'] == null || data['checksum'] == null)
      return responseHtml('', HttpStatus.forbidden);
    final payment = await manager.app.payment_method.findByName('epay');
    final resp = new epay.EpayResponse(payment.settings['secret'], data);
    if (!resp.decode()) return responseHtml('ERR=Not valid CHECKSUM\n');
    resp.readMessage();
    entityPaymentMethod.contr_status.add(
        {'id': resp.invoice, 'date': resp.pay_date, 'status': resp.status});
    return responseHtml('INVOICE=${resp.invoice}:STATUS=OK\n');
  }

  Future<void> paymentPaypal() async {
    final data = await getData();
    // paypal.WebhookEvent webhook = new paypal.WebhookEvent().fromMap(data);
    manager = await new Database().init(new App());
    final p = await manager.app.payment_method.findByName('paypal');
    final api_context = new paypal.ApiContext(new paypal.OAuthTokenCredential(
        p.settings['client_id'], p.settings['client_secret']))
      ..setConfig({'mode': p.settings['demo'] ? 'sandbox' : 'live'});
    if (data != null && data['resource']['parent_payment'] != null) {
      final payment = await new paypal.Payment()
          .get(data['resource']['parent_payment'], api_context);
      entityPaymentMethod.contr_status.add({
        'id': payment.transactions.first.invoice_number,
        'date': payment.update_time,
        'status': payment.state
      });
    }
    return responseHtml('OK');
  }

  Future paymentStripe() async => responseHtml('OK');
//    final data = await getData();
//    final p = await manager.app.payment_method.findByName('stripe');
//    stripe.StripeService.apiKey = p.settings['demo']
//        ? p.settings['api_key_test']
//        : p.settings['api_key_live'];
//    final event = await stripe.Event.retrieve(data['id']);
//    if (event.type == 'charge.succeeded') {
//      entityPaymentMethod.contr_status.add({
//        //'id': id,
//        'date': event.data.object['date'],
//        'status': true
//      });
//    }
//    return responseHtml('OK');
//  }
}
