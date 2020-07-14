part of auth.entity;

@MSerializable()
class ChatMembership {
  int chat_membership_id;

  int chat_room_id;

  int user_id;

  DateTime timestamp_join;

  DateTime timestamp_leave;

  int chat_message_seen_id;

  UserCollection users;

  ChatMembership();

  void init(Map data) => _$ChatMembershipFromMap(this, data);

  Map<String, dynamic> toMap() => _$ChatMembershipToMap(this);

  Map<String, dynamic> toJson() => _$ChatMembershipToMap(this, true);
}

class ChatMembershipCollection<E extends ChatMembership> extends Collection<E> {
}
