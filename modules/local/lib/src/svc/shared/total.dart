part of hms_local.shared;

class TotalRowUnit {
  Price amount;
  num quantity;
  final Mod discount;
  final int taxProductId;
  final TaxContract taxContract;
  final TaxService ts;
  final List<Tax> taxes = [];
  Price _amountDiscounted;
  Price _amountTax;

  Price get amountUnitTax => _amountTax;

  Price get amountUnitTotal =>
      _amountTax != null ? _amountDiscounted + _amountTax : _amountDiscounted;

  Price get amountSubtotal => amount * quantity;

  Price get amountDiscount => (amount - _amountDiscounted) * quantity;

  Price get amountTax => _amountTax != null ? _amountTax * quantity : null;

  Price get amountTotal => amountUnitTotal * quantity;

  TotalRowUnit(
      {this.amount,
      this.quantity,
      this.discount,
      this.taxProductId,
      this.taxContract,
      TaxService taxService})
      : ts = taxService ?? new TaxService() {
    amount = amount * quantity;
    quantity = 1;
    _calcTax();
  }

  void _calcTax() {
    _amountDiscounted =
        (discount != null) ? amount - discount.applyTo(amount) : amount.clone();
    int current;
    var init_total = _amountDiscounted.clone();
    var comp_total = _amountDiscounted.clone();
    final col = new PriceCollection();
    ts.getAppliedTaxes(taxProductId, taxContract).forEach((tax) {
      current ??= tax.priority;
      if (tax.priority != current) {
        current = tax.priority;
        init_total = comp_total;
      }
      final total = init_total * (tax.rate / 100);
      comp_total += total;
      col.add(total);
      taxes.add(new Tax(ts)
        ..tax_rate_id = tax.tax_rate_id
        ..amount = total * quantity);
    });
    if (col.isNotEmpty) _amountTax = col.toPrice();
  }
}

class Total {
  TaxService ts;

  TaxContract tax_contract;

  List<TotalRowUnit> collection = [];

  Total([this.tax_contract, TaxService taxService]) {
    ts = taxService ?? new TaxService();
  }

  void add({Price amount, num quantity, Mod discount, int taxProductId}) {
    collection.add(new TotalRowUnit(
        amount: amount,
        quantity: quantity,
        discount: discount,
        taxProductId: taxProductId,
        taxService: ts,
        taxContract: tax_contract));
  }

  TaxCollection getTax() {
    final taxes = new TaxCollection();
    collection.forEach((r) => r.taxes.forEach(taxes.add));
    return taxes;
  }

  PriceCollection getSubTotal() {
    final subtotal = new PriceCollection();
    collection.forEach((r) => subtotal.add(r.amountSubtotal));
    return subtotal;
  }

  PriceCollection getDiscount() {
    final discount = new PriceCollection();
    collection.forEach((r) => discount.add(r.amountDiscount));
    return discount;
  }

  PriceCollection getTotal() {
    final total = new PriceCollection();
    collection.forEach((r) => total.add(r.amountTotal));
    return total;
  }

  Map toMap() => {'tax_contract': tax_contract, 'collection': collection};

  Map toJson() => toMap();
}

class Tax {
  TaxService ts;
  int tax_rate_id;
  Price amount;

  Tax([tax_service]) {
    ts = tax_service ?? new TaxService();
  }

  Tax.fromMap(Map data, [CurrencyService cs]) {
    tax_rate_id = data['tax_rate_id'];
    amount = new Price.fromMap(data['amount'], cs);
  }

  String toString() => 'Tax: (tax_rate_id: $tax_rate_id, amount: '
      '${amount.toString()})';

  bool isIdentical(Tax t) {
    if (tax_rate_id == t.tax_rate_id) {
      return true;
    } else {
      return false;
    }
  }

  String taxName([String locale]) {
    final language_id = new LanguageService()
        .getLanguageId(locale == null ? Intl.defaultLocale : locale);
    return ts.getTaxRateById(tax_rate_id).toFormattedString(language_id);
  }

  Tax clone() => new Tax()
    ..tax_rate_id = tax_rate_id
    ..amount = amount.clone();

