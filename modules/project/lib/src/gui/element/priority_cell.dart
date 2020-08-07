part of project.gui;

class PriorityCell extends cl_form.RowDataCell<int> {
  PriorityCell(this.ap, grid, row, cell, object)
      : super(grid, row, cell, object);

  cl_app.Application ap;
  List _res;

  void render() {
    final clas = TaskPriority.getPriorityColor(object);
    cell.append(new SpanElement()
      ..classes.add('tag')
      ..classes.add('tag$clas')
      ..text = TaskPriority.getTaskPriorityTitleByID(object));
  }
}
