part of project.gui;

class DoneDays extends cl_form.RowDataCell<List> {
  DoneDays(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  local.Date dateDoneDate;

  void render() {
    if (object[0] != null) {
      final dateDone = DateTime.parse(object[0]);
      final deadLineDate = DateTime.parse(object[1]);
      dateDoneDate = new local.Date(dateDone);
      int days = deadLineDate.difference(dateDone).inDays;
      String dayFormat = '';
      if (days >= 0) {
        days == 0 ? dayFormat = '$days' : dayFormat = '-$days';
        cell.style.color = '#55e655';
      } else {
        days *= -1;
        dayFormat = '+$days';
        cell.style.color = '#cf4c4c';
      }
      cell
        ..style.whiteSpace = 'nowrap'
        ..text =
            object == null ? '' : '${dateDoneDate.getWithTime()} ($dayFormat)';
    }
  }
}
