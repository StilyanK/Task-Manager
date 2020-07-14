part of auth.mapper;

class ChatRoomMapper extends Mapper<ChatRoom, ChatRoomCollection, App> {
  String table = 'chat_room';

  ChatRoomMapper(m) : super(m);
}

class ChatRoom extends entity.ChatRoom with Entity<App> {}

class ChatRoomCollection extends entity.ChatRoomCollection<ChatRoom> {}
