part of auth.ctrl;

class CChat extends base.Base<App> {
  CChat(req) : super(req);

  Future<dynamic> loadMessages() => run(null, null, null, () async {
        final chm = ChatMessageLoadDTO.fromMap(await getData());
        manager = await Database().init(App());
        return response(await new Chat(manager).loadMessages(chm));
      });

  Future<dynamic> loadMessagesNew() => run(null, null, null, () async {
        final chm = ChatMessageLoadDTO.fromMap(await getData());
        manager = await Database().init(App());
        return response(await new Chat(manager).loadMessagesNew(chm));
      });

  Future<dynamic> createRoom() => run(null, null, null, () async {
        manager = await Database().init(App());
        final cr = ChatRoomCreateDTO.fromMap(await getData());
        await manager.begin();
        final res = await new Chat(manager).createRoom(cr);
        await manager.commit();
        return response(res);
      });

  Future<dynamic> loadRooms() => run(null, null, null, () async {
        manager = await Database().init(App());
        final meUserId = UserSessionDTO.fromMap(req.session['client']).user_id;
        return response(await new Chat(manager).loadRooms(meUserId));
      });

  Future<dynamic> messagePersist() => run(null, null, null, () async {
        manager = await Database().init(App());
        final cr = ChatMessagePersistDTO.fromMap(await getData());
        return response(await new Chat(manager).messagePersist(cr));
      });

  Future<dynamic> messageSeen() => run(null, null, null, () async {
        manager = await Database().init(App());
        final ms = ChatMessageSeenDTO.fromMap(await getData());
        final meUserId = UserSessionDTO.fromMap(req.session['client']).user_id;
        return response(await new Chat(manager).messageSeen(ms, meUserId));
      });
}
