part of hms_local.gui;

class PaymentMethodBase extends ItemBuilder {
  UrlPattern contr_get = RoutesPayment.itemGet;
  UrlPattern contr_save = RoutesPayment.itemSave;
  UrlPattern contr_del = RoutesPayment.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = 'Title'
    ..height = 850
    ..width = 1000
    ..icon = Icon.Language;

  String title;

  PaymentMethodBase(ap, this.title, [id]) : super(ap, id);

  void setHooks() {
    super.setHooks();
    addHook(ItemBase.get_after, (_) {
      wapi.setTitle(title);
      return true;
    });
  }

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$PaymentMethod.name).focus();
  }

  void setUI() {}
}

class PaymentCash extends PaymentMethodBase {
  PaymentCash(ap, title, [id]) : super(ap, title, id);

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Active(),
          [new cl_form.Check()..setName(entity.$PaymentMethod.active)])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..disable()
          ..setName(entity.$PaymentMethod.name)
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$PaymentMethod.intl)
      ]);
  }
}

class PaymentDelivery extends PaymentMethodBase {
  PaymentDelivery(ap, title, [id]) : super(ap, title, id);

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow(intl.Active(),
          [new cl_form.Check()..setName(entity.$PaymentMethod.active)])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..disable()
          ..setName(entity.$PaymentMethod.name)
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$PaymentMethod.intl)
      ]);
  }
}

