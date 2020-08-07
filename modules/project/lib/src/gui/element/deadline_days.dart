part of project.gui;

class DateAndRemainingDays extends local.DateTimeCell {
  DateAndRemainingDays(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  void render() {
    print(object);
    cell
      ..style.whiteSpace = 'nowrap'
      ..text = object == null ? '' : object.getWithTime() ;
  }
}
