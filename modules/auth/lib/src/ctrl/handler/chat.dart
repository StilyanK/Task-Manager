part of auth.ctrl;

class Chat extends base.Base<App> {
  Chat(req) : super(req);

  Future<dynamic> loadMessages() => run(null, null, null, () async {
        final chm = ChatMessageLoadDTO.fromMap(await getData());
        manager = await Database().init(App());
        final messages = await manager.app.chat_message.loadRecent(chm.room_id);
        for (final m in messages) {
          await m.loadRoom();
          await m.loadUser();
        }

        response(messages
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
            .toList());
      });

  Future<dynamic> loadMessagesNew() => run(null, null, null, () async {
        final chm = ChatMessageLoadDTO.fromMap(await getData());
        manager = await Database().init(App());
        final messages =
            await manager.app.chat_message.loadNew(chm.room_id, chm.lsm_id);
        for (final m in messages) {
          await m.loadRoom();
          await m.loadUser();
        }
        response(messages
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
            .toList());
      });

  Future<dynamic> createRoom() => run(null, null, null, () async {
        manager = await Database().init(App());
        final cr = ChatRoomCreateDTO.fromMap(await getData());
        await manager.begin();
        final room = manager.app.chat_room.createObject();
        await manager.app.chat_room.insert(room);
        await manager.persist();
        cr.members.forEach((m) {
          final membership = manager.app.chat_membership.createObject()
            ..chat_room_id = room.chat_room_id
            ..user_id = m.user_id;
          manager.addNew(membership);
        });
        await manager.commit();
        response(true);
      });

  Future<dynamic> loadRooms() => run(null, null, null, () async {
        manager = await Database().init(App());
        final meUserId =
            UserSessionDTO.fromMap(req.session['client']).user_id;
        final memberships =
            await manager.app.chat_membership.findAllByUser(meUserId);
        final result = [];
        for (final mem in memberships) {
          await mem.loadUsers();
          mem.users.removeWhere((u) => u.user_id == meUserId);
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
        response(result);
      });

  Future<dynamic> messagePersist() => run(null, null, null, () async {
        manager = await Database().init(App());
        final cr = ChatMessagePersistDTO.fromMap(await getData());
        final message = manager.app.chat_message.createObject()
          ..content = cr.content
          ..user_id = cr.member.user_id
          ..chat_room_id = cr.room_id
          ..timestamp = cr.timestamp;
        await manager.app.chat_message.insert(message);
        response(true);
      });

  Future<dynamic> messageSeen() => run(null, null, null, () async {
        manager = await Database().init(App());
        final ms = ChatMessageSeenDTO.fromMap(await getData());
        final meUserId =
            UserSessionDTO.fromMap(req.session['client']).user_id;
        final m = await manager.app.chat_membership
            .findByRoomAndUser(ms.room_id, meUserId)
          ..chat_message_seen_id = ms.id;
        await manager.app.chat_membership.update(m);
        response(true);
      });
}
