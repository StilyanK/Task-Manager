part of local.shared;

class Mod {
  num mod = 0;
  int mod_type = 0;
  int _currency_id;
  CurrencyService _cur;

  Mod(this.mod, this.mod_type, [this._currency_id, CurrencyService cs]) {
    _cur = cs ?? new CurrencyService();
  }

  factory Mod.fromMap(Map data, [CurrencyService cs]) {
    data ??= {};
    return new Mod(
        data['mod'] ?? 0, data['mod_type'] ?? 0, data['currency_id'], cs);
  }

  Price operator +(Price p) {
    final pr = new Price(p.cs)
      ..price = p.cs.roundPrice(p.price + _calcModification(p))
      ..price_currency_id = p.price_currency_id
      ..round = p.round;
    if (mod_type == 0) _currency_id = p.price_currency_id;
    return pr;
  }

  Price applyTo(Price p) {
    final pr = new Price(p.cs)
      ..price = p.cs.roundPrice(_calcModification(p))
      ..price_currency_id = p.price_currency_id
      ..round = p.round;
    if (mod_type == 0) _currency_id = p.price_currency_id;
    return pr;
  }

  PriceCollection applyToCollection(PriceCollection c) {
    final col = new PriceCollection();
    if (mod_type == 1) {
      c.getPrice().forEach((p) {
        final pr = new Price(p.cs)
          ..price = p.cs.roundPrice(_calcModification(p))
          ..price_currency_id = p.price_currency_id
          ..round = p.round;
        col.add(pr);
      });
    } else {
      final p = c.getPrice().first;
      final pr = new Price(p.cs)
        ..price = p.cs.roundPrice(_calcModification(p))
        ..price_currency_id = p.price_currency_id
        ..round = p.round;
      _currency_id = p.price_currency_id;
      col.add(pr);
    }
    return col;
  }

  num _calcModification(Price p) {
    if (mod != 0) {
      if (mod_type != 0) return p.price * mod / 100;
      return mod;
    }
    return 0;
  }

  void maxToPrice(Price p) {
    if (mod != 0) {
      if (mod_type != 0)
        mod = 100;
      else
        mod = p.price;
    }
  }

  Map toMap() =>
      {'mod': mod, 'mod_type': mod_type, 'currency_id': _currency_id};

  Map toJson() => toMap();

  String toString() {
    final m = (mod.floor() == mod) ? mod.floor() : mod;
    return (mod_type == 1)
        ? '$m%'
        : _cur.addSymbol(_cur.formatPrice(m), _currency_id, '');
  }

  String toStringSymboled(List taxes) {
    final m = (mod.floor() == mod) ? mod.floor() : mod;
    if (mod_type == 1) return '$m%';
    final taxsrv = new TaxService();
    return taxsrv
        .getTaxedPrice(
            new Price(new CurrencyService())
              ..price = m
              ..price_currency_id = _currency_id,
            taxes)
        .toString();
  }
}
