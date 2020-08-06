part of project.gui;

class DocumentStamp extends cl_form.Text<Map, SpanElement> {
  int method;

  DocumentStamp(this.method) : super(new SpanElement());

  void setValue(Map value) {
    String methodText;
    if (method == 0) {
      methodText = 'Създаден: ';
    } else if (method == 1) {
      methodText = 'Обновен: ';
    }

    dom.innerHtml = '';
    if (value != null) {
      final by = value['by'];
      dynamic date = value['date'];
      if (date is String && value.isNotEmpty)
        date = DateTime.parse(date);
      if (date is DateTime)
        date = local.Date(date.toLocal()).getWithTime();

      final cont = new cl.CLElement(new DivElement())
        ..append(new SpanElement()..text = methodText)
        ..append(new SpanElement()..text = date)
        ..append(new SpanElement()..text = ' ($by)');
      dom.append(cont.dom);
    }
  }

  void focus() {}

  void blur() {}

  void disable() {}

  void enable() {}
}
