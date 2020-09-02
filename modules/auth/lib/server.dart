import 'dart:typed_data';

import 'package:auth/src/svc/chat.dart';
import 'package:cl_base/server.dart' as base;
import 'dart:convert';
import 'package:cryptography/cryptography.dart';

import 'src/ctrl.dart';
import 'src/mapper.dart';
import 'src/path.dart';
import 'src/permission.dart';
import 'src/server.dart';
import 'src/svc/permission.dart';

export 'src/mapper.dart';
export 'src/path.dart';
export 'src/permission.dart';
export 'src/server.dart';
export 'src/svc/chat.dart';
export 'src/svc/generate/generate.dart';
export 'src/svc/permission.dart';
export 'src/svc/user.dart';

Future<Uint8List> sendMessage(String m) async {
  final algorithm = ecdhP256;
  final localKeyPair = await algorithm.newKeyPair();
  final remoteKeyPair = await algorithm.newKeyPair();
  final sharedSecretKey = await algorithm.sharedSecret(
    localPrivateKey: localKeyPair.privateKey,
    remotePublicKey: remoteKeyPair.publicKey,
  );

  final message = utf8.encode(m);

  const cipher = aesGcm;
  final secretKey = cipher.newSecretKeySync(length: 128);
  final nonce = cipher.newNonce();

  // Encrypt
  return cipher.encrypt(
    message,
    secretKey: secretKey,
    nonce: nonce,
  );
}

void init() {
  base.boot_call.add((e) {
    //TODO
    //base.config['vapid_keys'];
    //print(e);
  });
  base.routes.add(routesUser);
  base.routes.add(routesGroup);
  base.routes.add(routesCalendar);
  base.routes.add(routesNotifications);
  base.routes.add(routesChat);

  PermissionManager().registerGroup(AccountGroup.Administrator);
  PermissionManager().registerGroup(AccountGroup.User);

  base.onclose = (req) => CLogin(req).userLogout();
  base.permissionCheck = checkPermission;
  base.permissionMessage = permissionMessage;
  base.permissionRegister = PermissionManager().register;

  base.notificator.onNotification.listen(_onNotification);

  entityRoom.onChange.listen((cont) => base.dbWrap<void, App>(
      App(), (manager) => new Chat(manager).onRoomChange(cont)));

  entityMessage.onChange.listen((cont) => base.dbWrap<void, App>(
      App(), (manager) => new Chat(manager).onMessageChange(cont)));

  PermissionManager()
    ..register(Group.Auth, Scope.User, PA.crud, false)
    ..register(Group.Auth, Scope.Group, PA.crud, false)
    ..register(Group.Auth, Scope.User, [PA.read], true)
    ..register(Group.Auth, Scope.Group, [PA.read], true);

  PermissionManager().permission(AccountGroup.Administrator)
    ..register(Group.Auth, Scope.User, PA.crud, true)
    ..register(Group.Auth, Scope.Group, PA.crud, true);
}

bool checkPermission(Map session, String group, String scope, String access) {
  if (group == null || scope == null) return true;
  if (session != null && session[SESSIONKEY] != null) {
    final client = session[SESSIONKEY];
    if (client['user_group_id'] > 1 && group != 'system')
      return PermissionManager()
          .permission(client['user_group_id'])
          .check(group, scope, access, client['permissions']);
    else
      return true;
  }
  return false;
}

String permissionMessage(String group, String scope, String access) =>
    PermissionManager().message(group, scope, access);

void _onNotification(base.SMessage mes) {
  base.dbWrap<void, App>(App(), (manager) async {
    final users = await manager.app.user.findAll();
    final parts = mes.key.split(':');
    final wsClients = base.getWSClients();
    for (final user in users) {
      var hasAccess = false;
      if (parts.length > 1) {
        await user.loadUserGroup();
        if (parts[0] == 'system')
          hasAccess = true;
        else
          hasAccess = PermissionManager()
              .permission(user.user_group_id)
              .check(parts[0], parts[1], parts[2], user.user_group.permissions);
      }
      if (user.user_group_id == 1 || (user.active && hasAccess)) {
        final notification = manager.app.user_notification.createObject()
          ..user_id = user.user_id
          ..notification_id = mes.notification_id
          ..read = false;
        await manager.app.user_notification.insert(notification);
        final clients = wsClients.where((client) =>
            user.user_id ==
            (client.req.session['client'] != null
                ? UserSessionDTO.fromMap(client.req.session['client']).user_id
                : null));
        if (clients.isNotEmpty) {
          clients.forEach((client) {
            client.send(mes.key, {
              'event': mes.key,
              'id': notification.user_notification_id,
              'read': notification.read,
              'text': mes.value,
              'date': mes.date.toString()
            });
          });
        }
      }
    }
  });
}
