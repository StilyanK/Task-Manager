part of project.gui;

class NumberCell extends cl_form.RowDataCell<List> {
  NumberCell(this.ap, grid, row, cell, object) : super(grid, row, cell, object);

  cl_app.Application ap;

  void render() {
    final taskId = object[0];
    final hasChilds = object[1];
    final parTask = object[2];
    if (hasChilds) {
      cell
        ..append(new SpanElement()
          ..text = '$taskId'
          ..append(new cl.Icon(Icon.Parent).dom))
        ..classes.add('task-id');
    } else {
      if(parTask != null) {
        cell.append(new SpanElement()..text = '$taskId -> $parTask');
      } else {
        cell.append(new SpanElement()..text = '$taskId');
      }
    }
  }
}
