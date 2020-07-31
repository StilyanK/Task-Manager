part of local.gui;

class LabUnitEditorCell extends cl_form.RowDataCell<shared.LabUnit> {
  cl.CLElement el;
  cl.CLElement ed;

  LabUnitEditorCell(cl_form.GridColumn column, row, cell, object)
      : super(
            column,
            row,
            cell,
            object != null
                ? (object is shared.LabUnit
                    ? object
                    : new shared.LabUnit.fromMap(object))
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
      ..dom.text = object.toStringSymboled();
    el.dom.append(ed.dom);
  }

  Map<String, dynamic> toJson() => object.toJson();

  void swap(dynamic e) {
    final input = new InputLabUnit()..setLabUnit(object);
    final set1 = (e) {
      object.value = input.getLabUnit().value;
      render();
      column.grid.rowChanged(row);
      column.grid.observer.execHooks(cl_form.GridList.hook_render);
    };
    final set2 = (e) {
      if (cl_util.KeyValidator.isKeyEnter(e)) {
        input.blur();
      } else if (cl_util.KeyValidator.isESC(e)) {
        input
          ..setLabUnit(object)
          ..blur();
      }
    };
    input.inpValue.field..addAction(set2, 'keyup')..addAction(set1, 'blur');
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
