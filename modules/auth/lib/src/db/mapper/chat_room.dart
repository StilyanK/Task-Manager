part of auth.mapper;

class ChatRoomMapper extends Mapper<ChatRoom, ChatRoomCollection, App> {
  String table = 'chat_room';

  ChatRoomMapper(m) : super(m);

  Future<ChatRoom> findByContext(String context) => loadE(selectBuilder()
    ..where('context = @c')
    ..setParameter('c', context));
}

class ChatRoom extends entity.ChatRoom with Entity<App> {}

class ChatRoomCollection extends entity.ChatRoomCollection<ChatRoom> {}
