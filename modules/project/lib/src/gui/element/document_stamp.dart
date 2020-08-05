part of project.gui;

class DocumentStamp extends cl_form.Text<Map, SpanElement> {
  int method;

  DocumentStamp(this.method) : super(new SpanElement());

  void setValue(Map value) {
    String methodText;
    if (method == 0) {
      methodText = 'Създаден:';
    } else if (method == 1) {
      methodText = 'Модифициран:';
    }

    dom.innerHtml = '';
    if (value != null) {
      final by = value['by'];
      final date = value['date'];

      final cont = new cl.CLElement(new DivElement())
        ..append(new SpanElement()..text = '$methodText')
        ..append(new SpanElement()..text = date)
        ..append(new SpanElement()..text = ', От:')
        ..append(new SpanElement()..text = by);
      dom.append(cont.dom);
    }
  }

  void focus() {}

  void blur() {}

  void disable() {}

  void enable() {}
}
