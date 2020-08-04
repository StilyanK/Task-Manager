import 'dart:async';

import 'package:cl_base/server.dart' as base;
import 'package:project/src/mapper.dart';

import 'src/ctrl.dart';
import 'src/entity.dart' as entity;
import 'src/path.dart';
import 'src/permission.dart';

export 'src/ctrl.dart';
export 'src/path.dart';

void registerPermissions() {
  base.permissionRegisterStandardPack(Group.Document, Scope.Doctor);
  base.permissionRegister(
      Group.Document, Scope.Doctor, [base.$RunRights.read], true);
  base.permissionRegisterStandardPack(Group.Document, Scope.Patient);
  base.permissionRegister(
      Group.Document, Scope.Patient, [base.$RunRights.read], true);
  base.permissionRegisterStandardPack(Group.Document, Scope.PatientRecord);
  base.permissionRegister(
      Group.Document, Scope.PatientRecord, [base.$RunRights.read], true);

  ///Extra rights needed for doctors and etc
  base.permissionRegister(
      Group.Document,
      Scope.PatientRecord,
      [
        Right.document_check,
        Right.file_comment,
        Right.commission_check,
        Right.make_decision,
        Right.see_all
      ],
      false);

  base.permissionRegisterStandardPack(Group.Document, Scope.Commission);
  base.permissionRegister(
      Group.Document, Scope.Commission, [base.$RunRights.read], true);
  base.permissionRegisterStandardPack(Group.Document, Scope.Disease);
  base.permissionRegister(
      Group.Document, Scope.Disease, [base.$RunRights.read], true);
}

void addRoutes() {
  base.routes.add((router) => router
//
    ..serve(RoutesTask.itemGet, method: 'WS').listen((req) => ITask(req).get())
    ..serve(RoutesTask.itemSave, method: 'WS')
        .listen((req) => ITask(req).save())
    ..serve(RoutesTask.itemDelete, method: 'WS')
        .listen((req) => ITask(req).delete()));
}

Future<void> init() async {
  registerPermissions();
  addRoutes();
  base.routes.add(routesTask);
  base.routes.add(routesGadget);

  notifierTask.onCreate.listen((event) async {
    await base.dbWrap<void, App>(new App(), (manager) async {
      final dec = await manager.app.task.find(event.entity.task_id);
      base.sendEvent(RoutesTask.onCreate, '${dec?.task_id}');
    });
  });

  notifierTask.onUpdate.listen((event) async {
    await base.dbWrap<void, App>(new App(), (manager) async {
      final wsClients = base.getWSClients();
      //it should not happen
      if (wsClients == null || wsClients.isEmpty) return;
      await manager.begin();
      final user_id = wsClients.first.req.session['client']['user_id'];
      final ent = await manager.app.task
          .prepare(event.entity.task_id, {entity.$Task.modified_by: user_id});
      await manager.commit();
      base.sendEvent(RoutesTask.onUpdate, '${ent?.task_id}');
    });
  });

  notifierTask.onDelete.listen((event) async {
    await base.dbWrap<void, App>(new App(), (manager) async {
      final dec = await manager.app.task.find(event.entity.task_id);
      base.sendEvent(RoutesTask.onDelete, '${dec?.task_id}');
    });
  });
}
