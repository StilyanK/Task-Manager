part of hms_local.shared;

class Price {
  CurrencyService _cur;

  num price;
  int price_currency_id;
  int round = 2;

  Price([CurrencyService cs]) {
    _cur = cs ?? new CurrencyService();
  }

  factory Price.fromMap(Map data, [CurrencyService cs]) => new Price(cs)
    ..price = data['price'] ?? 0
    ..price_currency_id = data['price_currency_id']
    ..round = data['round'] ?? 2;

  CurrencyService get cs => _cur;

  Price operator +(Price p) {
    final pr = new Price(_cur)
      ..price = _cur.roundPrice(
          price +
              _cur.convert(p.price, p.price_currency_id,
                  currency_id_to: price_currency_id, round: round),
          round: round)
      ..price_currency_id = price_currency_id
      ..round = round;
    return pr;
  }

  Price operator -(Price p) {
    final pr = new Price(_cur)
      ..price = _cur.roundPrice(
          price -
              _cur.convert(p.price, p.price_currency_id,
                  currency_id_to: price_currency_id, round: round),
          round: round)
      ..price_currency_id = price_currency_id
      ..round = round;
    return pr;
  }

  Price operator *(num multiplier) {
    final pr = new Price(_cur)
      ..price = _cur.roundPrice(price * multiplier, round: round)
      ..price_currency_id = price_currency_id
      ..round = round;
    return pr;
  }

  Price operator /(num delimiter) {
    final pr = new Price(_cur)
      ..price = _cur.roundPrice(price / delimiter, round: round)
      ..price_currency_id = price_currency_id
      ..round = round;
    return pr;
  }

  bool operator >(Price p) {
    final pr = _cur.roundPrice(
        _cur.convert(p.price, p.price_currency_id,
            currency_id_to: price_currency_id, round: round),
        round: round);
    return price > pr;
  }

  bool operator <(Price p) {
    final pr = _cur.roundPrice(
        _cur.convert(p.price, p.price_currency_id,
            currency_id_to: price_currency_id, round: round),
        round: round);
    return price < pr;
  }

  int compareTo(Price p) {
    if (this < p)
      return -1;
    else if (this > p) return 1;
    return 0;
  }

  Price convert(int currency_id) {
    final pr = new Price(_cur)
      ..price = _cur.roundPrice(
          _cur.convert(price, price_currency_id,
              currency_id_to: currency_id, round: round),
          round: round)
      ..price_currency_id = currency_id
      ..round = round;
    return pr;
  }

  Price rounding() => new Price(_cur)
    ..price = _cur.roundPrice(price, round: round)
    ..price_currency_id = price_currency_id
    ..round = round;

  Price clone() => new Price(_cur)
    ..price = price
    ..price_currency_id = price_currency_id
    ..round = round;

  bool isIdentical(Price p) => price_currency_id == p.price_currency_id;

  bool isEqual(Price p) => isIdentical(p) && price == p.price;

  Map toMap() =>
      {'price': price, 'price_currency_id': price_currency_id, 'round': round};

  Map toJson() => toMap();

  String toString() => toStringSymboled();

  String toStringFormatted() => _cur.formatPrice(price, round: round);

  String toStringSymboled() =>
      _cur.addSymbol(toStringFormatted(), price_currency_id);
}
