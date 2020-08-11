part of auth.path;

@DTOSerializable()
class ChatRoomDTO {
  int room_id;
  String context;
  String title;
  List<ChatMemberDTO> members;
  int lsm_id;
  int unseen;
  int messages;

  ChatRoomDTO();

  factory ChatRoomDTO.fromMap(Map data) => _$ChatRoomDTOFromMap(data);

  Map toMap() => _$ChatRoomDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatMessageDTO {
  int id;
  ChatMemberDTO member;
  int room_id;
  String context;
  String content;
  DateTime timestamp;

  ChatMessageDTO();

  factory ChatMessageDTO.fromMap(Map data) => _$ChatMessageDTOFromMap(data);

  Map toMap() => _$ChatMessageDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatMemberDTO {
  int user_id;
  String name;
  String picture;

  ChatMemberDTO();

  factory ChatMemberDTO.fromMap(Map data) => _$ChatMemberDTOFromMap(data);

  Map toMap() => _$ChatMemberDTOToMap(this);

  Map toJson() => toMap();
}
