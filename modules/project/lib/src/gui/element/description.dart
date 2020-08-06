part of project.gui;

class TextTemplate extends cl_form.DataElement<String, DivElement>
    with cl_form.Validator {
  cl_app.Application<auth.Client> ap;
  cl.CLElement domInner;
  cl_form.FieldBase fieldElement;
  cl_action.Button butMagnify;
  cl.CLElement counter, top;
  int limit;
  int key;

  bool _magnified = false;
  cl.CLElement _tempCont;

  TextTemplate(this.ap, this.key, {this.limit, this.fieldElement}) : super() {
    if (key == null) {
      throw new Exception('TextTemplate key can not be NULL!');
    }
    dom = new DivElement();
    domInner = new cl.CLElement(new DivElement())
      ..addClass('ui-text-template');
    butMagnify = new cl_action.Button()
      ..setTip('Увеличи', 'top')
      ..setIcon(cl.Icon.fullscreen)
      ..addAction((e) => magnify());
    counter = new cl.CLElement(new DivElement())..addClass('counter');

    if (fieldElement is cl_form.Editor) {
      (fieldElement as cl_form.Editor)
          .menu
          .add(butMagnify..setStyle({'margin-left': 'auto'}));
      top = (fieldElement as cl_form.Editor).menu.container;
    } else {
      fieldElement ??= new cl_form.TextArea()
        ..field.dom.setAttribute('maxlength', limit.toString())
        ..addAction(_count, 'keyup');
      top = new cl.CLElement(new DivElement())
        ..addClass('top')
        ..append(butMagnify)
        ..append(counter..setStyle({'margin-left': 'auto'}))
        ..appendTo(domInner);
    }

    domInner.append(fieldElement);
    append(domInner);
    fieldElement.onValueChanged.listen((_) => contrValue.add(this));
    onReadyChanged.listen((_) => fieldElement.contrReady.add(fieldElement));
  }

  void addClass(String clas) {
    super.addClass(clas);
    fieldElement.addClass(clas);
  }

  void removeClass(String clas) {
    super.removeClass(clas);
    fieldElement.removeClass(clas);
  }

  void _count([e]) {
    final l = fieldElement.getValue()?.length ?? 0;
    counter.setText('${l.toString()}/${limit ?? '∞'}');
  }

  void magnify() {
    if (_magnified) {
      ap.enableApp();
      _tempCont.remove();
      setStyle({'width': null, 'height': null});
      fieldElement.setStyle({'width': null, 'height': null});
      append(domInner);
      _magnified = false;
      fieldElement.focus();
    } else {
      ap.disableApp();
      setWidth(new cl.Dimension.px(getWidth()));
      setHeight(new cl.Dimension.px(getHeight()));
      fieldElement
        ..setWidth(new cl.Dimension.px(600))
        ..setHeight(new cl.Dimension.px(600));
      _tempCont = new cl.CLElement(new DivElement())
        ..append(domInner)
        ..addClass('ui-text-template')
        ..addClass('magnify');
      new cl.CLElement(document.body).append(_tempCont);
      _tempCont.setStyle(_initPosition(_tempCont));
      _magnified = true;
      _tempCont.addClass('scale');
      fieldElement.focus();
    }
  }

  Map<String, String> _initPosition(cl.CLElement cont) {
    final box =
        cl_util.centerRect(cont.getRectangle(), ap.desktop.getRectangle());
    box
      ..top = box.top + document.body.scrollTop
      ..left = box.left + document.body.scrollLeft;
    return {'top': '${box.top}px', 'left': '${box.left}px'};
  }

  void setValue(String value) {
    fieldElement.setValue(value);
    _count();
  }

  String getValue() => fieldElement.getValue();

  Future<String> getRepresentation() async => getValue();

  bool isReady() => fieldElement.isReady();

  void setRequired(bool required) => fieldElement.setRequired(required);

  void setPlaceHolder(String value) => fieldElement.setPlaceHolder(value);

  void select() => fieldElement.select();

  void focus() => fieldElement.focus();

  void blur() => fieldElement.blur();

  void disable() {
    fieldElement.disable();
    butMagnify.disable();
  }

  void enable() {
    fieldElement.enable();
    butMagnify.enable();
  }

  void addAction<E extends Event>(cl.EventFunction<E> func,
          [String event_space = 'click']) =>
      fieldElement.addAction<E>(func, event_space);
}
