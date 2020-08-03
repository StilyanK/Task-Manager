part of project.gui;

class TaskStatusCell extends cl_form.RowDataCell {
  TaskStatusCell(grid, row, cell, object) : super(grid, row, cell, object);

  void render() {
    final text = new SpanElement();
    if (object != null) {
      final status = TaskStatus.getTaskTitleByID(object);
      text.title = status;
    }
    cell.append(text);
  }
}
