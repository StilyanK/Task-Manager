part of local.gui;

class DiscountButton extends cl_form.DataElement<Map, SpanElement> {
  cl_app.Application ap;
  cl_action.Button button;

  DiscountButton(this.ap) : super() {
    button = new cl_action.Button()
      ..setTitle('%')
      ..addAction((e) => displayMod());
    dom = button.dom;
    onValueChanged.listen((e) {
      final m = getMod();
      if (m.mod == 0) {
        button
          ..setTitle('%')
          ..removeClass('warning');
      } else {
        button
          ..setTitle(m.toString())
          ..addClass('warning');
      }
    });
  }

  Future<String> getRepresentation() async => getMod().toString();

  void setMod(shared.Mod m) => setValue({'mod': m.mod, 'mod_type': m.mod_type});

  shared.Mod getMod() => new shared.Mod.fromMap(getValue());

  bool isValid() => true;

  void setPlaceHolder(String value) {}

  void select() {}

  void focus() => button.focus();

  void blur() => button.blur();

  void disable() {
    button.disable();
  }

  void enable() {
    button.enable();
  }

  void displayMod() {
    final cont = new cl.Container()..addClass('center');
    final apc = new cl_app.Confirmer(ap, cont);
    final input = new InputMod();
    input.inpValue.addAction((e) {
      if (cl_util.KeyValidator.isKeyEnter(e)) apc.okDom.dom.click();
    }, 'keydown');
    input.mod.addAction((e) {
      if (cl_util.KeyValidator.isKeyEnter(e)) apc.okDom.dom.click();
    }, 'keyup');
    if (getValue() != null) input.setMod(getMod());
    cont.append(input);
    apc
      ..title = intl.Discount()
      ..icon = 'percent'
      ..onOk = () {
        setMod(input.getMod());
        return true;
      }
      ..render(width: 270, height: 200);
    input
      ..focus()
      ..select();
  }
}
