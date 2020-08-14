library auth.server;

import 'dart:async';

import 'package:cl_base/server.dart' as base;
import 'package:communicator/server.dart';

import 'package:mapper/mapper.dart';

import 'mapper.dart';

Future<Map<String, dynamic>> Function(Manager man, User user) updateSession =
    (man, u) async => {};

Client getWsClient(int userId) => base.getWSClients().firstWhere(
    (client) =>
        client.req.session['client'] != null &&
        client.req.session['client']['user_id'] == userId,
    orElse: () => null);

Future<void> sendUserNotification(
    Manager<App> manager, Iterable<int> userIds, base.SMessage mes) async {
  if (userIds.isEmpty) return;
  final not = manager.app.notification.createObject()
    ..date = mes.date ?? new DateTime.now()
    ..key = mes.key
    ..value = mes.value;
  await manager.app.notification.insert(not);
  for (final userId in userIds) {
    final notUser = manager.app.user_notification.createObject()
      ..notification_id = not.notification_id
      ..read = false
      ..user_id = userId;
    await manager.app.user_notification.insert(notUser);
    final ws = getWsClient(userId);
    if (ws != null)
      ws.send(mes.key, {
        'event': mes.key,
        'id': notUser.user_notification_id,
        'read': notUser.read,
        'text': mes.value,
        'date': mes.date.toString()
      });
  }
}
