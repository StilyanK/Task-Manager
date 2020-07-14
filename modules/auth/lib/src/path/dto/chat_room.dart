part of auth.path;

@DTOSerializable()
class ChatRoomDTO {
  int room_id;
  String title;
  List<ChatMemberDTO> members;
  int lsm_id;
  int unseen;

  ChatRoomDTO();

  factory ChatRoomDTO.fromMap(Map data) => _$ChatRoomDTOFromMap(data);

  Map toMap() => _$ChatRoomDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatRoomCreateDTO {
  List<ChatMemberDTO> members;

  ChatRoomCreateDTO();

  factory ChatRoomCreateDTO.fromMap(Map data) =>
      _$ChatRoomCreateDTOFromMap(data);

  Map toMap() => _$ChatRoomCreateDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatRoomChangeEventDTO {
  int room_id;
  String room_context;

  ChatRoomChangeEventDTO();

  factory ChatRoomChangeEventDTO.fromMap(Map data) =>
      _$ChatRoomChangeEventDTOFromMap(data);

  Map toMap() => _$ChatRoomChangeEventDTOToMap(this);

  Map toJson() => toMap();
}
