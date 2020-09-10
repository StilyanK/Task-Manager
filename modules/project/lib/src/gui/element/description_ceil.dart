part of project.gui;

class DescriptionCeil extends cl_form.RowDataCell<List> {
  DescriptionCeil(grid, row, cell, object) : super(grid, row, cell, object);

  void render() {
    final sp = new SpanElement()
      ..text = getShortText(object.first, 50)
      ..style.display = 'block'
      ..style.fontWeight = 'bold';
    final sp2 = new SpanElement()
      ..text = getShortText(removeHtmlTags(object.last), 100)
      ..style.display = 'block';
    cell..append(sp)..append(sp2);
    cell.style.maxWidth = '300px';
    if (object != null && object.isNotEmpty) {
      final c = new cl.CLElement(cell);
      final d = new cl_app.BubbleVisualizer(
          c,
          () => new DivElement()
            ..setInnerHtml('<b>${object.first}</b><div>${object.last}</div>'));
      c.removeAction('mouseout');
    }
  }
}
