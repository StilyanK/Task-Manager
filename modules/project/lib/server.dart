import 'dart:async';

import 'package:cl_base/server.dart' as base;
import 'package:mailer/smtp_server.dart';
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

  notifierTask.onChange.listen((event) async {
    await base.dbWrap<void, App>(new App(), (manager) async {
      final task = event.entity;
      final user = await manager.app.user.find(task.assigned_to);
      final createdBy = await manager.app.user.find(task.created_by);
      final modifiedBy = await manager.app.user.find(task.modified_by);
      final Map state = {};
      String subject;
      String text;
      if (event.isInserted) {
        subject = 'Имате нова задача!';
        text =
        '${task.title}\n${task.description}\nЗададена от: ${createdBy.name}';
      } else if (event.isUpdated) {
        subject = 'Задача ${task.title} e променена';
        text =
        '${task.title}\n${task.description}\nПроменена от: ${modifiedBy.name}';
      } else if (event.isDeleted) {
        subject = 'Задача ${task.title} e изтрита';
        text =
        '${task.title}\n${task.description}\nИзтрита от: ${modifiedBy.name}';
      }

      if (user != null && user.mail != null) {
        final m = base.Mail(SmtpServer('ns1.centryl.net',
            port: 25,
            username: 'medicframe',
            password: '!2@3#AP2JkLQ',
            ignoreBadCertificate: true,
            ssl: false))
          ..from('no-reply@medicframe.com')
          ..to(user.mail)
          ..setSubject(subject)
          ..setText(text);
        await m.send();
        state['success'] = 'true';
      } else {
        state['error'] = 'true';
      }
    });
  });

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
      await manager.app.task
          .prepare(event.entity.task_id, {entity.$Task.modified_by: user_id});
      await manager.commit();
    });
  });

  notifierTask.onDelete.listen((event) async {
    await base.dbWrap<void, App>(new App(), (manager) async {
      final dec = await manager.app.task.find(event.entity.task_id);
      base.sendEvent(RoutesTask.onDelete, '${dec?.task_id}');
    });
  });
}
