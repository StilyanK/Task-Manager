part of hms_local.gui;

class SelectMonth extends cl_form.Select {
  SelectMonth() : super() {
    final d = new DateFormat();
    for (var i = 0; i < d.dateSymbols.MONTHS.length; i++)
      addOption(i + 1, d.dateSymbols.MONTHS[i]);
  }
}
