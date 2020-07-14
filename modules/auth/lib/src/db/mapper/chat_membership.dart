part of auth.mapper;

class ChatMembershipMapper
    extends Mapper<ChatMembership, ChatMembershipCollection, App> {
  String table = 'chat_membership';

  ChatMembershipMapper(m) : super(m);

  Future<ChatMembershipCollection> findAllByRoom(int room_id) =>
      loadC(selectBuilder()
        ..where('chat_room_id = @room_id', 'timestamp_leave IS NULL')
        ..setParameter('room_id', room_id));

  Future<ChatMembership> findByRoomAndUser(int room_id, int user_id) =>
      loadE(selectBuilder()
        ..where('chat_room_id = @room_id', 'user_id = @user_id')
        ..setParameter('room_id', room_id)
        ..setParameter('user_id', user_id));

  Future<ChatMembershipCollection> findAllByUser(int user_id) =>
      loadC(selectBuilder()
        ..where('user_id = @user_id', 'timestamp_leave IS NULL')
        ..orderBy('chat_membership_id', 'ASC')
        ..setParameter('user_id', user_id));
}

class ChatMembership extends entity.ChatMembership with Entity<App> {
  Future<UserCollection> loadUsers() async {
    final col = await manager.app.chat_membership.findAllByRoom(chat_room_id);
    users = UserCollection();
    for (final cm in col) users.add(await manager.app.user.find(cm.user_id));
    return users;
  }

  Future<int> loadUnseen() async {
    if (chat_message_seen_id == null) {
      final messages =
          await manager.app.chat_message.loadRecent(chat_room_id, 0);
      return messages.length;
    } else {
      final messages =
          await manager.app.chat_message.loadRecent(chat_room_id, 1);
      return messages.first.chat_message_id - chat_message_seen_id;
    }
  }
}

class ChatMembershipCollection
    extends entity.ChatMembershipCollection<ChatMembership> {}
