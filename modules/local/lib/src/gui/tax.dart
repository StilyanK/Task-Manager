part of local.gui;

class TaxRate extends ItemBuilder {
  UrlPattern contr_get = RoutesTRate.itemGet;
  UrlPattern contr_save = RoutesTRate.itemSave;
  UrlPattern contr_del = RoutesTRate.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax_rate_title
    ..height = 600
    ..width = 600
    ..icon = Icon.TaxRate;

  TaxRate(ap, [id]) : super(ap, id);

  Future<dynamic> setDefaults() async {
    form.getElement(entity.$TaxClient.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    final country = new SelectCountry(ap, [null, ''])
      ..setRequired(true)
      ..setName(entity.$Address.country_id);
    final zone = new SelectZones(ap, [null, intl.All()])
      ..dependOn(country)
      ..setName(entity.$TaxRate.country_zone_id);
    t1
      ..addRow(intl.Name(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$TaxClient.name)
      ])
      ..addRow(intl.Languages(), [
        new cl_form.LangInput(ap.client.data['language'])
          ..setName(entity.$TaxRate.intl)
      ])
      ..addRow(intl.Country(), [country..load()])
      ..addRow(intl.Zone(), [zone])
      ..addRow(intl.Value(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setSuffix('%')
          ..setName('rate')
      ]);
  }
}

class TaxRateList extends Listing {
  UrlPattern contr_get = RoutesTRate.collectionGet;
  UrlPattern contr_del = RoutesTRate.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$TaxRate.tax_rate_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax()
    ..height = 500
    ..width = 1000
    ..icon = Icon.TaxRate;

  TaxRateList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_tax_rate())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$TaxRate.name)
          ..title = intl.Name()
          ..filter = (new cl_form.Input()..setName(entity.$TaxRate.name))
          ..sortable = true,
        new cl_form.GridColumn(entity.$TaxRate.rate)
          ..title = intl.Value()
          ..sortable = true
      ];

  void onEdit(dynamic id) =>
      ap.run<TaxRate>('tax_rate/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });
}

class TaxClient extends ItemBuilder {
  UrlPattern contr_get = RoutesTClient.itemGet;
  UrlPattern contr_save = RoutesTClient.itemSave;
  UrlPattern contr_del = RoutesTClient.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax_client_title
    ..height = 300
    ..width = 500
    ..icon = Icon.TaxClient;

  TaxClient(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {
    form.getElement(entity.$TaxClient.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1.addRow(intl.Name(), [
      new cl_form.Input()
        ..setRequired(true)
        ..setName(entity.$TaxClient.name)
    ]);
  }
}

class TaxClientList extends Listing {
  UrlPattern contr_get = RoutesTClient.collectionGet;
  UrlPattern contr_del = RoutesTClient.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$TaxClient.tax_client_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax_client_class()
    ..height = 500
    ..width = 1000
    ..icon = Icon.TaxClient;

  TaxClientList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_tax_client())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$TaxClient.name)
          ..title = intl.Name()
          ..filter = (new cl_form.Input()..setName(entity.$TaxClient.name))
          ..sortable = true
      ];

  void onEdit(dynamic id) =>
      ap.run<TaxClient>('tax_client/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });
}

class TaxProduct extends ItemBuilder {
  UrlPattern contr_get = RoutesTProduct.itemGet;
  UrlPattern contr_save = RoutesTProduct.itemSave;
  UrlPattern contr_del = RoutesTProduct.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax_client_class()
    ..height = 300
    ..width = 500
    ..icon = Icon.TaxProduct;

  TaxProduct(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {
    form.getElement(entity.$TaxProduct.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    t1.addRow(intl.Name(), [
      new cl_form.Input()
        ..setRequired(true)
        ..setName(entity.$TaxProduct.name)
    ]);
  }
}

class TaxProductList extends Listing {
  UrlPattern contr_get = RoutesTProduct.collectionGet;
  UrlPattern contr_del = RoutesTProduct.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$TaxProduct.tax_product_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax_product_class()
    ..height = 500
    ..width = 1000
    ..icon = Icon.TaxProduct;

  TaxProductList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_tax_product())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$TaxProduct.name)
          ..title = intl.Name()
          ..filter = (new cl_form.Input()..setName(entity.$TaxProduct.name))
          ..sortable = true
      ];

  void onEdit(dynamic id) =>
      ap.run<TaxProduct>('tax_product/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });
}

class TaxRule extends ItemBuilder {
  UrlPattern contr_get = RoutesTRule.itemGet;
  UrlPattern contr_save = RoutesTRule.itemSave;
  UrlPattern contr_del = RoutesTRule.itemDelete;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax_rule_title
    ..height = 650
    ..width = 800
    ..icon = Icon.TaxRule;

  TaxRule(ap, [id]) : super(ap, id);

  Future<void> setDefaults() async {
    form.getElement(entity.$TaxRule.active).setValue(1);
    form.getElement(entity.$TaxRule.name).focus();
  }

  void setUI() {
    final t1 = new cl_gui.FormElement(form);
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);

