import 'dart:async';

//import 'package:mapper/mapper.dart';
import 'package:cl_base/server.dart' as base;

//import 'intl/server.dart' as intl;

import 'src/ctrl.dart';

//import 'src/mapper.dart';
import 'src/path.dart';
import 'src/permission.dart';

export 'src/ctrl.dart';
export 'src/mapper.dart';
export 'src/path.dart';


void registerPermissions() {
  base.permissionRegisterStandardPack(Group.Document, Scope.Doctor);
  base.permissionRegister(Group.Document, Scope.Doctor,
      [base.$RunRights.read], true);
  base.permissionRegisterStandardPack(Group.Document, Scope.Patient);
  base.permissionRegister(Group.Document, Scope.Patient,
      [base.$RunRights.read], true);
  base.permissionRegisterStandardPack(Group.Document, Scope.PatientRecord);
  base.permissionRegister(Group.Document, Scope.PatientRecord,
      [base.$RunRights.read], true);

  ///Extra rights needed for doctors and etc
  base.permissionRegister(Group.Document, Scope.PatientRecord,
      [
        Right.document_check,
        Right.file_comment,
        Right.commission_check,
        Right.make_decision,
        Right.see_all
      ], false);

  base.permissionRegisterStandardPack(Group.Document, Scope.Commission);
  base.permissionRegister(Group.Document, Scope.Commission,
      [base.$RunRights.read], true);
  base.permissionRegisterStandardPack(Group.Document, Scope.Disease);
  base.permissionRegister(Group.Document, Scope.Disease,
      [base.$RunRights.read], true);
}

void addRoutes() {
  base.routes.add((router) =>
  router
    ..serve(RoutesDoctor.itemGet, method: 'WS')
        .listen((req) => IDoctor(req).get())
    ..serve(RoutesDoctor.itemSave, method: 'WS')
        .listen((req) => IDoctor(req).save())
    ..serve(RoutesDoctor.itemDelete, method: 'WS')
        .listen((req) => IDoctor(req).delete())
    ..serve(RoutesDoctor.collectionGet, method: 'WS')
        .listen((req) => CDoctor(req).get())
    ..serve(RoutesDoctor.collectionDelete, method: 'WS')
        .listen((req) => CDoctor(req).delete())
    ..serve(RoutesDoctor.collectionSuggest, method: 'WS')
        .listen((req) => CDoctor(req).suggest())
    ..serve(RoutesDoctor.findByUser, method: 'WS')
        .listen((req) => IDoctor(req).findByUser())

    ..serve(RoutesPatient.itemGet, method: 'WS')
        .listen((req) => IPatient(req).get())
    ..serve(RoutesPatient.itemSave, method: 'WS')
        .listen((req) => IPatient(req).save())
    ..serve(RoutesPatient.itemDelete, method: 'WS')
        .listen((req) => IPatient(req).delete())
    ..serve(RoutesPatient.findByUser, method: 'WS')
        .listen((req) => IPatient(req).findByUser())
    ..serve(RoutesPatient.collectionGet, method: 'WS')
        .listen((req) => CPatient(req).get())
    ..serve(RoutesPatient.collectionDelete, method: 'WS')
        .listen((req) => CPatient(req).delete())
    ..serve(RoutesPatient.collectionSuggest, method: 'WS')
        .listen((req) => CPatient(req).suggest())

    ..serve(RoutesPatientRecord.itemGet, method: 'WS')
        .listen((req) => IPatientRecord(req).get())
    ..serve(RoutesPatientRecord.itemSave, method: 'WS')
        .listen((req) => IPatientRecord(req).save())
    ..serve(RoutesPatientRecord.itemDelete, method: 'WS')
        .listen((req) => IPatientRecord(req).delete())
    ..serve(RoutesPatientRecord.sendApproval, method: 'WS')
        .listen((req) => IPatientRecord(req).sendApproval())
    ..serve(RoutesDocComment.collectionSave, method: 'WS')
        .listen((req) => IPatientRecord(req).saveDocComments())
    ..serve(RoutesDocComment.collectionGet, method: 'WS')
        .listen((req) => IPatientRecord(req).getDocComments())
    ..serve(RoutesPatientRecord.collectionGet, method: 'WS')
        .listen((req) => CPatientRecord(req).get())
    ..serve(RoutesPatientRecord.collectionDelete, method: 'WS')
        .listen((req) => CPatientRecord(req).delete())

    ..serve(RoutesCommission.itemGet, method: 'WS')
        .listen((req) => ICommission(req).get())
    ..serve(RoutesCommission.itemSave, method: 'WS')
        .listen((req) => ICommission(req).save())
    ..serve(RoutesCommission.itemDelete, method: 'WS')
        .listen((req) => ICommission(req).delete())
    ..serve(RoutesCommission.getDoctors, method: 'WS')
        .listen((req) => ICommission(req).getDoctors())
    ..serve(RoutesCommission.collectionGet, method: 'WS')
        .listen((req) => CCommission(req).get())
    ..serve(RoutesCommission.collectionDelete, method: 'WS')
        .listen((req) => CCommission(req).delete())
    ..serve(RoutesCommission.collectionSuggest, method: 'WS')
        .listen((req) => CCommission(req).suggest())

    ..serve(RoutesDisease.itemGet, method: 'WS')
        .listen((req) => IDisease(req).get())
    ..serve(RoutesDisease.itemSave, method: 'WS')
        .listen((req) => IDisease(req).save())
    ..serve(RoutesDisease.itemDelete, method: 'WS')
        .listen((req) => IDisease(req).delete())
    ..serve(RoutesDisease.collectionGet, method: 'WS')
        .listen((req) => CDisease(req).get())
    ..serve(RoutesDisease.collectionDelete, method: 'WS')
        .listen((req) => CDisease(req).delete())
    ..serve(RoutesDisease.collectionSuggest, method: 'WS')
        .listen((req) => CDisease(req).suggest())

    ..serve(RoutesMotivation.itemGet, method: 'WS')
         .listen((req) => IMotivation(req).get())
    ..serve(RoutesMotivation.itemSave, method: 'WS')
          .listen((req) => IMotivation(req).save())
    ..serve(RoutesMotivation.getUser, method: 'WS')
          .listen((req) => IMotivation(req).getUser())

  );
}

Future<void> init() async {
  registerPermissions();
  addRoutes();
}