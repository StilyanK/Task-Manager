import 'dart:async';

import 'package:auth/server.dart' as auth;
import 'package:cl_base/server.dart' as base;
import 'package:mailer/smtp_server.dart';
import 'package:project/src/mapper.dart';

import 'src/ctrl.dart';
import 'src/path.dart';
import 'src/permission.dart';
import 'src/svc.dart';

export 'src/ctrl.dart';
export 'src/path.dart';

void registerPermissions() {
  auth.PermissionManager()
    ..register(Group.Project, Scope.Project, auth.PA.crud, false)
    ..register(Group.Project, Scope.Task, auth.PA.crud, false);

  auth.PermissionManager().permission(auth.AccountGroup.User)
    ..register(Group.Project, Scope.Project,
        [auth.PA.create, auth.PA.read, auth.PA.update], true)
    ..register(Group.Project, Scope.Task,
        [auth.PA.create, auth.PA.read, auth.PA.update], true);

  auth.PermissionManager().permission(auth.AccountGroup.Administrator)
    ..register(Group.Project, Scope.Project, auth.PA.crud, true)
    ..register(Group.Project, Scope.Task, auth.PA.crud, true);
}

Future<void> init() async {
  registerPermissions();
  base.routes.add(routesTask);
  base.routes.add(routesGadget);
  base.routes.add(routesProject);

  auth.entityMessage.onChange.listen((o) async {
    await base.dbWrap<void, App>(new App(), (manager) async {
      final room = await manager.app.chat_room.find(o.entity.chat_room_id);
      if (room.context != null && room.context.startsWith('task')) {
        final id = room.context.replaceAll('task', '');
        final idParsed = int.parse(id);
        base.sendEvent(RoutesTask.eventUpdate, idParsed);
        final memCol = await manager.app.chat_membership
            .findAllByRoom(o.entity.chat_room_id);
        final mems = memCol
            .where((u) => u.user_id != o.entity.user_id)
            .map((e) => e.user_id)
            .toList();
        await auth.sendUserNotification(
            manager.convert(new auth.App()),
            mems,
            new base.SMessage()
              ..key = EVENT_TASK_MESSAGE
              ..value = id.toString()
              ..date = new DateTime.now());
      }
    });
  });

  notifierTask.onCreate
      .listen((o) => base.sendEvent(RoutesTask.eventCreate, o.entity.task_id));
  notifierTask.onUpdate.listen((o) => base.sendEvent(
      RoutesTask.eventUpdate, '${o.entity.task_id}:${o.entity.status}'));
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

      if (event.diff != null) {
        final oldTask = event.diff['parent_task'];
        if (oldTask != null) {
          final parentTask = await manager.app.task.find(oldTask);
          await new TaskStatusManager(manager, parentTask).setStatus();
          await manager.app.task.update(parentTask);
        }
      }
      if (task.parent_task != null) {
        final parentTask = await manager.app.task.find(task.parent_task);
        await new TaskStatusManager(manager, parentTask).setStatus();
        await manager.app.task.update(parentTask);
      }

      final project = await manager.app.project.find(task.project_id);
      final user = await manager.app.user.find(task.assigned_to);
      final createdBy = await manager.app.user.find(task.created_by);
      final modifiedBy = await manager.app.user.find(task.modified_by);
      final managedBy = await manager.app.user.find(project.manager_id);
      String subject, text;
      String notEvent;
      final link =
          '<a href="https://manager.medicframe.com/task/item/${task.task_id}">'
          'https://manager.medicframe.com/task/item/${task.task_id}</a>';
      if (event.isInserted) {
        subject = 'Задача "${task.title}" e създадена (${project.title})';
        text = '<div><b>${task.title}</b></div>'
            '<div>${task.description}</div>'
            '<div>Зададена от: ${createdBy.name}</div>'
            '<div>$link</div>';
        notEvent = EVENT_TASK_CREATE;
      } else if (event.isUpdated) {
        subject = 'Задача "${task.title}" e променена (${project.title})';
        text = '<div><b>${task.title}</b></div>'
            '<div>${task.description}</div>'
            '<div>Променена от: ${modifiedBy?.name}</div>'
            '<div>$link</div>';
        notEvent = EVENT_TASK_UPDATE;
      } else if (event.isDeleted) {
        subject = 'Задача "${task.title}" e изтрита (${project.title})';
        text = '<div><b>${task.title}</b></div>'
            '<div>${task.description}</div>'
            '<div>Изтрита от: ${modifiedBy?.name}</div>';
      }

      final Set<int> ids = {};
      for (final user in <auth.User>[user, createdBy, managedBy]) {
        if (ids.contains(user.user_id)) continue;
        if ((task.modified_by == null && task.created_by == user.user_id) ||
            task.modified_by == user.user_id ||
            user.mail == null) continue;
        ids.add(user.user_id);
        final m = base.Mail(SmtpServer('ns1.centryl.net',
            port: 25,
            username: 'medicframe',
            password: '!2@3#AP2JkLQ',
            ignoreBadCertificate: true,
            ssl: false))
          ..from('no-reply@medicframe.com', 'Medicframe Manager')
          ..to(user.mail)
          ..setSubject(subject)
          ..setHtml(text);
        await m.send();
      }
      await auth.sendUserNotification(
          manager.convert(new auth.App()),
          ids,
          new base.SMessage()
            ..key = notEvent
            ..value = task.task_id.toString()
            ..date = new DateTime.now());
    });
  });
}
