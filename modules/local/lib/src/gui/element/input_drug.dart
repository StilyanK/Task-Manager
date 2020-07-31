part of hms_local.gui;

class InputDrug extends cl_form.DataElement<Map, SpanElement> {
  cl_form.Input field;
  cl_form.Select quantity;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  shared.DrugConvert drugConvert;
  cl_action.Warning warning;

  InputDrug([cl_form.InputTypeDouble type]) : super() {
    field = new cl_form.Input(type);
    quantity = new cl_form.Select()..setWidth(new cl.Dimension.rem(6));
    onReadyChanged.listen((_) => field.contrReady.add(field));
    field.setSuffixElement(quantity, true);
    dom = field.dom;
    _setListeners();
    dropDown();

    warning = new cl_action.Warning(this);
  }

  void setType([cl_form.InputTypeDouble type]) => field.setType(type);

  void dropDown() {
    addAction((e) {
      cl.CLElement doc;
      doc = new cl.CLElement(document.body)
        ..addAction((e) {
          quantity.hideList();
          doc.removeAction('click.select');
        }, 'click.select');
      quantity.showList(this);
    }, 'dblclick');
    field.addAction((e) {
      if (quantity.isListVisible) quantity.navAction(e);
    }, 'keydown.select');
  }

  void _setListeners() {
    _sub1 = field.onValueChanged.listen((_) => contrValue.add(this));
    _sub2 = quantity.onValueChanged.listen((_) => contrValue.add(this));
  }

  /// Map {
  ///    'as_quantity': 100,
  ///    'as_unit': 'IU',
  ///    'as_total': '300:IU/3:ml';
  ///  }
  void setValue(Map value) {
    _sub1?.cancel();
    _sub2?.cancel();
    super.setValue(value);
    if (value == null) {
      field.setValue(null);
      quantity.setValue(null);
      drugConvert = null;
    } else {
      field.setValue(value['as_quantity']);
      drugConvert = new shared.DrugConvert(value['as_total'],
          quantity_unit_id: value['quantity_unit_id'],
          quantity_unit_alt: value['quantity_unit_alt'],
          quantity_unit_base: value['quantity_unit_base'],
          quantity_unit_factor: value['quantity_unit_factor']);
      final options = drugConvert
          .getUnitsPair()
          .map((u) => {'k': u['k'], 'v': u['v']})
          .toList();
      quantity
        ..setOptions(options)
        ..setValue(value['as_unit']);
    }
    _setListeners();
  }

  @override
  bool compareValue(Map value) {
    final oldValue = getValue();
    if (oldValue != null && value != null) {
      return oldValue.keys.any((k) => oldValue[k] != value[k]);
    }
    return !(oldValue == null && value == null);
  }

  void setDrugConvert(shared.DrugConvert dc) => setValue(dc.toMap());

  shared.DrugConvert getDrugConvert() => drugConvert == null
      ? null
      : (drugConvert
        ..set(new shared.DrugUnit(field.getValue(), quantity.getValue())));

  Map getValue() => {
        'as_quantity': field?.getValue(),
        'as_unit': quantity?.getValue(),
        'as_total': drugConvert?.data,
        'quantity_unit_id': drugConvert?.quantity_unit_id,
        'quantity_unit_alt': drugConvert?.quantity_unit_alt,
        'quantity_unit_base': drugConvert?.quantity_unit_base,
        'quantity_unit_factor': drugConvert?.quantity_unit_factor
      };

  Future<String> getRepresentation() async {
    if (drugConvert == null) return '';
    drugConvert.set(new shared.DrugUnit(field.getValue(), quantity.getValue()));
    return drugConvert.getDescription();
  }

  shared.Quantity getQuantity() {
    if (drugConvert == null) return null;
    drugConvert.set(new shared.DrugUnit(field.getValue(), quantity.getValue()));
    return drugConvert.getProductQuantity();
  }

  bool isReady() => field.isReady();

  void setRequired(bool required) => field.setRequired(required);

  void setPlaceHolder(String value) => field.setPlaceHolder(value);

  void select() => field.select();

  void focus() => field.focus();

  void blur() => field.blur();

  void disable() {
    field.disable();
    quantity.disable();
  }

  void enable() {
    field.enable();
    quantity.enable();
  }

  void setWarning(cl.DataWarning wrn, {bool show = true}) {
    if (wrn == null) return;
    super.setWarning(wrn);
    warning.init(getWarnings(), showAuto: show);
  }

  void showWarnings([Duration duration]) {
    warning.show();
  }

  void removeWarning(String wrnKey) {
    if (wrnKey == null) return;
    if (getWarnings().every((w) => w.key != wrnKey)) return;
    super.removeWarning(wrnKey);
    warning.remove();
  }

  void removeWarnings() {
    super.removeWarnings();
    warning.remove();
  }

  void addAction<E extends Event>(cl.EventFunction<E> func,
          [String event_space = 'click']) =>
      field.addAction<E>(func, event_space);
}
