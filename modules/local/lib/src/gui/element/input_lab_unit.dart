part of hms_local.gui;

class InputLabUnit extends cl_form.DataElement<Map, SpanElement> {
  cl_form.Input inpValue;
  StreamSubscription _sub1;

  InputLabUnit() : super() {
    inpValue = new cl_form.Input();
    onReadyChanged.listen((_) => inpValue.contrReady.add(inpValue));
    dom = inpValue.dom;
    _setListeners();
  }

  void _setListeners() {
    _sub1 = inpValue.onValueChanged.listen((_) => contrValue.add(this));
  }

  void setValue(Map value) {
    _sub1?.cancel();
    super.setValue(value);
    if (value == null) {
      inpValue
        ..setValue(null)
        ..setSuffix(null);
    } else {
      inpValue
        ..setValue(value[entity.$QuantityUnit.value])
        ..setSuffix(new shared.LabUnitService()
            .getSymbol(value[entity.$LaboratoryUnit.laboratory_unit_id]));
    }
    _setListeners();
  }

  void setLabUnit(shared.LabUnit labUnit) => setValue(labUnit.toJson());

  Future<String> getRepresentation() async => getLabUnit().toStringSymboled();

  shared.LabUnit getLabUnit() => new shared.LabUnit.fromMap(getValue());

  Map getValue() => {
        entity.$QuantityUnit.value: inpValue.getValue(),
        entity.$LaboratoryUnit.laboratory_unit_id:
            super.getValue()[entity.$LaboratoryUnit.laboratory_unit_id]
      };

  bool isReady() => inpValue.isReady();

  void setRequired(bool required) => inpValue.setRequired(required);

  void setPlaceHolder(String value) => inpValue.setPlaceHolder(value);

  void select() => inpValue.select();

  void focus() => inpValue.focus();

  void blur() => inpValue.blur();

  void disable() => inpValue.disable();

  void enable() => inpValue.enable();

  void addAction<E extends Event>(cl.EventFunction<E> func,
          [String event_space = 'click']) =>
      inpValue.addAction<E>(func, event_space);
}
