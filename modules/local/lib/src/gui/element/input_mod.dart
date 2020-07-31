part of hms_local.gui;

class InputMod extends cl_form.DataElement<Map, SpanElement> {
  cl_form.Input inpValue;
  ModSelect mod;
  StreamSubscription _sub1;
  StreamSubscription _sub2;

  InputMod() : super() {
    inpValue = new cl_form.Input(new cl_form.InputTypeDouble());
    mod = new ModSelect()..setWidth(new cl.Dimension.rem(8));
    onReadyChanged.listen((_) => inpValue.contrReady.add(inpValue));
    inpValue.setSuffixElement(mod);
    dom = inpValue.dom;
    _setListeners();
  }

  void _setListeners() {
    _sub1 = inpValue.onValueChanged.listen((_) => contrValue.add(this));
    _sub2 = mod.onValueChanged.listen((_) => contrValue.add(this));
  }

  void setValue(Map value) {
    _sub1?.cancel();
    _sub2?.cancel();
    super.setValue(value);
    if (value == null) {
      inpValue.setValue(null);
      mod.setValue(null);
    } else {
      inpValue.setValue(value['mod']);
      mod.setValue(value['mod_type']);
    }
    _setListeners();
  }

  Future<String> getRepresentation() async => getMod().toString();

  void setMod(shared.Mod m) => setValue({'mod': m.mod, 'mod_type': m.mod_type});

  shared.Mod getMod() => new shared.Mod.fromMap(getValue());

  Map getValue() => {'mod': inpValue.getValue(), 'mod_type': mod.getValue()};

  bool isReady() => inpValue.isReady();

  void setRequired(bool required) => inpValue.setRequired(required);

  void setPlaceHolder(String value) => inpValue.setPlaceHolder(value);

  void select() => inpValue.select();

  void focus() => inpValue.focus();

  void blur() => inpValue.blur();

  void disable() {
    inpValue.disable();
    mod.disable();
  }

  void enable() {
    inpValue.enable();
    mod.enable();
  }
}