    final form1 = new cl_form.Form()..setName(entity.$TaxRule.tax_client);
    final form2 = new cl_form.Form()..setName(entity.$TaxRule.tax_product);
    final form3 = new cl_form.Form()..setName(entity.$TaxRule.tax_rate);
    form..add(form1)..add(form2)..add(form3);
    final grd = new cl_gui.FormElement(form1);
    final grd2 = new cl_gui.FormElement(form2);
    final grd3 = new cl_gui.FormElement(form3);

    t1
      ..addRow(intl.Active(),
          [new cl_form.Check('bool')..setName(entity.$TaxRule.active)])
      ..addRow(intl.Name(), [
        new cl_form.Input()
          ..setRequired(true)
          ..setName(entity.$TaxRule.name)
          ..addClass('max')
      ])
      ..addRow(intl.Tax_client_class(), [grd])
      ..addRow(intl.Tax_product_class(), [grd2])
      ..addRow(intl.Tax_rate(), [grd3])
      ..addRow(intl.Base_on_my_location(), [
        new cl_form.Check('bool')..setName(entity.$TaxRule.use_origin_location)
      ])
      ..addRow(intl.Tax_origin_location(), [
        new cl_form.Check('bool')..setName(entity.$TaxRule.tax_origin_location)
      ])
      ..addRow(intl.Priority(), [
        new cl_form.Input(new cl_form.InputTypeInt())
          ..setName(entity.$TaxRule.priority)
          ..addClass('s')
      ])
      ..addRow(intl.Position(), [
        new cl_form.Input(new cl_form.InputTypeInt())
          ..setName(entity.$TaxRule.position)
          ..addClass('s')
      ]);

    new shared.TaxService().getTaxClientCollection().forEach((t) {
      grd.addRow(null, [
        new cl_form.Check('bool')
          ..setName(t.tax_client_id.toString())
          ..setLabel(t.name)
      ]);
    });

    new shared.TaxService().getTaxProductCollection().forEach((t) {
      grd2.addRow(null, [
        new cl_form.Check('bool')
          ..setName(t.tax_product_id.toString())
          ..setLabel(t.name)
      ]);
    });

    new shared.TaxService().getTaxRateCollection().forEach((t) {
      grd3.addRow(null, [
        new cl_form.Check('bool')
          ..setName(t.tax_rate_id.toString())
          ..setLabel(t.name)
      ]);
    });
  }
}

class TaxRuleList extends Listing {
  UrlPattern contr_get = RoutesTRule.collectionGet;
  UrlPattern contr_del = RoutesTRule.collectionDelete;

  String mode = Listing.MODE_LIST;
  String key = entity.$TaxRule.tax_rule_id;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Tax_rule()
    ..icon = Icon.TaxRule;

  TaxRuleList(ap) : super(ap) {
    menu.add(new cl_action.Button()
      ..setStyle({'margin-left': 'auto'})
      ..setTitle(intl.Add_tax_rule())
      ..setIcon(cl.Icon.add)
      ..addClass('important')
      ..addAction((e) => onEdit(0)));
  }

  List<String> initOrder() => [entity.$TaxRule.position, 'ASC'];

  List<cl_form.GridColumn> initHeader() => [
        new cl_form.GridColumn(entity.$TaxRule.name)
          ..title = intl.Name()
          ..filter = (new cl_form.Input()..setName(entity.$TaxRule.name))
          ..sortable = true,
        new cl_form.GridColumn('tax_clients')..title = intl.Tax_client_class(),
        new cl_form.GridColumn('tax_products')
          ..title = intl.Tax_product_class(),
        new cl_form.GridColumn('tax_rates')..title = intl.Tax_rate(),
        new cl_form.GridColumn(entity.$TaxRule.priority)
          ..title = intl.Priority()
          ..sortable = true,
        new cl_form.GridColumn(entity.$TaxRule.active)
          ..title = intl.Active()
          ..sortable = true
          ..filter = (new cl_form.Select()
            ..setName(entity.$TaxRule.active)
            ..addOption(null, intl.All())
            ..addOption(true, intl.Active())
            ..addOption(false, intl.Unactive()))
      ];

  void onEdit(dynamic id) =>
      ap.run<TaxRule>('tax_rule/$id').addHook(ItemBase.change_after, (_) {
        getData();
        return true;
      });

  void customRow(dynamic row, Map obj) {
    if (obj['tax_clients'] is List) {
      final cont = new cl.CLElement(new DivElement());
      obj['tax_clients'].forEach((r) {
        cont.append(new cl.CLElement(new ParagraphElement())..setText(r));
      });
      obj['tax_clients'] = cont;
    }
    if (obj['tax_products'] is List) {
      final cont = new cl.CLElement(new DivElement());
      obj['tax_products'].forEach((r) {
        cont.append(new cl.CLElement(new ParagraphElement())..setText(r));
      });
      obj['tax_products'] = cont;
    }
    if (obj['tax_rates'] is List) {
      final cont = new cl.CLElement(new DivElement());
      obj['tax_rates'].forEach((r) {
        cont.append(new cl.CLElement(new ParagraphElement())..setText(r));
      });
      obj['tax_rates'] = cont;
    }
    obj[entity.$TaxRule.active] =
        obj[entity.$TaxRule.active] ? intl.active() : intl.unactive();
  }
}
