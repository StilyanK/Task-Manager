part of project.gui;

class TaskStatusCell extends cl_form.RowDataCell<Map> {
  TaskStatusCell(grid, row, cell, object) : super(grid, row, cell, object);

  void render() {
    final parent = new DivElement();
    final status = object[entity.$Task.status];
    if (status == TaskStatus.ToDo) {
      parent.append(new SpanElement()..title = 'To-Do');
    }

    cell
      ..setInnerHtml('')
      ..append(parent);
  }
}
