part of local.gui;

class QuantitySumator extends cl_form.Sumator {
  shared.QuantityCollection qc = new shared.QuantityCollection();

  QuantitySumator();

  void add(dynamic object) {
    if (object is shared.Quantity) qc.add(object);
  }

  void nullify() => qc.clear();

  String get total => qc.toListSymboled().join('');
}

class QuantityAggregator extends cl_form.Aggregator<shared.QuantityCollection> {
  shared.QuantityCollection total = new shared.QuantityCollection();

  QuantityAggregator([cl_form.Selector selector]) : super(selector);

  void add(cl_form.RowDataCell object) {
    if (object.object is shared.Quantity) total.add(object.object);
  }

  void render() {
    dom
      ..innerHtml = ''
      ..append(new SpanElement()..text = total.toListSymboled().join(', '));
  }

  void reset() => total = new shared.QuantityCollection();
}
