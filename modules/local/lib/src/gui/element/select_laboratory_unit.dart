part of hms_local.gui;

class SelectLabUnit extends cl_form.Select {
  String unitSystem = 'Conventional';

  SelectLabUnit([first]) : super() {
    if (first is List && first.length == 2) addOption(first[0], first[1]);
    final u = new shared.LabUnitService();
    u.getCollection().forEach((v) {
      if (unitSystem != null) {
        if (v.system == unitSystem) {
          addOption(v.laboratory_unit_id, v.name);
        }
      } else {
        addOption(v.laboratory_unit_id, v.name);
      }
    });
  }
}
