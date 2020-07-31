part of local.gui;

class DateCell extends cl_form.RowDataCell<shared.Date> {
  DateCell(cl_form.GridColumn column, row, cell, object)
      : super(
            column,
            row,
            cell,
            object == null || object.isEmpty
                ? null
                : new shared.Date(DateTime.parse(object)));

  void render() {
    cell
      ..style.whiteSpace = 'nowrap'
      ..text = object == null ? '' : object.get();
  }
}

class DateTimeCell extends cl_form.RowDataCell<shared.Date> {
  DateTimeCell(cl_form.GridColumn column, row, cell, object)
      : super(
            column,
            row,
            cell,
            object == null || object.isEmpty
                ? null
                : new shared.Date(DateTime.parse(object)));

  void render() {
    cell
      ..style.whiteSpace = 'nowrap'
      ..text = object == null ? '' : object.getWithTime();
  }
}

class TimeCell extends cl_form.RowDataCell<num> {
  TimeCell(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  void render() {
    if (object == null) {
      cell.text = '';
      return;
    }
    cell.text = shared.Date.toTimeString(object);
  }
}
