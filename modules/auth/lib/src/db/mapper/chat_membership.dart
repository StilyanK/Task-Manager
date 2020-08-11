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

  Future<ChatMembershipCollection> findAllByUser(int user_id,
      [bool noContext = true]) {
    final q = selectBuilder('chat_membership.*')
      ..where('user_id = @user_id', 'timestamp_leave IS NULL')
      ..orderBy('chat_membership_id', 'ASC')
      ..setParameter('user_id', user_id);
    if (noContext)
      q.join('chat_room cr',
          'cr.chat_room_id = chat_membership.chat_room_id AND context IS NULL');
    return loadC(q);
  }
}

class ChatMembership extends entity.ChatMembership with Entity<App> {
  Future<ChatRoom> loadRoom() async =>
      room = await manager.app.chat_room.find(chat_room_id);

  Future<UserCollection> loadUsers() async {
    final col = await manager.app.chat_membership.findAllByRoom(chat_room_id);
    users = UserCollection();
    for (final cm in col) users.add(await manager.app.user.find(cm.user_id));
    return users;
  }

  Future<int> loadQuantity() async =>
      manager.app.chat_message.loadCount(chat_room_id);

  Future<int> loadUnseen() async {
    final messages = (chat_message_seen_id == null)
        ? await manager.app.chat_message.loadRecent(chat_room_id, 0)
        : await manager.app.chat_message
            .loadNew(chat_room_id, chat_message_seen_id);
    return messages.length;
  }
}

class ChatMembershipCollection
    extends entity.ChatMembershipCollection<ChatMembership> {}
