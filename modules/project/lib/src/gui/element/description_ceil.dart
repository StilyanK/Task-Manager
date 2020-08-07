part of project.gui;

class DescriptionCeil extends cl_form.RowDataCell<String> {
  DescriptionCeil(this.ap, grid, row, cell, object)
      : super(grid, row, cell, object);

  cl_app.Application ap;

  void render() {
    print(object);
    cell.append(new SpanElement()..text = object.substring(0, 10));

    new cl_app.BubbleVisualizer(new cl.CLElement(cell), () async {
      final c = new DivElement()..text = object;
      return c;
    });
  }
}
