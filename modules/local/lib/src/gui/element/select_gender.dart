part of local.gui;

class SelectGender extends cl_form.Select {
  static final List genderOptions = [
    {'v': intl.Male(), 'k': 0},
    {'v': intl.Female(), 'k': 1}
  ];

  SelectGender([first]) : super() {
    if (first != null) {
      addOption(first['k'], first['v']);
    }
    genderOptions.forEach((option) => addOption(option['k'], option['v']));
  }

  static String getTitleByOptionId(int id) =>
      genderOptions.firstWhere((option) => option['k'] == id)['v'];
}
