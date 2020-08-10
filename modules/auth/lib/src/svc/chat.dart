library auth.chat;

import 'dart:async';

import 'package:mapper/mapper.dart';

import '../mapper.dart';
import '../path.dart';

class Chat {
  Manager<App> manager;

  Chat(this.manager);

  Future<List<ChatMessageDTO>> loadMessages(ChatMessageLoadDTO chm) async {
    final messages = await manager.app.chat_message.loadRecent(chm.room_id);
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

  Future<List<ChatMessageDTO>> loadMessagesNew(ChatMessageLoadDTO chm) async {
    final messages =
        await manager.app.chat_message.loadNew(chm.room_id, chm.lsm_id);
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

  Future<bool> createRoom(ChatRoomCreateDTO cr) async {
    final room = manager.app.chat_room.createObject();
    await manager.app.chat_room.insert(room);
    cr.members.forEach((m) {
      final membership = manager.app.chat_membership.createObject()
        ..chat_room_id = room.chat_room_id
        ..user_id = m.user_id;
      manager.addNew(membership);
    });
    await manager.persist();
    return true;
  }

  Future<bool> updateRoom(ChatRoomDTO cr) async {
    final room = await manager.app.chat_room.find(cr.room_id);
    final members = await manager.app.chat_membership.findAllByRoom(cr.room_id);
    for (final m in cr.members) {
      if (members.any((member) => member.user_id == m.user_id)) continue;
      final membership = manager.app.chat_membership.createObject()
        ..chat_room_id = room.chat_room_id
        ..user_id = m.user_id;
      await manager.app.chat_membership.insert(membership);
    }
    return true;
  }

  Future<List<ChatRoomDTO>> loadRooms(int userId) async {
    final memberships = await manager.app.chat_membership.findAllByUser(userId);
    final result = <ChatRoomDTO>[];
    for (final mem in memberships) {
      await mem.loadUsers();
      mem.users.removeWhere((u) => u.user_id == userId);
      result.add(ChatRoomDTO()
        ..room_id = mem.chat_room_id
        ..title = mem.users.map((u) => u.name).join(', ')
        ..members = mem.users
            .map((u) => ChatMemberDTO()
              ..user_id = u.user_id
              ..name = u.name
              ..picture = u.picture != null
                  ? 'media/image100x100/user/${u.user_id}/${u.picture}'
                  : null)
            .toList()
        ..lsm_id = mem.chat_message_seen_id ?? 0
        ..unseen = await mem.loadUnseen());
    }
    return result;
  }

  Future<bool> messagePersist(ChatMessagePersistDTO cr) async {
    final message = manager.app.chat_message.createObject()
      ..content = cr.content
      ..user_id = cr.member.user_id
      ..chat_room_id = cr.room_id
      ..timestamp = cr.timestamp;
    await manager.app.chat_message.insert(message);
    return true;
  }

  Future<bool> messageSeen(ChatMessageSeenDTO ms, int userId) async {
    final m =
        await manager.app.chat_membership.findByRoomAndUser(ms.room_id, userId)
          ..chat_message_seen_id = ms.id;
    await manager.app.chat_membership.update(m);
    return true;
  }
}
