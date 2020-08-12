part of project.gui;

class DoneDays extends cl_form.RowDataCell<List> {
  DoneDays(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  local.Date dateDoneDate;

  void render() {
    if (object[0] != null) {
      final dateDoneField = new SpanElement();
      final dateDone = DateTime.parse(object[0]);
      final deadLineDate = DateTime.parse(object[1]);
      dateDoneDate = new local.Date(dateDone);
      int days = deadLineDate.difference(dateDone).inDays;
      String dayFormat = '';
      if (days >= 0) {
        final dayMinus = new SpanElement()
          ..style.fontWeight = 'bold'
          ..style.color = '#379E36';
        days == 0 ? dayFormat = '$days' : dayFormat = '-$days';
        buildCell(cell, dayMinus, dateDoneField, dayFormat);
      } else {
        final daysPlus = new SpanElement()
          ..style.fontWeight = 'bold'
          ..style.color = '#c34545';
        days *= -1;
        dayFormat = '+$days';
        buildCell(cell, daysPlus, dateDoneField, dayFormat);
      }
    }
  }

  void buildCell(
      TableCellElement cell, SpanElement sp, SpanElement sp2, String days) {
    sp.text = ' $days';
    sp2
      ..style.whiteSpace = 'nowrap'
      ..text = '${dateDoneDate.get()}';
    cell.append(sp2..append(sp));
  }
}