class PaymentBank extends PaymentMethodBase {
  PaymentBank(ap, title, [id]) : super(ap, title, id);

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow('', [
        new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '100px',
            'height': '100px',
            'background': 'url(/packages/hms_local/images/bank.svg) no-repeat',
            'background-size': 'contain'
          })
      ])
      ..addRow(intl.Active(),
          [new cl_form.Check()..setName(entity.$PaymentMethod.active)])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..disable()
          ..setName(entity.$PaymentMethod.name)
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$PaymentMethod.intl)
      ])
      ..addRow(intl.Company(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('firm')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.Address(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('address')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.Bank(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('bank')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.IBAN(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('iban')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.BIC(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('bic')
          ..setContext(entity.$PaymentMethod.settings)
      ]);
  }
}

class PaymentEpay extends PaymentMethodBase {
  PaymentEpay(ap, title, [id]) : super(ap, title, id);

  final _url = '${window.location.href}noauth/local/payment/epay';

  Future<dynamic> setDefaults() async {
    await super.setDefaults();
    form.getElement('url').setValue(_url);
  }

  Future<dynamic> setData() async {
    await super.setData();
    form.getElement('url').setValue(_url);
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow('', [
        new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '120px',
            'height': '100px',
            'background': 'url(/packages/hms_local/images/epay.svg) no-repeat',
            'background-size': 'contain'
          })
      ])
      ..addRow(intl.Active(),
          [new cl_form.Check()..setName(entity.$PaymentMethod.active)])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..disable()
          ..setName(entity.$PaymentMethod.name)
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$PaymentMethod.intl)
      ])
      ..addRow(intl.Demo_mode(), [
        new cl_form.Check('bool')
          ..setName('demo')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.Customer_number(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('min')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.Secret_key(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('secret')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.Notification_URL(), [
        new cl_form.Input()
          ..setName('url')
          ..disable()
          ..stop()
      ]);
  }
}

class PaymentPaypal extends PaymentMethodBase {
  cl_action.Button webhook_sandbox = new cl_action.Button()
    ..setTitle(intl.Generate());
  cl_action.Button webhook_live = new cl_action.Button()
    ..setTitle(intl.Generate());
  cl_action.Button webhook_sandbox_del = new cl_action.Button()
    ..setTitle(intl.Remove());
  cl_action.Button webhook_live_del = new cl_action.Button()
    ..setTitle(intl.Remove());

  final _url = '${window.location.href}noauth/local/payment/paypal';

  PaymentPaypal(ap, title, [id]) : super(ap, title, id);

  Future<dynamic> setDefaults() async {
    await super.setDefaults();
    form.getElement('url_sandbox').setValue(_url);
    form.getElement('url_live').setValue(_url);
  }

  Future<dynamic> setData() async {
    await super.setData();
    form.getElement('url_sandbox').setValue(_url);
    form.getElement('url_live').setValue(_url);
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow('', [
        new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '100px',
            'height': '100px',
            'background': 'url(/packages/hms_local/images/paypal.svg) no-repeat'
          })
      ])
      ..addRow(intl.Active(), [new cl_form.Check()..setName('active')])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..disable()
          ..setName(entity.$PaymentMethod.name)
          ..addClass('max')
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$PaymentMethod.intl)
          ..addClass('max')
      ])
      ..addRow(intl.Test_mode(), [
        new cl_form.Check('bool')
          ..setName('demo')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addSection(intl.REST_API_credentials())
      ..addRow(intl.Client_ID(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('client_id')
          ..setContext(entity.$PaymentMethod.settings)
          ..addClass('max')
      ])
      ..addRow(intl.Client_Secret(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('client_secret')
          ..setContext(entity.$PaymentMethod.settings)
          ..addClass('max')
      ])
      ..addRow(intl.State(), [
        new cl_form.Select()
          ..addOption('paypal', 'Authorization')
          ..addOption('credit_card', 'Credit card')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addSection('Webhooks')
      ..addRow('${intl.Notification_URL()} [sandbox]', [
        new cl_form.Input()
          ..setName('url_sandbox')
          ..disable()
          ..addClass('max')
          ..stop(),
        new cl_form.Input()
          ..setName('webhook_id_sandbox')
          ..disable()
          ..setContext(entity.$PaymentMethod.settings),
        webhook_sandbox..addAction(generateWebHookDemo),
        webhook_sandbox_del..addAction(deleteWebHookDemo),
      ])
      ..addRow('${intl.Notification_URL()} [live]', [
        new cl_form.Input()
          ..setName('url_live')
          ..disable()
          ..addClass('max')
          ..stop(),
        new cl_form.Input()
          ..setName('webhook_id_live')
          ..disable()
          ..setContext(entity.$PaymentMethod.settings),
        webhook_live..addAction(generateWebHookLive),
        webhook_live_del..addAction(deleteWebHookLive),
      ]);
  }

  Future<dynamic> generateWebHookDemo(dynamic e) async {
    final data = await ap.serverCall(
        RoutesPayment.genPaypalWebHook.reverse([]), {'mode': 'sandbox'});
    form
        .getElement('webhook_id_sandbox', entity.$PaymentMethod.settings)
        .setValue(data);
    await save();
  }

  Future<dynamic> generateWebHookLive(dynamic e) async {
    final data = await ap.serverCall(
        RoutesPayment.genPaypalWebHook.reverse([]), {'mode': 'live'});
    form
        .getElement('webhook_id_live', entity.$PaymentMethod.settings)
        .setValue(data);
    await save();
  }

  Future<dynamic> deleteWebHookDemo(dynamic e) async {
    await ap.serverCall(RoutesPayment.delPaypalWebHook.reverse([]), {
      'mode': 'sandbox',
      'id': form
          .getElement('webhook_id_sandbox', entity.$PaymentMethod.settings)
          .getValue()
    });
    form
        .getElement('webhook_id_sandbox', entity.$PaymentMethod.settings)
        .setValue(null);
    await save();
  }

  Future<dynamic> deleteWebHookLive(dynamic e) async {
    await ap.serverCall(RoutesPayment.delPaypalWebHook.reverse([]), {
      'mode': 'live',
      'id': form
          .getElement('webhook_id_live', entity.$PaymentMethod.settings)
          .getValue()
    });
    form
        .getElement('webhook_id_live', entity.$PaymentMethod.settings)
        .setValue(null);
    await save();
  }
}

class PaymentStripe extends PaymentMethodBase {
  PaymentStripe(ap, title, [id]) : super(ap, title, id);

  final _url = '${window.location.href}noauth/local/payment/stripe';

  Future<dynamic> setDefaults() async {
    await super.setDefaults();
    form.getElement('url').setValue(_url);
  }

  Future<dynamic> setData() async {
    await super.setData();
    form.getElement('url').setValue(_url);
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1
      ..addRow('', [
        new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '100px',
            'height': '100px',
            'background':
                'url(/packages/hms_local/images/stripe.svg) no-repeat',
            'background-size': 'contain'
          })
      ])
      ..addRow(intl.Active(),
          [new cl_form.Check()..setName(entity.$PaymentMethod.active)])
      ..addRow(intl.System_name(), [
        new cl_form.Input()
          ..disable()
          ..setName(entity.$PaymentMethod.name)
      ])
      ..addRow(intl.Name(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$PaymentMethod.intl)
      ])
      ..addRow(intl.Demo_mode(), [
        new cl_form.Check('bool')
          ..setName('demo')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow('API key [live mode]', [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('api_key_live')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow('API Key [test mode]', [
        new cl_form.Input()
          ..setRequired(true)
          ..setName('api_key_test')
          ..setContext(entity.$PaymentMethod.settings)
      ])
      ..addRow(intl.Notification_URL(), [
        new cl_form.Input()
          ..setName('url')
          ..disable()
          ..stop()
      ]);
  }
}
