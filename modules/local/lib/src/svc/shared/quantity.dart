part of local.shared;

class Quantity {
  QuantityService _qs;

  int round = 2;

  num quantity;

  int quantity_unit_id;

  int quantity_unit_base;

  int quantity_unit_alt;

  int quantity_unit_factor;

  Quantity([QuantityService qs]) {
    _qs = qs ?? new QuantityService();
  }

  factory Quantity.fromMap(Map data, [QuantityService qs]) => new Quantity(qs)
    ..quantity = data['quantity']
    ..quantity_unit_id = data['quantity_unit_id']
    ..quantity_unit_base = data['quantity_unit_base']
    ..quantity_unit_alt = data['quantity_unit_alt']
    ..quantity_unit_factor = data['quantity_unit_factor']
    ..round = data['round'] ?? 2;

  Quantity operator +(Quantity qty) => new Quantity(_qs)
    ..quantity = double.parse(
        (quantity + qty.convert(quantity_unit_id).quantity)
            .toStringAsFixed(round))
    ..quantity_unit_id = quantity_unit_id
    ..quantity_unit_base = quantity_unit_base
    ..quantity_unit_alt = quantity_unit_alt
    ..quantity_unit_factor = quantity_unit_factor;

  Quantity operator -(Quantity qty) => new Quantity(_qs)
    ..quantity = double.parse(
        (quantity - qty.convert(quantity_unit_id).quantity)
            .toStringAsFixed(round))
    ..quantity_unit_id = quantity_unit_id
    ..quantity_unit_base = quantity_unit_base
    ..quantity_unit_alt = quantity_unit_alt
    ..quantity_unit_factor = quantity_unit_factor;

  Quantity operator *(num multiplier) => new Quantity(_qs)
    ..quantity = double.parse((quantity * multiplier).toStringAsFixed(round))
    ..quantity_unit_id = quantity_unit_id
    ..quantity_unit_base = quantity_unit_base
    ..quantity_unit_alt = quantity_unit_alt
    ..quantity_unit_factor = quantity_unit_factor;

  Quantity operator /(num delimiter) => new Quantity(_qs)
    ..quantity = double.parse((quantity / delimiter).toStringAsFixed(round))
    ..quantity_unit_id = quantity_unit_id
    ..quantity_unit_base = quantity_unit_base
    ..quantity_unit_alt = quantity_unit_alt
    ..quantity_unit_factor = quantity_unit_factor;

  bool operator >(Quantity q) {
    final qty = double.parse(
        q.convert(quantity_unit_id).quantity.toStringAsFixed(round));
    return quantity > qty;
  }

  bool operator <(Quantity q) {
    final qty = double.parse(
        q.convert(quantity_unit_id).quantity.toStringAsFixed(round));
    return quantity < qty;
  }

  Quantity convert(int unit_id) {
    if (unit_id == quantity_unit_id) return clone();
    if (unit_id == quantity_unit_alt)
      return toAlternativeUnit();
    else
      return normalize();
  }

  Quantity normalize() {
    if (quantity_unit_base == null || quantity_unit_id == quantity_unit_base) {
      return clone();
    } else {
      var q = new Quantity(_qs)
        ..quantity = quantity
        ..quantity_unit_id = quantity_unit_base
        ..quantity_unit_base = quantity_unit_base
        ..quantity_unit_alt = quantity_unit_alt
        ..quantity_unit_factor = quantity_unit_factor;
      return q *= quantity_unit_factor;
    }
  }

  Quantity toAlternativeUnit() {
    if (quantity_unit_alt == null || quantity_unit_id == quantity_unit_alt) {
      return clone();
    } else {
      var q = new Quantity(_qs)
        ..quantity = quantity
        ..quantity_unit_id = quantity_unit_alt
        ..quantity_unit_base = quantity_unit_base
        ..quantity_unit_alt = quantity_unit_alt
        ..quantity_unit_factor = quantity_unit_factor;
      return q /= quantity_unit_factor;
    }
  }

  Quantity clone() => new Quantity(_qs)
    ..round = round
    ..quantity = quantity
    ..quantity_unit_id = quantity_unit_id
    ..quantity_unit_base = quantity_unit_base
    ..quantity_unit_alt = quantity_unit_alt
    ..quantity_unit_factor = quantity_unit_factor;

