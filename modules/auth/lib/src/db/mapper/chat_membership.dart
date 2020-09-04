part of auth.mapper;

class ChatMembershipMapper
    extends Mapper<ChatMembership, ChatMembershipCollection, App> {
  String table = 'chat_membership';

  ChatMembershipMapper(m) : super(m);

  Future<ChatMembershipCollection> findAllByRoom(int room_id) =>
      loadC(selectBuilder()
        ..where('chat_room_id = @room_id')
        ..setParameter('room_id', room_id));

  Future<ChatMembership> findByRoomAndUser(int room_id, int user_id) =>
      loadE(selectBuilder()
        ..where('chat_room_id = @room_id', 'user_id = @user_id')
        ..setParameter('room_id', room_id)
        ..setParameter('user_id', user_id));

  Future<ChatMembershipCollection> findAllByMessageSeen(int message_id,
          [bool noContext = true]) =>
      loadC(selectBuilder()
        ..where('chat_message_seen_id = @m')
        ..orderBy('chat_membership_id', 'ASC')
        ..setParameter('m', message_id));

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

  Future<User> loadUser() async => user = await manager.app.user.find(user_id);
}

class ChatMembershipCollection
    extends entity.ChatMembershipCollection<ChatMembership> {}
