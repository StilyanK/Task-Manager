library auth.chat;

import 'dart:async';

import 'package:mapper/mapper.dart';

import '../mapper.dart';
import '../path.dart';
import '../server.dart';

class Chat {
  Manager<App> manager;

  Chat(this.manager);

  Future<List<ChatMessageDTO>> loadMessages(ChatRoomDTO room) async {
    if (room.room_id == null && room.context != null) {
      final r = await manager.app.chat_room.findByContext(room.context);
      if (r != null) room.room_id = r.chat_room_id;
    }
    final messages = await manager.app.chat_message.loadRecent(room.room_id);
    for (final m in messages) {
      await m.loadRoom();
      await m.loadUser();
    }
    return messages
        .map((m) => ChatMessageDTO()
          ..id = m.chat_message_id
          ..member = (ChatMemberDTO()
            ..user_id = m.user.user_id
            ..name = m.user.name
            ..status = _isOnline(m.user_id)
            ..picture = m.user.picture != null
                ? 'media/image100x100/user/${m.user.user_id}/${m.user.picture}'
                : null)
          ..room_id = m.chat_room_id
          ..content = m.content
          ..timestamp = m.timestamp)
        .toList();
  }

  bool _isOnline(int userId) => getWsClient(userId) != null;

  Future<List<ChatMessageDTO>> loadMessagesNew(ChatRoomDTO room) async {
    if (room.room_id == null && room.context != null) {
      final r = await manager.app.chat_room.findByContext(room.context);
      if (r != null) room.room_id = r.chat_room_id;
    }
    final messages =
        await manager.app.chat_message.loadNew(room.room_id, room.lsm_id);
    for (final m in messages) {
      await m.loadRoom();
      await m.loadUser();
    }
    return messages
        .map((m) => ChatMessageDTO()
          ..id = m.chat_message_id
          ..member = (ChatMemberDTO()
            ..user_id = m.user.user_id
            ..name = m.user.name
            ..status = _isOnline(m.user_id)
            ..picture = m.user.picture != null
                ? 'media/image100x100/user/${m.user.user_id}/${m.user.picture}'
                : null)
          ..room_id = m.chat_room_id
          ..context = m.room.context
          ..content = m.content
          ..timestamp = m.timestamp)
        .toList();
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
      ..members = room.members
          .map((u) => ChatMemberDTO()
            ..user_id = u.user_id
            ..name = u.user.name
            ..status = _isOnline(u.user_id)
            ..picture = u.user.picture != null
                ? 'media/image100x100/user/${u.user_id}/${u.user.picture}'
                : null)
          .toList()
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
      ..user_id = m.member.user_id
      ..chat_room_id = room.room_id
      ..timestamp = m.timestamp;
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
        final wsClient = getWsClient(userId);
        if (wsClient != null) {
          wsClient.send(
              RoutesChat.messageTyping,
              ChatRoomDTO()
                ..room_id = r.room_id
                ..members = [
                  new ChatMemberDTO()
                    ..user_id = r.members.first.user_id
                    ..name = r.members.first.name
                ]);
        }
      });
    return true;
  }

  Future<bool> messageUpdate(ChatMessageDTO m) async {
    final message = await manager.app.chat_message.find(m.id);
    if (m.content == null) {
      await manager.app.chat_message.delete(message);
    } else {
      message
        ..content = m.content
        ..timestamp = new DateTime.now();
      await manager.app.chat_message.update(message);
    }
    return true;
  }

  Future<bool> messageSeen(ChatMessageDTO ms, int userId) async {
    if (ms.room_id == null && ms.context != null) {
      final r = await manager.app.chat_room.findByContext(ms.context);
      if (r != null) ms.room_id = r.chat_room_id;
    }
    final m =
        await manager.app.chat_membership.findByRoomAndUser(ms.room_id, userId);
    if (m != null)
      await manager.app.chat_membership.update(m..chat_message_seen_id = ms.id);
    else
      return false;
    return true;
  }
}
