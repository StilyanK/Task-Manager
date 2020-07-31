part of local.gui;

class SelectYear extends cl_form.Select {
  SelectYear() : super() {
    final d = new DateTime.now();
    addOption(d.year, d.year);
    addOption(d.year - 1, d.year - 1);
  }
}


class SelectYearWide extends cl_form.Select {
  SelectYearWide() : super() {
    addOption(null, '');
    final d = new DateTime.now();
    final last = d.year - 100;
    for (var i = d.year; i > last; i--)
      addOption(i, i);
  }
}

