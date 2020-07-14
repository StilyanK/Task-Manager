part of auth.entity;

@MSerializable()
class ChatMessage {
  int chat_message_id;

  int chat_room_id;

  int user_id;

  DateTime timestamp;

  String content;

  int type;

  User user;

  ChatRoom room;

  ChatMessage();

  void init(Map data) => _$ChatMessageFromMap(this, data);

  Map<String, dynamic> toMap() => _$ChatMessageToMap(this);

  Map<String, dynamic> toJson() => _$ChatMessageToMap(this, true);
}

class ChatMessageCollection<E extends ChatMessage> extends Collection<E> {}
