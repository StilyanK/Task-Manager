part of local.gui;

class SelectQuantity extends cl_form.Select {
  List first;

  SelectQuantity([this.first]) : super() {
    setFilter();
  }

  dynamic setFilter([List<int> filter]) {
    cleanOptions();
    final col = new shared.QuantityService().getCollection();
    if (filter == null) {
      if (first != null) addOption(first[0], first[1]);
      for (final v in col) {
        addOption(
            v.quantity_unit_id,
            v.getUnit(new shared.LanguageService()
                .getLanguageId(Intl.defaultLocale)));
      }
    } else {
      for (final v in col) {
        if (filter.contains(v.quantity_unit_id) == false) continue;
        addOption(
            v.quantity_unit_id,
            v.getUnit(new shared.LanguageService()
                .getLanguageId(Intl.defaultLocale)));
      }
    }
  }
}
