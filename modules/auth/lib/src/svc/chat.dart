library auth.chat;

import 'dart:async';
import 'dart:io';

import 'package:cl_base/server.dart' as cl_base;
import 'package:mapper/mapper.dart';

import '../mapper.dart';
import '../path.dart';
import '../server.dart';

class Chat {
  Manager<App> manager;

  Chat(this.manager);

  Future<List<ChatMessageDTO>> loadMessages(ChatRoomDTO room,
      {bool recent = true}) async {
    if (room.room_id == null && room.context != null) {
      final r = await manager.app.chat_room.findByContext(room.context);
      if (r != null) room.room_id = r.chat_room_id;
    }
    final messages = recent
        ? await manager.app.chat_message.loadRecent(room.room_id)
        : await manager.app.chat_message.loadNew(room.room_id, room.lsm_id);
    final membersCol =
        await manager.app.chat_membership.findAllByRoom(room.room_id);
    final res = <ChatMessageDTO>[];
    for (final m in messages) {
      final mes = await getChatMessageDTO(m);
      final seenMembers =
          membersCol.where((m) => m.chat_message_seen_id == mes.id);
      for (final seen in seenMembers)
        mes.seen.add(
            getChatMemberDTO(await seen.loadUser(), width: 25, height: 25));
      res.add(mes);
    }
    return res;
  }

  ChatMemberDTO getChatMemberDTO(User u, {int width = 100, int height = 100}) =>
      new ChatMemberDTO()
        ..user_id = u.user_id
        ..name = u.name
        ..status = _isOnline(u.user_id)
        ..picture = u.picture != null
            ? 'media/image${width}x$height/user/${u.user_id}/${u.picture}'
            : null;

  Future<ChatMessageDTO> getChatMessageDTO(ChatMessage m) async =>
      new ChatMessageDTO()
        ..id = m.chat_message_id
        ..type = m.type
        ..seen = []
        ..member = getChatMemberDTO(await m.loadUser())
        ..room_id = m.chat_room_id
        ..content = _getContent(m.type, m.chat_room_id, m.content)
        ..timestamp = m.timestamp;

  bool _isOnline(int userId) => getWsClient(userId) != null;

  String _getContent(int type, int roomId, String content) {
    if (type == 0) return content;
    return 'media/chat/$roomId/$content';
  }

  Future<ChatRoomDTO> createRoom(ChatRoomDTO cr, int userId) async {
    if (cr.room_id != null) return updateRoom(cr, userId);
    if (cr.context != null) {
      final room = await manager.app.chat_room.findByContext(cr.context);
      if (room != null)
        return updateRoom(cr..room_id = room.chat_room_id, userId);
    }
    final room = manager.app.chat_room.createObject()
      ..context = cr.context
      ..name = cr.title;
    await manager.app.chat_room.insert(room);
    for (final m in cr.members) {
      final membership = manager.app.chat_membership.createObject()
        ..chat_room_id = room.chat_room_id
        ..user_id = m.user_id;
      await manager.app.chat_membership.insert(membership);
    }
    return loadRoom(roomId: room.chat_room_id, userId: userId);
  }

  Future<int> loadUnread(int userId) async {
    final col = await manager.app.chat_membership.findAllByUser(userId);
    int unseen = 0;
    for (final m in col) {
      await m.loadRoom();
      unseen += await m.room.loadUnseen(m.chat_message_seen_id);
    }
    return unseen;
  }

  Future<ChatRoomDTO> updateRoom(ChatRoomDTO cr, int userId) async {
    final room = await manager.app.chat_room.find(cr.room_id)
      ..context = cr.context
      ..name = cr.title;
    final members = await manager.app.chat_membership.findAllByRoom(cr.room_id);
    for (final m in cr.members) {
      if (members.any((member) => member.user_id == m.user_id)) continue;
      final membership = manager.app.chat_membership.createObject()
        ..chat_room_id = room.chat_room_id
        ..user_id = m.user_id;
      await manager.app.chat_membership.insert(membership);
    }
    return loadRoom(roomId: cr.room_id, userId: userId);
  }

  Future<List<ChatRoomDTO>> loadRooms(int userId) async {
    final memberships = await manager.app.chat_membership.findAllByUser(userId);
    final result = <ChatRoomDTO>[];
    for (final mem in memberships)
      result.add(await loadRoom(roomId: mem.chat_room_id, userId: mem.user_id));
    return result;
  }

  Future<ChatRoomDTO> loadRoom({int roomId, int userId}) async {
    final room = await manager.app.chat_room.find(roomId);
    await room.loadMembers();
    final membership = room.members
        .firstWhere((element) => element.user_id == userId, orElse: () => null);
    return ChatRoomDTO()
      ..room_id = room.chat_room_id
      ..context = room.context
      ..title = room.name
      ..members = room.members.map((m) => getChatMemberDTO(m.user)).toList()
      ..lsm_id = membership?.chat_message_seen_id ?? 0
      ..unseen = await room.loadUnseen(membership?.chat_message_seen_id)
      ..messages = await room.loadQuantity();
  }

  Future<ChatRoomDTO> loadRoomByContext(String context, int userId) async {
    final room = await manager.app.chat_room.findByContext(context);
    if (room == null) return null;
    return loadRoom(roomId: room.chat_room_id, userId: userId);
  }

