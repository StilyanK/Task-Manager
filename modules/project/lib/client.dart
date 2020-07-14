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

  static final cl_app.MenuElement DoctorList = cl_app.MenuElement()
    ..title = intl.DoctorList()
    ..icon = Icon.Doctor
    ..scope = '${Group.Document}:${Scope.Doctor}:read'
    ..action = (ap) => ap.run(Path.doctor.list);

  static final cl_app.MenuElement PatientList = cl_app.MenuElement()
    ..title = intl.PatientList()
    ..icon = Icon.Patient
    ..scope = '${Group.Document}:${Scope.Patient}:read'
    ..action = (ap) => ap.run(Path.patient.list);

  static final cl_app.MenuElement PatientRecordList = cl_app.MenuElement()
    ..title = intl.PatientRecordList()
    ..icon = Icon.PatientRecord
    ..scope = '${Group.Document}:${Scope.PatientRecord}:read'
    ..action = (ap) => ap.run(Path.patient_record.list);

  static final cl_app.MenuElement CommissionList = cl_app.MenuElement()
    ..title = intl.CommissionList()
    ..icon = Icon.Commission
    ..scope = '${Group.Document}:${Scope.Commission}:read'
    ..action = (ap) => ap.run(Path.commission.list);

  static final cl_app.MenuElement DiseaseList = cl_app.MenuElement()
    ..title = intl.DiseaseList()
    ..icon = Icon.Disease
    ..scope = '${Group.Document}:${Scope.Disease}:read'
    ..action = (ap) => ap.run(Path.disease.list);
}

void addRoutes(cl_app.Application ap) {
  ap
    ..addRoute(cl_app.Route(Path.doctor.path, (ap, p) => Doctor(ap, p[0])))
    ..addRoute(cl_app.Route(Path.doctor.list, (ap, p) => DoctorList(ap)))
    ..addRoute(cl_app.Route(Path.patient.path, (ap, p) => Patient(ap, p[0])))
    ..addRoute(cl_app.Route(Path.patient.list, (ap, p) => PatientList(ap)))
    ..addRoute(cl_app.Route(Path.disease.path, (ap, p) => Disease(ap, p[0])))
    ..addRoute(cl_app.Route(Path.disease.list, (ap, p) => DiseaseList(ap)))
    ..addRoute(
        cl_app.Route(Path.commission.path, (ap, p) => Commission(ap, p[0])))
    ..addRoute(
        cl_app.Route(Path.commission.list, (ap, p) => CommissionList(ap)))
    ..addRoute(cl_app.Route(
        Path.patient_record.path, (ap, p) => PatientRecord(ap, p[0])))
    ..addRoute(cl_app.Route(
        Path.patient_record.list, (ap, p) => PatientRecordList(ap)))
    ..addRoute(
        cl_app.Route(Path.record_view.path, (ap, p) => RecordView(ap, p[0])))
    ..addRoute(cl_app.Route(
        Path.doc_comments.path, (ap, p) => DocComments(ap, p[0], false)))
    ..addRoute(
        cl_app.Route(Path.motivation.path, (ap, p) => Motivation(ap, p[0])));
}

void init(cl_app.Application ap) {
  addRoutes(ap);
  ap.setMenu([MenuItem.PatientRecord]);

  ///For doctors
  ap.serverCall(RoutesDoctor.findByUser.reverse([]), {}).then(
      (res) => ap.client.data[e.Doctor.$doctor] = res);

  ///For patients
  ap.serverCall(RoutesPatient.findByUser.reverse([]), {}).then(
      (res) => ap.client.data[e.Patient.$patient] = res);
}
