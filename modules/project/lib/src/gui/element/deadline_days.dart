part of project.gui;

class DateAndRemainingDays extends cl_form.RowDataCell<List> {
  DateAndRemainingDays(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  local.Date deadLine;

  void render() {
    final dateCreated = DateTime.parse(object[0]);
    final deadLineDate = DateTime.parse(object[1]);
    deadLine = new local.Date(deadLineDate);
    final days = deadLineDate.difference(dateCreated).inDays;
    cell
      ..style.whiteSpace = 'nowrap'
      ..text = object == null ? '' : '${deadLine.getWithTime()} ($days)';
  }
}
