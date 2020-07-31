part of local.gui;

class PaymentMethodList extends Listing {
  UrlPattern contr_get = RoutesPayment.collectionGet;
  UrlPattern contr_del = RoutesPayment.collectionDelete;

  String mode = Listing.MODE_CHOOSE;
  String key = entity.$PaymentMethod.payment_method_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Payment_methods()
    ..height = 700
    ..width = 1000
    ..icon = Icon.PaymentMethod;

  PaymentMethodList(ap) : super(ap);

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn('image')
          ..title = ''
          ..send = false,
        new cl_form.GridColumn('title')
          ..title = intl.Payment_method()
          ..width = '100%'
          ..sortable = true,
        new cl_form.GridColumn(entity.$PaymentMethod.active)
          ..title = intl.Active()
          ..sortable = true
      ];

  void onEdit(dynamic id) {}

  void onCustomEdit(int id, String name) {
    ap.run<PaymentMethodBase>('payment/$name/$id').addHook(ItemBase.save_after,
        (_) {
      getData();
      return true;
    });
  }

  void customRow(dynamic row, Map obj) {
    switch (obj[entity.$PaymentMethod.name]) {
      case 'epay':
        obj[entity.$Currency.title] = 'Epay';
        obj['image'] = new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '100px',
            'height': '50px',
            'background':
                'url(/packages/hms_local/images/epay.svg) no-repeat center center',
            'background-size': 'contain'
          });
        break;
      case 'paypal':
        obj[entity.$Currency.title] = 'Paypal';
        obj['image'] = new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '100px',
            'height': '50px',
            'background':
                'url(/packages/hms_local/images/paypal.svg) no-repeat center center',
            'background-size': '90px auto'
          });
        break;
      case 'stripe':
        obj[entity.$Currency.title] = 'Stripe';
        obj['image'] = new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '100px',
            'height': '50px',
            'background':
                'url(/packages/hms_local/images/stripe.svg) no-repeat center center',
            'background-size': 'contain'
          });
        break;
      case 'bank_transfer':
        obj[entity.$Currency.title] = intl.Bank_transfer();
        obj['image'] = new cl.CLElement(new DivElement())
          ..setStyle({
            'width': '100px',
            'height': '50px',
            'background':
                'url(/packages/hms_local/images/bank.svg) no-repeat center center',
            'background-size': 'contain'
          });
        break;
      case 'in_cash':
        obj[entity.$Currency.title] = intl.In_cash();
        break;
      case 'pay_on_delivery':
        obj[entity.$Currency.title] = intl.Pay_on_delivery();
        break;
    }
    obj[entity.$PaymentMethod.active] = obj[entity.$PaymentMethod.active] != 0
        ? intl.active()
        : intl.unactive();
    obj['edit'] = new cl_action.Button()
      ..setIcon('row-open')
      ..setStyle({'margin': '0px'})
      ..addAction((e) =>
          onCustomEdit(obj[key], obj[entity.$PaymentMethod.name].object));
  }

  void onClick(TableRowElement row) {
    final obj = gridList.grid.rowToMap(row);
    onCustomEdit(obj[key], obj[entity.$PaymentMethod.name]);
  }
}
