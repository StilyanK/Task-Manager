part of hms_local.gui;

class TaxCell extends cl_form.RowDataCell<shared.Tax> {
  static shared.TaxService ts = new shared.TaxService();
  static int language_id =
      new shared.LanguageService().getLanguageId(Intl.defaultLocale);

  TaxCell(grid, row, cell, obj)
      : super(grid, row, cell, new shared.Tax.fromMap(obj));

  void render() {
    final p1 = object.amount.toStringSymboled();
    final p2 =
        ts.getTaxRateById(object.tax_rate_id).toFormattedString(language_id);
    cell.innerHtml = '$p1 [$p2]';
  }
}

class TaxCollectionCell extends cl_form.RowDataCell<shared.TaxCollection> {
  static shared.TaxService ts = new shared.TaxService();
  static int language_id =
      new shared.LanguageService().getLanguageId(Intl.defaultLocale);

  TaxCollectionCell(grid, row, cell, obj)
      : super(grid, row, cell, new shared.TaxCollection.fromList(obj));

  void render() => cell.innerHtml = object.map((o) {
        final part1 = o.amount.toStringSymboled();
        final part2 =
            ts.getTaxRateById(o.tax_rate_id).toFormattedString(language_id);
        return '$part1 [$part2]';
      }).join('\n');
}

class TaxCollectionSumator extends cl_form.Sumator {
  static shared.TaxService ts = new shared.TaxService();
  static int language_id =
      new shared.LanguageService().getLanguageId(Intl.defaultLocale);

  shared.TaxCollection tc = new shared.TaxCollection();

  TaxCollectionSumator(this.tc);

  void add(dynamic object) {
    if (object is shared.TaxCollection) tc += object;
  }

  void nullify() => tc.clear();

  String get total => tc.map((o) {
        final p1 = o.amount.toStringSymboled();
        final p2 =
            ts.getTaxRateById(o.tax_rate_id).toFormattedString(language_id);
        return '$p1 [$p2]';
      }).join('\n');
}
