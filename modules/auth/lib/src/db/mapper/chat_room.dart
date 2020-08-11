part of auth.mapper;

class ChatRoomMapper extends Mapper<ChatRoom, ChatRoomCollection, App> {
  String table = 'chat_room';

  ChatRoomMapper(m) : super(m);

  Future<ChatRoom> findByContext(String context) => loadE(selectBuilder()
    ..where('context = @c')
    ..setParameter('c', context));
}

class ChatRoom extends entity.ChatRoom with Entity<App> {
  Future<int> loadQuantity() async =>
      manager.app.chat_message.loadCount(chat_room_id);

  Future<ChatMembershipCollection> loadMembers() async {
    members = await manager.app.chat_membership.findAllByRoom(chat_room_id);
    for (final cm in members) await cm.loadUser();
    return members;
  }

  Future<int> loadUnseen(int chat_message_seen_id) async {
    final messages = (chat_message_seen_id == null)
        ? await manager.app.chat_message.loadRecent(chat_room_id, 0)
        : await manager.app.chat_message
            .loadNew(chat_room_id, chat_message_seen_id);
    return messages.length;
  }
}

class ChatRoomCollection extends entity.ChatRoomCollection<ChatRoom> {}
