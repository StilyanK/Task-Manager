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
//
    ..serve(RoutesTask.itemGet, method: 'WS')
        .listen((req) => ITask(req).get())
    ..serve(RoutesTask.itemSave, method: 'WS')
        .listen((req) => ITask(req).save())
    ..serve(RoutesTask.itemDelete, method: 'WS')
        .listen((req) => ITask(req).delete())
//    ..serve(RoutesTask.collectionGet, method: 'WS')
//        .listen((req) => CCommission(req).get())
//    ..serve(RoutesTask.collectionDelete, method: 'WS')
//        .listen((req) => CCommission(req).delete())



  );
}

Future<void> init() async {
  registerPermissions();
  addRoutes();
}