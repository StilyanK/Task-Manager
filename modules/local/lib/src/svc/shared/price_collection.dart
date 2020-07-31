part of hms_local.shared;

class PriceCollection extends ListQueue<Price> {
  PriceCollection();

  factory PriceCollection.fromList(List data, [CurrencyService cs]) {
    final col = new PriceCollection();
    data.forEach((p) => col.add((p is Price) ? p : new Price.fromMap(p, cs)));
    return col;
  }

  factory PriceCollection.fromJson(List data, [CurrencyService cs]) =>
      new PriceCollection.fromList(data, cs);

  void add(Price value) {
    final identical =
        firstWhere((pr) => pr.isIdentical(value), orElse: () => null);
    if (identical != null)
      identical.price = (identical + value).price;
    else
      super.add(value.clone());
  }

  void subtract(Price price) {
    final identical =
        firstWhere((pr) => pr.isIdentical(price), orElse: () => null);
    if (identical != null)
      identical.price = (identical - price).price;
    else
      super.add(price.clone()..price *= -1);
  }

  Price toPrice([int currency_id]) {
    var p = new Price(new CurrencyService())
      ..price = 0
      ..price_currency_id = currency_id;
    if (length > 0) {
      if (currency_id == null) p.price_currency_id = first.price_currency_id;
      p.round = first.round;
      forEach((pr) => p += pr);
    }
    return p;
  }

  PriceCollection clone() {
    final pc = new PriceCollection();
    forEach(pc.add);
    return pc;
  }

  List<Price> getPrice() {
    final l = <Price>[];
    forEach((pr) {
      final ex = l.firstWhere(
          (price) => price.price_currency_id == pr.price_currency_id,
          orElse: () => null);
      if (ex != null)
        ex.price = (ex + pr).price;
      else
        l.add(pr.clone());
    });
    return l;
  }

  PriceCollection operator +(PriceCollection pc) {
    final col = clone();
    pc.forEach(col.add);
    return col;
  }

  PriceCollection operator -(PriceCollection pc) {
    final col = clone();
    pc.forEach(col.subtract);
    return col;
  }

  PriceCollection operator *(double multiplier) {
    final col = new PriceCollection();
    forEach((pr) => col.add(pr * multiplier));
    return col;
  }

  Iterable toListSymboled({int round = 2}) =>
      getPrice().map((pr) => (pr..round = round).toStringSymboled());

  String toString() => 'PriceCollection: (${getPrice().join(', ')})';

  List<Map> toMap() => getPrice().map<Map>((p) => p.toMap()).toList();

  List<Map> toJson() => toMap();
}

class PriceCollectionForm {
  PriceCollection col;

  PriceCollectionForm(this.col);

  String toHtml() =>
      '<table class="total"><tr><td>${col.toListSymboled().join('</td></tr></tr><td>')}</td></tr></table>';
}
