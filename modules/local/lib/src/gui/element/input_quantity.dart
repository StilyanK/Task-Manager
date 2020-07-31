part of local.gui;

class InputQuantity extends cl_form.DataElement<Map, SpanElement> {
  cl_form.Input<num> field;
  SelectQuantity quantity;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  int quantity_unit_base;
  int quantity_unit_alt;
  int quantity_unit_factor;

  InputQuantity() : super() {
    field = new cl_form.Input<num>(new cl_form.InputTypeDouble());
    quantity = new SelectQuantity()..setWidth(new cl.Dimension.rem(6));
    onReadyChanged.listen((_) => field.contrReady.add(field));
    field.setSuffixElement(quantity, true);
    dom = field.dom;
    _setListeners();
    dropDown();
  }

  void dropDown() {
    addAction((e) {
      cl.CLElement doc;
      doc = new cl.CLElement(document.body)
        ..addAction((e) {
          quantity.hideList();
          doc.removeAction('click.select');
        }, 'click.select');
      quantity.showList(this);
    }, 'dblclick');
    field.addAction((e) {
      if (quantity.isListVisible) quantity.navAction(e);
    }, 'keydown.select');
  }

  List<int> setFilter(List<int> filter) => quantity.setFilter(filter);

  void _setListeners() {
    _sub1 = field.onValueChanged.listen((_) => contrValue.add(this));
    _sub2 = quantity.onValueChanged.listen((_) => contrValue.add(this));
  }

  void setValue(Map value) {
    _sub1?.cancel();
    _sub2?.cancel();
    super.setValue(value);
    if (value == null) {
      field.setValue(null);
      quantity.setValue(null);
    } else {
      field.setValue(value['quantity']);
      quantity_unit_base = value['quantity_unit_base'];
      quantity_unit_alt = value['quantity_unit_alt'];
      quantity_unit_factor = value['quantity_unit_factor'];
      final f = <int>[];
      if (value['quantity_unit_base'] != null)
        f.add(value['quantity_unit_base']);
      if (value['quantity_unit_alt'] != null) f.add(value['quantity_unit_alt']);
      if (f.isNotEmpty) setFilter(f);
      quantity.setValue(value['quantity_unit_id']);
    }
    _setListeners();
  }

  void setQuantity(shared.Quantity quantity) => setValue(quantity.toJson());

  shared.Quantity getQuantity() => new shared.Quantity.fromMap(getValue());

  Map getValue() => {
        'quantity': field.getValue(),
        'quantity_unit_id': quantity.getValue(),
        'quantity_unit_base': quantity_unit_base,
        'quantity_unit_alt': quantity_unit_alt,
        'quantity_unit_factor': quantity_unit_factor
      };

  Future<String> getRepresentation() async =>
      getQuantity().getRepresentation(quantity.getValue());

  bool isReady() => field.isReady();

  void setRequired(bool required) => field.setRequired(required);

  void setPlaceHolder(String value) => field.setPlaceHolder(value);

  void select() => field.select();

  void focus() => field.focus();

  void blur() => field.blur();

  void disable() {
    field.disable();
    quantity.disable();
  }

  void enable() {
    field.enable();
    quantity.enable();
  }

  void addAction<E extends Event>(cl.EventFunction<E> func,
          [String event_space = 'click']) =>
      field.addAction<E>(func, event_space);
}
