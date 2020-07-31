part of local.gui;

class InputPrice extends cl_form.DataElement<Map, SpanElement> {
  cl_form.Input<num> price;
  SelectCurrency currency;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  bool _nonZero = false;
  int round = 2;

  InputPrice({cl_form.InputTypeDouble type}) : super() {
    price = new cl_form.Input<num>(type ?? new cl_form.InputTypeDouble());
    currency = new SelectCurrency()..setWidth(new cl.Dimension.rem(6));
    onReadyChanged.listen((_) => price.contrReady.add(price));
    price.setSuffixElement(currency);
    dom = price.dom;
    _setListeners();
  }

  void _setListeners() {
    _sub1 = price.onValueChanged.listen((_) => contrValue.add(this));
    _sub2 = currency.onValueChanged.listen((_) => contrValue.add(this));
  }

  void setValue(Map value) {
    _sub1?.cancel();
    _sub2?.cancel();
    super.setValue(value);
    if (value == null) {
      price.setValue(null);
      currency.setValue(null);
    } else {
      price.setValue(value['price']);
      currency.setValue(value['price_currency_id']);
      round = value['round'] ?? round;
    }
    _setListeners();
  }

  void setPrice(shared.Price price) => setValue(price.toJson());

  Future<String> getRepresentation() async =>
      price.getValue() != null ? getPrice().toStringSymboled() : '';

  shared.Price getPrice() => new shared.Price.fromMap(getValue());

  Map getValue() => {
        'price': price.getValue(),
        'price_currency_id': currency.getValue(),
        'round': round
      };

  void setNonZero(bool way) => _nonZero = way;

  bool isReady() {
    if (_nonZero) {
      final v = price.getValue();
      return price.isReady() && v != 0;
    } else
      return price.isReady();
  }

  void setRequired(bool required) => price.setRequired(required);

  void setPlaceHolder(String value) => price.setPlaceHolder(value);

  void select() => price.select();

  void focus() => price.focus();

  void blur() => price.blur();

  void disable() {
    price.disable();
    currency.disable();
  }

  void enable() {
    price.enable();
    currency.enable();
  }

  void addAction<E extends Event>(cl.EventFunction<E> func,
          [String event_space = 'click']) =>
      price.addAction<E>(func, event_space);
}