  int compareTo(Quantity p) {
    if (this < p)
      return -1;
    else if (this > p) return 1;
    return 0;
  }

  bool isIdentical(Quantity q) => quantity_unit_id == q.quantity_unit_id;

  bool isEqual(Quantity p) => isIdentical(p) && quantity == p.quantity;

  String getRepresentation([int curQtyUnit, String locale]) {
    if (quantity_unit_alt != null) {
      Quantity first;
      Quantity second;
      curQtyUnit ??= quantity_unit_id;
      final curQty = quantity;
      if (curQtyUnit == null || curQty == null) return '';

      first = new Quantity(_qs)
        ..quantity = curQty
        ..quantity_unit_id = curQtyUnit;
      if (curQtyUnit == quantity_unit_base) {
        second = new Quantity(new QuantityService())
          ..quantity = curQty
          ..quantity_unit_id = quantity_unit_alt;
        second /= quantity_unit_factor;
      } else if (curQtyUnit == quantity_unit_alt) {
        second = new Quantity(_qs)
          ..quantity = curQty
          ..quantity_unit_id = quantity_unit_base;
        second *= quantity_unit_factor;
      }
      return '${first.toStringSymboledBase(locale)} '
          '(${second.toStringSymboledBase(locale)})';
    }
    return (quantity != null) ? toStringSymboledBase(locale) : '';
  }

  String toStringSymboledBase([String locale]) => _qs.get(
      quantity,
      quantity_unit_id,
      new LanguageService().getLanguageId(locale ?? Intl.defaultLocale));

  Map toMap() => {
        'quantity': quantity,
        'quantity_unit_id': quantity_unit_id,
        'quantity_unit_base': quantity_unit_base,
        'quantity_unit_alt': quantity_unit_alt,
        'quantity_unit_factor': quantity_unit_factor,
        'round': round
      };

  Map toJson() => toMap();

  String toStringSymboled([String locale]) => getRepresentation(null, locale);

  String toString() => toStringSymboled();
}

class QuantityCollection extends ListQueue<Quantity> {
  QuantityCollection();

  QuantityCollection.fromList(List data, [QuantityService qs]) {
    data.forEach((r) => add(new Quantity.fromMap(r, qs)));
  }

  void add(Quantity value) {
    final identical =
        firstWhere((q) => q.isIdentical(value), orElse: () => null);
    if (identical != null)
      identical.quantity = (identical + value).quantity;
    else
      super.add(value.clone());
  }

  void subtract(Quantity quantity) {
    final identical =
        firstWhere((q) => q.isIdentical(quantity), orElse: () => null);
    if (identical != null)
      identical.quantity = (identical - quantity).quantity;
    else
      super.add(quantity.clone()..quantity *= -1);
  }

  QuantityCollection clone() {
    final qc = new QuantityCollection();
    forEach(qc.add);
    return qc;
  }

  Quantity toQuantity([int quantity_unit_id]) {
    var p = new Quantity(new QuantityService())
      ..quantity = 0
      ..quantity_unit_id = quantity_unit_id;
    if (length > 0) {
      p
        ..quantity_unit_base = first.quantity_unit_base
        ..quantity_unit_alt = first.quantity_unit_alt
        ..quantity_unit_factor = first.quantity_unit_factor;
      if (quantity_unit_id == null) p.quantity_unit_id = first.quantity_unit_id;
      forEach((pr) => p += pr);
    }
    return p;
  }

  List<Quantity> getQuantity() {
    final l = <Quantity>[];
    forEach((q) {
      final ex = l.firstWhere((quantity) => quantity.isIdentical(q),
          orElse: () => null);
      if (ex != null)
        ex.quantity = (ex + q).quantity;
      else
        l.add(q.clone());
    });
    return l;
  }

  Iterable toListSymboled([String locale]) =>
      getQuantity().map((q) => q.toStringSymboled(locale));

  List<Map> toMap() => getQuantity().map<Map>((q) => q.toMap()).toList();

  List<Map> toJson() => toMap();
}

class QuantityForm {
  QuantityCollection col;

  QuantityForm(this.col);

  String toHtml([String locale]) =>
      '<table class="total"><tr><td>${col.toListSymboled(locale).join('</td></tr></tr><td>')}</td></tr></table>';
}
