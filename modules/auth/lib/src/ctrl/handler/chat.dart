part of auth.ctrl;

class CChat extends base.Base<App> {
  CChat(req) : super(req);

  Future<dynamic> loadMessages() => run(null, null, null, () async {
        manager = await Database().init(App());
        final room = ChatRoomDTO.fromMap(await getData());
        return response(await new Chat(manager).loadMessages(room));
      });

  Future<dynamic> loadMessagesNew() => run(null, null, null, () async {
        manager = await Database().init(App());
        final room = ChatRoomDTO.fromMap(await getData());
        return response(
            await new Chat(manager).loadMessages(room, recent: false));
      });

  Future<dynamic> createRoom() => run(null, null, null, () async {
        manager = await Database().init(App());
        final cr = ChatRoomDTO.fromMap(await getData());
        final meUserId = UserSessionDTO.fromMap(req.session['client']).user_id;
        await manager.begin();
        final res = await new Chat(manager).createRoom(cr, meUserId);
        await manager.commit();
        return response(res);
      });

  Future<dynamic> loadRooms() => run(null, null, null, () async {
        manager = await Database().init(App());
        final meUserId = UserSessionDTO.fromMap(req.session['client']).user_id;
        return response(await new Chat(manager).loadRooms(meUserId));
      });

  Future<dynamic> loadUnread() => run(null, null, null, () async {
        manager = await Database().init(App());
        final meUserId = UserSessionDTO.fromMap(req.session['client']).user_id;
        return response(await new Chat(manager).loadUnread(meUserId));
      });

  Future<dynamic> messagePersist() => run(null, null, null, () async {
        manager = await Database().init(App());
        final m = ChatMessageDTO.fromMap(await getData());
        return response(await new Chat(manager).messagePersist(m));
      });

  Future<dynamic> messageUpdate() => run(null, null, null, () async {
        manager = await Database().init(App());
        final m = ChatMessageDTO.fromMap(await getData());
        return response(await new Chat(manager).messageUpdate(m));
      });

  Future<dynamic> messageType() => run(null, null, null, () async {
        manager = await Database().init(App());
        final r = ChatRoomDTO.fromMap(await getData());
        return response(await new Chat(manager).messageType(r));
      });

  Future<dynamic> messageMarkSeen() => run(null, null, null, () async {
        manager = await Database().init(App());
        final ms = ChatMessageDTO.fromMap(await getData());
        final meUserId = UserSessionDTO.fromMap(req.session['client']).user_id;
        return response(await new Chat(manager).messageMarkSeen(ms, meUserId));
      });
}
