part of hms_local.gui;

class CheckCell extends cl_form.RowFormDataCell<bool> {
  cl_form.Check el;

  CheckCell(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object) {
    el = new cl_form.Check('bool')
      ..setValue(object)
      ..onValueChanged.listen((_) {
        column.grid.rowChanged(row);
      });
  }

  @override
  dynamic getValue() => el.getValue();

  @override
  void setValue(dynamic value) => el.setValue(value);

  void render() {
    cell
      ..setInnerHtml('')
      ..append(el.dom);
  }
}

class CheckCellLabel extends cl_form.RowFormDataCell<List> {
  cl_form.Check el;

  CheckCellLabel(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object) {
    el = new cl_form.Check('bool')
      ..setValue(object.first)
      ..setLabel(object.last)
      ..onValueChanged.listen((_) {
        column.grid.rowChanged(row);
      });
  }

  @override
  dynamic getValue() => el.getValue();

  @override
  void setValue(dynamic value) => el.setValue(value);

  void render() {
    cell
      ..setInnerHtml('')
      ..append(el.dom);
  }
}
