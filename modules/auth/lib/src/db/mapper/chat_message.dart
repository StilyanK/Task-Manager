part of auth.mapper;

class ChatMessageMapper
    extends Mapper<ChatMessage, ChatMessageCollection, App> {
  String table = 'chat_message';

  ChatMessageMapper(m) : super(m);

  Future<int> loadCount(int roomId) async {
    final q = selectBuilder('count(*) AS qty')
      ..where('chat_room_id = @r_id')
      ..setParameter('r_id', roomId);
    final res = await manager.execute(q);
    return res[0]['qty'];
  }

  Future<ChatMessageCollection> loadRecent(int roomId, [int limit = 50]) =>
      loadC(selectBuilder()
        ..where('chat_room_id = @r_id')
        ..orderBy('chat_message_id', 'DESC')
        ..limit(limit)
        ..setParameter('r_id', roomId));

  Future<ChatMessageCollection> loadNew(int roomId, int lastId) =>
      loadC(selectBuilder()
        ..where('chat_room_id = @r_id', 'chat_message_id > @l_id')
        ..orderBy('chat_message_id', 'DESC')
        ..setParameter('r_id', roomId)
        ..setParameter('l_id', lastId));
}

class ChatMessage extends entity.ChatMessage with Entity<App> {
  Future<ChatRoom> loadRoom() async =>
      room = await manager.app.chat_room.find(chat_room_id);

  Future<User> loadUser() async => user = await manager.app.user.find(user_id);
}

class ChatMessageCollection extends entity.ChatMessageCollection<ChatMessage> {}
