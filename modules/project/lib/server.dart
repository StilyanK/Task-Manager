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
  base.permissionRegisterStandardPack(Group.Project, Scope.Project);
  base.permissionRegisterStandardPack(Group.Project, Scope.Task);
}

Future<void> init() async {
  registerPermissions();
  base.routes.add(routesTask);
  base.routes.add(routesGadget);
  base.routes.add(routesProject);

  notifierTask.onCreate
      .listen((o) => base.sendEvent(RoutesTask.eventCreate, o.entity.task_id));
  notifierTask.onUpdate
      .listen((o) => base.sendEvent(RoutesTask.eventUpdate, o.entity.task_id));
  notifierTask.onDelete
      .listen((o) => base.sendEvent(RoutesTask.eventDelete, o.entity.task_id));

  notifierProject.onCreate.listen(
      (o) => base.sendEvent(RoutesProject.eventCreate, o.entity.project_id));
  notifierProject.onUpdate.listen(
      (o) => base.sendEvent(RoutesProject.eventUpdate, o.entity.project_id));
  notifierProject.onDelete.listen(
      (o) => base.sendEvent(RoutesProject.eventDelete, o.entity.project_id));

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
      } else if (event.isDeleted) {
        subject = 'Задача ${task.title} e изтрита';
        text =
            '${task.title}\n${task.description}\nПроменена от: ${modifiedBy?.name}';
      } else if (event.isDeleted) {
        subject = 'Задача ${task.title} e изтрита';
        text =
            '${task.title}\n${task.description}\nИзтрита от: ${modifiedBy?.name}';
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
}
