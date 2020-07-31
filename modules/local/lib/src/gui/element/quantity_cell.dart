part of local.gui;

class QuantityCell extends cl_form.RowDataCell<shared.Quantity> {
  QuantityCell(cl_form.GridColumn column, row, cell, object)
      : super(
            column,
            row,
            cell,
            object != null
                ? (object is shared.Quantity
                    ? object
                    : new shared.Quantity.fromMap(object))
                : null);

  void render() {
    cell
      ..style.whiteSpace = 'nowrap'
      ..innerHtml = (object != null) ? object.getRepresentation() : '';
  }

  dynamic getValue() => object.toJson();

  Map<String, String> toJson() => object.toJson();
}
