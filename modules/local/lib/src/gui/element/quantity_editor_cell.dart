part of local.gui;

class QuantityEditorCell extends cl_form.RowDataCell<shared.Quantity> {
  cl.CLElement el;
  cl.CLElement ed;

  QuantityEditorCell(cl_form.GridColumn column, row, cell, object)
      : super(
            column,
            row,
            cell,
            object != null
                ? (object is shared.Quantity
                    ? object
                    : new shared.Quantity.fromMap(object))
                : null) {
    el = new cl.CLElement(this.cell);
    ed = new cl_action.Button()
      ..setIcon(cl.Icon.edit)
      ..addAction(swap, 'click');
    hideEdit();
  }

  void render() {
    el
      ..removeChilds()
      ..addAction(showEdit, 'mouseover')
      ..addAction(hideEdit, 'mouseleave')
      ..dom.text = object.getRepresentation();
    el.dom.append(ed.dom);
  }

  Map<String, String> toJson() => object.toJson();

  void swap(dynamic e) {
    final input = new cl_form.Input(cl_form.InputTypeDouble())
      ..setValue(object.quantity);
    final set1 = (e) {
      object.quantity = input.getValue();
      render();
      column.grid.rowChanged(row);
      column.grid.observer.execHooks(cl_form.GridList.hook_render);
    };
    final set2 = (e) {
      if (cl_util.KeyValidator.isKeyEnter(e)) {
        input.blur();
      } else if (cl_util.KeyValidator.isESC(e)) {
        input
          ..setValue(object.quantity)
          ..blur();
      }
    };
    input.field..addAction(set2, 'keyup')..addAction(set1, 'blur');
    hideEdit();
    el
      ..removeChilds()
      ..removeActionsAll()
      ..append(input);
    input
      ..focus()
      ..select();
  }

  void showEdit(String e) {
    ed.setStyle({'visibility': 'visible'});
  }

  void hideEdit([String e]) {
    ed.setStyle({'visibility': 'hidden'});
  }
}
