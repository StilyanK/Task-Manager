part of local.gui;

class PriceSumator extends cl_form.Sumator {
  shared.PriceCollection pc = new shared.PriceCollection();

  PriceSumator();

  void add(dynamic object) {
    if (object is shared.PriceCollection)
      pc += object;
    else if (object is shared.Price) pc.add(object);
  }

  void nullify() {
    pc = new shared.PriceCollection();
  }

  String get total => pc.toListSymboled().join('');
}

class PriceAggregator extends cl_form.Aggregator<shared.PriceCollection> {
  shared.PriceCollection total = new shared.PriceCollection();

  PriceAggregator([cl_form.Selector selector])
      : super(selector ?? new cl_form.Selector(new PriceSumator()));

  void add(cl_form.RowDataCell object) {
    if (object.object is shared.PriceCollection)
      total += object.object;
    else if (object.object is shared.Price) total.add(object.object);
  }

  void render() {
    dom
      ..innerHtml = ''
      ..append(new SpanElement()..text = total.toListSymboled().join(', '));
  }

  void reset() => total = new shared.PriceCollection();
}

class PriceCell extends cl_form.RowDataCell<shared.Price> {
  static int language_id =
      new shared.LanguageService().getLanguageId(Intl.defaultLocale);

  PriceCell(cl_form.GridColumn column, row, cell, obj)
      : super(
            column,
            row,
            cell,
            obj != null
                ? (obj is shared.Price ? obj : new shared.Price.fromMap(obj))
                : null);

  dynamic getValue() => object?.toJson();

  Map toJson() => object?.toJson();

  void render() {
    cell
      ..style.whiteSpace = 'nowrap'
      ..text = object?.toStringSymboled() ?? '';
  }
}

class PriceCollectionCell extends cl_form.RowDataCell<shared.PriceCollection> {
  static shared.CurrencyService cs = new shared.CurrencyService();

  PriceCollectionCell(cl_form.GridColumn column, row, cell, obj)
      : super(
            column,
            row,
            cell,
            obj != null
                ? (obj is shared.PriceCollection
                    ? obj
                    : new shared.PriceCollection.fromList(obj))
                : null);

  dynamic getValue() => object?.toJson();

  List<Map> toJson() => object?.toJson();

  void render() {
    cell
      ..style.whiteSpace = 'nowrap'
      ..text = object?.toListSymboled()?.join(' ') ?? '';
  }
}

class ModSelect extends cl_form.Select {
  ModSelect() {
    addOption(0, intl.fixed());
    addOption(1, intl.percents());
  }
}