  Future<bool> messagePersist(ChatMessageDTO m) async {
    final room = await createRoom(
        new ChatRoomDTO()
          ..room_id = m.room_id
          ..context = m.context
          ..members = [m.member],
        m.member.user_id);
    final message = manager.app.chat_message.createObject()
      ..content = m.content
      ..type = m.type
      ..user_id = m.member.user_id
      ..chat_room_id = room.room_id
      ..timestamp = m.timestamp;
    if (message.type == 1) {
      final file = m.content.split('/').last;
      final sync = new cl_base.FileSync()
        ..path_from = '${cl_base.path}/tmp'
        ..path_to = '${cl_base.path}/media/chat/${room.room_id}'
        ..file_name = file;
      message.content = await sync.sync();
    }
    await manager.app.chat_message.insert(message);
    return true;
  }

  Future<bool> messageType(ChatRoomDTO r) async {
    final col = await manager.app.chat_membership.findAllByRoom(r.room_id);
    final users = col
        .where(
            (m) => _isOnline(m.user_id) && m.user_id != r.members.first.user_id)
        .map((e) => e.user_id);
    if (users.isNotEmpty)
      users.forEach((userId) {
        final wsClients = getWsClient(userId);
        if (wsClients.isNotEmpty) {
          wsClients.forEach((cl) => cl.send(
              RoutesChat.messageTyping,
              new ChatRoomDTO()
                ..room_id = r.room_id
                ..members = [
                  new ChatMemberDTO()
                    ..user_id = r.members.first.user_id
                    ..name = r.members.first.name
                ]));
        }
      });
    return true;
  }

  Future<bool> messageUpdate(ChatMessageDTO m) async {
    final message = await manager.app.chat_message.find(m.id);
    if (m.content == null) {
      if (message.type == 1) {
        final file =
            _getContent(message.type, message.chat_room_id, message.content);
        await new File('${cl_base.path}/$file').delete();
      }
      await manager.app.chat_message.delete(message);
    } else {
      message
        ..content = m.content
        ..timestamp = new DateTime.now();
      await manager.app.chat_message.update(message);
    }
    return true;
  }

  Future<bool> messageMarkSeen(ChatMessageDTO ms, int userId) async {
    if (ms.room_id == null && ms.context != null) {
      final r = await manager.app.chat_room.findByContext(ms.context);
      if (r != null) ms.room_id = r.chat_room_id;
    }
    final m =
        await manager.app.chat_membership.findByRoomAndUser(ms.room_id, userId);
    if (m != null) {
      await manager.app.chat_membership.update(m..chat_message_seen_id = ms.id);
      await onMessageSeen(m);
    } else
      return false;
    return true;
  }

  Future<void> onRoomChange(EntityContainer<ChatRoom> cont) async {
    final col = await manager.app.chat_membership
        .findAllByRoom(cont.entity.chat_room_id);
    final room = await manager.app.chat_room.find(cont.entity.chat_room_id);
    final wsClients = cl_base.getWSClients();
    for (final cm in col) {
      final wsClient = wsClients.firstWhere(
          (client) =>
              UserSessionDTO.fromMap(client.req.session['client']).user_id ==
              cm.user_id,
          orElse: () => null);
      if (wsClient != null) {
        final contr =
            cont.isInserted ? RoutesChat.roomCreated : RoutesChat.roomUpdated;
        wsClient.send(
            contr,
            ChatRoomDTO()
              ..room_id = cont.entity.chat_room_id
              ..context = room.context);
      }
    }
  }

  Future<void> onMessageSeen(ChatMembership m) async {
    final mes = await getChatMessageDTO(
        await manager.app.chat_message.find(m.chat_message_seen_id));
    final col = await manager.app.chat_membership.findAllByRoom(m.chat_room_id);
    final seenMembers = col.where((m) => m.chat_message_seen_id == mes.id);
    for (final seen in seenMembers)
      mes.seen
          .add(getChatMemberDTO(await seen.loadUser(), width: 25, height: 25));
    for (final cm in col) {
      final wsClients = getWsClient(cm.user_id);
      if (wsClients.isNotEmpty)
        wsClients.forEach((cl) => cl.send(RoutesChat.messageSeen, mes));
    }
  }

  Future<void> onMessageChange(EntityContainer<ChatMessage> cont) async {
    final col = await manager.app.chat_membership
        .findAllByRoom(cont.entity.chat_room_id);
    final room = await manager.app.chat_room.find(cont.entity.chat_room_id);
    for (final cm in col) {
      final wsClients = getWsClient(cm.user_id);
      if (wsClients.isNotEmpty) {
        final user = await manager.app.user.find(cont.entity.user_id);
        final contr = cont.isInserted
            ? RoutesChat.messageCreated
            : RoutesChat.messageUpdated;
        wsClients.forEach((cl) {
          cl.send(
              contr,
              ChatMessageDTO()
                ..id = cont.entity.chat_message_id
                ..room_id = cont.entity.chat_room_id
                ..context = room.context
                ..content = cont.isDeleted ? null : cont.entity.content
                ..timestamp = cont.entity.timestamp
                ..member = (new ChatMemberDTO()
                  ..name = user.name
                  ..user_id = user.user_id));
        });
      }
    }
  }
}
