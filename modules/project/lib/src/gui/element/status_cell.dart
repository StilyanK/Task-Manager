part of project.gui;

class StatusCell extends cl_form.RowDataCell<List> {
  StatusCell(this.ap, grid, row, cell, object) : super(grid, row, cell, object);

  cl_app.Application ap;

  void render() {
    final status = object[0];
    final percent = object[1];
    if (status == TaskStatus.InProgress) {
      final clas = TaskStatus.getStatusColor(status);
      cell.append(new SpanElement()
        ..classes.add('tag')
        ..classes.add('tag$clas')
        ..text = '${TaskStatus.getTaskTitleByID(status)} $percent%');
    } else {
      final clas = TaskStatus.getStatusColor(status);
      cell.append(new SpanElement()
        ..classes.add('tag')
        ..classes.add('tag$clas')
        ..text = TaskStatus.getTaskTitleByID(status));
    }
  }
}
