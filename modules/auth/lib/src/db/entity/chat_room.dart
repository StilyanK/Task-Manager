part of auth.entity;

@MSerializable()
class ChatRoom {
  int chat_room_id;

  String name;

  String context;

  ChatMembershipCollection members;

  ChatRoom();

  void init(Map data) => _$ChatRoomFromMap(this, data);

  Map<String, dynamic> toMap() => _$ChatRoomToMap(this);

  Map<String, dynamic> toJson() => _$ChatRoomToMap(this, true);

  Future<int> loadUnseen(int chat_message_seen_id) async => null;
}

class ChatRoomCollection<E extends ChatRoom> extends Collection<E> {}