  Map toJson() => {'tax_rate_id': tax_rate_id, 'amount': amount.toJson()};
}

class TaxCollection extends ListQueue<Tax> {
  TaxCollection();

  TaxCollection.fromList(List data, [CurrencyService cs]) {
    data.forEach((t) => add(new Tax.fromMap(t, cs)));
  }

  void add(Tax value) {
    final identical =
        firstWhere((t) => t.isIdentical(value), orElse: () => null);
    if (identical != null)
      identical.amount += value.amount;
    else
      super.add(value.clone());
  }

  dynamic operator +(TaxCollection tc) {
    final col = clone();
    tc.forEach(col.add);
    return col;
  }

  TaxCollection clone() {
    final tc = new TaxCollection();
    forEach(tc.add);
    return tc;
  }

  List toJson() => toList();
}

class TaxCollectionForm {
  TaxCollection col;

  TaxCollectionForm(this.col);

  String toHtml([dynamic locale]) {
    final language_id = new LanguageService()
        .getLanguageId(locale == null ? Intl.defaultLocale : locale);
    final ts = new TaxService();
    return '<table class="total"><tr><td>${col.map((o) => '${o.amount.toStringSymboled()} [${ts.getTaxRateById(o.tax_rate_id).getName(language_id)}]').join('</td></tr></tr><td>')}</td></tr></table>';
  }
}

class TaxCollectionString {
  TaxCollection col;

  TaxCollectionString(this.col);

  String toString([dynamic locale]) {
    final language_id = new LanguageService()
        .getLanguageId(locale == null ? Intl.defaultLocale : locale);
    final ts = new TaxService();
    return col
        .map((o) => '${o.amount.toStringSymboled()} '
            '[${ts.getTaxRateById(o.tax_rate_id).getName(language_id)}]')
        .join('\n');
  }
}

class TotalForm {
  Total tot;

  TotalForm(this.tot);

  String toHtml([String locale, int currency_id]) {
    final sub = currency_id == null
        ? tot.getSubTotal().toListSymboled().join('<br/ >')
        : tot.getSubTotal().toPrice(currency_id).toStringSymboled();
    final subtotal =
        '<tr><td>${Intl.withLocale(locale, intl.Subtotal)}</td><td>$sub</td></tr>';

    const discount = '';
//    if (tot.discount != null && tot.discount.mod > 0) {
//      final dis = currency_id == null
//          ? tot.getDiscount().toListSymboled().join('<br/ >')
//          : tot.getDiscount().toPrice(currency_id).toStringSymboled();
//      discount =
//          '<tr><td>${Intl.withLocale(locale, intl.Discount)} ${tot.discount.toString()}</td><td>-$dis</td></tr>';
//    }

    new TaxService();
    final tax = tot.getTax().map((t) {
      final tx = currency_id == null
          ? t.amount.toStringSymboled()
          : t.amount.convert(currency_id).toStringSymboled();
      return '<tr><td>${t.taxName(locale)}</td><td>$tx</td></tr>';
    }).join('');

    final t = currency_id == null
        ? tot.getTotal().toListSymboled().join('<br/ >')
        : tot.getTotal().toPrice(currency_id).toStringSymboled();
    final total =
        '<tr><td>${Intl.withLocale(locale, intl.Total)}</td><td>$t</td></tr>';

    return '<table class="total">$subtotal$discount$tax$total</table>';
  }
}

class TotalSimpleForm {
  Total tot;

  TotalSimpleForm(this.tot);

  String toHtml([String locale, int currency_id]) {
    const discount = '';
//    if (tot.discount != null && tot.discount.mod > 0) {
//      final dis = currency_id == null
//          ? tot.getDiscount().toListSymboled().join('<br/ >')
//          : tot.getDiscount().toPrice(currency_id).toStringSymboled();
//      discount = '<tr><td>-$dis</td></tr>';
//    }

    final t = currency_id == null
        ? tot.getTotal().toListSymboled().join('<br/ >')
        : tot.getTotal().toPrice(currency_id).toStringSymboled();
    final total = '<tr><td>$t</td></tr>';

    return '<table class="total">$discount$total</table>';
  }
}
