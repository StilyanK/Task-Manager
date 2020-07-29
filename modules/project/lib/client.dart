import 'package:cl/app.dart' as cl_app;

import 'intl/client.dart' as intl;
import 'path.dart';
import 'src/entity.dart' as e;
import 'src/gui.dart';
import 'src/path.dart';
import 'src/permission.dart';

export 'src/gui.dart';
export 'src/path.dart';
export 'src/permission.dart';

abstract class MenuItem {
  static final cl_app.MenuElement PatientRecord = cl_app.MenuElement()
    ..title = intl.Documents()
    ..icon = Icon.UserMain;


}

void addRoutes(cl_app.Application ap) {
//  ap.addRoute(
//        cl_app.Route(Path.motivation.path, (ap, p) => Motivation(ap, p[0])));
}

void init(cl_app.Application ap) {
  addRoutes(ap);
  ap.setMenu([MenuItem.PatientRecord]);

  ///For doctors
//  ap.serverCall(RoutesDoctor.findByUser.reverse([]), {}).then(
//      (res) => ap.client.data[e.Doctor.$doctor] = res);
//
//  ///For patients
//  ap.serverCall(RoutesPatient.findByUser.reverse([]), {}).then(
//      (res) => ap.client.data[e.Patient.$patient] = res);
}
