part of auth.path;

@DTOSerializable()
class ChatMessageDTO {
  int id;
  ChatMemberDTO member;
  int room_id;
  String content;
  DateTime timestamp;

  ChatMessageDTO();

  factory ChatMessageDTO.fromMap(Map data) => _$ChatMessageDTOFromMap(data);

  Map toMap() => _$ChatMessageDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatMessageLoadDTO {
  int room_id;
  int lsm_id;

  ChatMessageLoadDTO();

  factory ChatMessageLoadDTO.fromMap(Map data) =>
      _$ChatMessageLoadDTOFromMap(data);

  Map toMap() => _$ChatMessageLoadDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatMessagePersistDTO {
  String content;
  ChatMemberDTO member;
  int room_id;
  DateTime timestamp;

  ChatMessagePersistDTO();

  factory ChatMessagePersistDTO.fromMap(Map data) =>
      _$ChatMessagePersistDTOFromMap(data);

  Map toMap() => _$ChatMessagePersistDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatMessageSeenDTO {
  int id;
  int room_id;

  ChatMessageSeenDTO();

  factory ChatMessageSeenDTO.fromMap(Map data) =>
      _$ChatMessageSeenDTOFromMap(data);

  Map toMap() => _$ChatMessageSeenDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatMessageChangeEventDTO {
  int room_id;
  String room_context;
  int unseen;
  String message;
  int user_id;
  String name;
  String profile;

  ChatMessageChangeEventDTO();

  factory ChatMessageChangeEventDTO.fromMap(Map data) =>
      _$ChatMessageChangeEventDTOFromMap(data);

  Map toMap() => _$ChatMessageChangeEventDTOToMap(this);

  Map toJson() => toMap();
}
