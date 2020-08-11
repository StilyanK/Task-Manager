library auth.chat;

import 'dart:async';

import 'package:mapper/mapper.dart';

import '../mapper.dart';
import '../path.dart';

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
            ..picture = m.user.picture != null
                ? 'media/image100x100/user/${m.user.user_id}/${m.user.picture}'
                : null)
          ..room_id = m.chat_room_id
          ..content = m.content
          ..timestamp = m.timestamp)
        .toList();
  }

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
    for (final r in col) unseen += await r.loadUnseen();
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
    for (final mem in memberships) result.add(await loadRoom(membership: mem));
    return result;
  }

  Future<ChatRoomDTO> loadRoomByContext(String context, int userId) async {
    final room = await manager.app.chat_room.findByContext(context);
    if (room == null) return null;
    return loadRoom(roomId: room.chat_room_id, userId: userId);
  }

  Future<ChatRoomDTO> loadRoom(
      {ChatMembership membership, int roomId, int userId}) async {
    membership ??=
        await manager.app.chat_membership.findByRoomAndUser(roomId, userId);
    if (membership == null) return null;
    await membership.loadRoom();
    await membership.loadUsers();
    return ChatRoomDTO()
      ..room_id = membership.chat_room_id
      ..context = membership.room.context
      ..title = membership.room.name
      ..members = membership.users
          .map((u) => ChatMemberDTO()
            ..user_id = u.user_id
            ..name = u.name
            ..picture = u.picture != null
                ? 'media/image100x100/user/${u.user_id}/${u.picture}'
                : null)
          .toList()
      ..lsm_id = membership.chat_message_seen_id ?? 0
      ..unseen = await membership.loadUnseen()
      ..messages = await membership.loadQuantity();
  }

  Future<bool> messagePersist(ChatMessageDTO m) async {
    int roomId = m.room_id;
    if (roomId == null) {
      final room = await createRoom(
          new ChatRoomDTO()
            ..context = m.context
            ..members = [m.member],
          m.member.user_id);
      roomId = room.room_id;
    }
    final message = manager.app.chat_message.createObject()
      ..content = m.content
      ..user_id = m.member.user_id
      ..chat_room_id = roomId
      ..timestamp = m.timestamp;
    await manager.app.chat_message.insert(message);
    return true;
  }

  Future<bool> messageSeen(ChatMessageDTO ms, int userId) async {
    final m =
        await manager.app.chat_membership.findByRoomAndUser(ms.room_id, userId);
    if (m != null)
      await manager.app.chat_membership.update(m..chat_message_seen_id = ms.id);
    else
      return false;
    return true;
  }
}
