part of project.gui;

class DocumentStamp extends cl_form.Text<Map, SpanElement> {
  DocumentStamp() : super(new SpanElement());

  void setValue(Map value) {
    dom.innerHtml = '';
    if (value != null) {
      final by = value['by'];
      final date = value['date'];

      final cont = new cl.CLElement(new DivElement())
        ..append(new SpanElement()..text = 'Създаден:')
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


