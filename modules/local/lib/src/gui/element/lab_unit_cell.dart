part of local.gui;

class LabUnitCell extends cl_form.RowDataCell<shared.LabUnit> {
  cl_app.Application ap;

  LabUnitCell(cl_form.GridColumn column, row, cell, object, this.ap)
      : super(
            column,
            row,
            cell,
            object != null
                ? (object is shared.LabUnit
                    ? object
                    : new shared.LabUnit.fromMap(object))
                : null);

  dynamic render() {
    cell.innerHtml = (object != null) ? object.toStringSymboled() : '';
  }
}
