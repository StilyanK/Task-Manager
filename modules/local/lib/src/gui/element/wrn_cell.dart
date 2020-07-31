part of local.gui;

class WrnEditorCell extends cl_form.RowEditCell {
  final Map<String, String> _warning = {};

  WrnEditorCell(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  Future render() async {
    await super.render();
    if (_warning.isNotEmpty) {
      final icon = new cl.Icon(cl.Icon.warning).dom;
      final _bubble = new cl_app.Bubble(new cl.CLElement(icon))
        ..setHtml(_warning.values.join('\n'));
      new cl.CLElement(cell)
        ..removeAction('mouseover.bubble')
        ..removeAction('mouseout.bubble')
        ..addAction((e) => _bubble.showBubble(), 'mouseover.bubble')
        ..addAction((e) => _bubble.hideBubble(), 'mouseout.bubble')
        ..addClass('warning')
        ..append(icon);
    } else
      cell.classes.remove('warning');
    //cell.append(new SpanElement()..text = cell.title);
  }

  void setWarning(String key, String value) {
    _warning[key] = value;
    render();
  }

  void removeWarning(String key) {
    _warning.remove(key);
    render();
  }

  void clearWarnings() {
    _warning.clear();
    render();
  }
}

class WrnFormCell extends cl_form.RowFormDataCell {
  final Map<String, String> _warning = {};

  WrnFormCell(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  Future render() async {
    super.render();
    if (_warning.isNotEmpty) {
      final icon = new cl.Icon(cl.Icon.warning).dom;
      final _bubble =
          new cl_app.Bubble(new cl.CLElement(icon))
            ..setHtml(_warning.values.join('\n'));
      new cl.CLElement(cell..classes.add('warning'))
        ..removeAction('mouseover.bubble')
        ..removeAction('mouseout.bubble')
        ..addAction((e) => _bubble.showBubble(), 'mouseover.bubble')
        ..addAction((e) => _bubble.hideBubble(), 'mouseout.bubble')
        ..append(icon);
    } else
      cell.classes.remove('warning');
    //cell.append(new SpanElement()..text = cell.title);
  }

  void setWarning(String key, String value) {
    _warning[key] = value;
    render();
  }

  void removeWarning(String key) {
    _warning.remove(key);
    render();
  }

  void clearWarnings() {
    _warning.clear();
    render();
  }
}

class WrnDataCell extends cl_form.RowDataCell {
  final Map<String, String> _warning = {};

  WrnDataCell(cl_form.GridColumn column, row, cell, object)
      : super(column, row, cell, object);

  Future render() async {
    super.render();
    if (_warning.isNotEmpty) {
      final icon = new cl.Icon(cl.Icon.warning).dom;
      final _bubble = new cl_app.Bubble(new cl.CLElement(icon))
        ..setHtml(_warning.values.join('\n'));
      new cl.CLElement(cell)
        ..removeAction('mouseover.bubble')
        ..removeAction('mouseout.bubble')
        ..addAction((e) => _bubble.showBubble(), 'mouseover.bubble')
        ..addAction((e) => _bubble.hideBubble(), 'mouseout.bubble')
        ..addClass('warning')
        ..append(icon);
    } else
      cell.classes.remove('warning');
    //cell.append(new SpanElement()..text = cell.title);
  }

  void setWarning(String key, String value) {
    _warning[key] = value;
    render();
  }

  void removeWarning(String key) {
    _warning.remove(key);
    render();
  }

  void clearWarnings() {
    _warning.clear();
    render();
  }
}
