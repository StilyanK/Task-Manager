part of local.gui;

class InputWeight extends cl_form.DataElement<Map, SpanElement> {
  cl_form.Input inpValue;
  SelectWeight weight;
  StreamSubscription _sub1;
  StreamSubscription _sub2;

  InputWeight() : super() {
    inpValue = new cl_form.Input(new cl_form.InputTypeDouble());
    weight = new SelectWeight()..setWidth(new cl.Dimension.rem(6));
    onReadyChanged.listen((_) => inpValue.contrReady.add(inpValue));
    inpValue.setSuffixElement(weight);
    dom = inpValue.dom;
    _setListeners();
  }

  void _setListeners() {
    _sub1 = inpValue.onValueChanged.listen((_) => contrValue.add(this));
    _sub2 = weight.onValueChanged.listen((_) => contrValue.add(this));
  }

  void setValue(Map value) {
    _sub1?.cancel();
    _sub2?.cancel();
    super.setValue(value);
    if (value == null) {
      inpValue.setValue(null);
      weight.setValue(null);
    } else {
      inpValue.setValue(value['weight']);
      weight.setValue(value[entity.$WeightUnit.weight_unit_id]);
    }
    _setListeners();
  }

  void setWeight(shared.Weight weight) => setValue(weight.toJson());

  shared.Weight getWeight() => new shared.Weight.fromMap(getValue());

  Map getValue() => {
        'weight': inpValue.getValue(),
        entity.$WeightUnit.weight_unit_id: weight.getValue()
      };

  bool isReady() => inpValue.isReady();

  void setRequired(bool required) => inpValue.setRequired(required);

  void setPlaceHolder(String value) => inpValue.setPlaceHolder(value);

  void select() => inpValue.select();

  void focus() => inpValue.focus();

  void blur() => inpValue.blur();

  void disable() {
    inpValue.disable();
    weight.disable();
  }

  void enable() {
    inpValue.enable();
    weight.enable();
  }
}
