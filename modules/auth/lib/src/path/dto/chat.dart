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
  int type;
  ChatMemberDTO member;
  List<ChatMemberDTO> seen;
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
  bool status;

  ChatMemberDTO();

  factory ChatMemberDTO.fromMap(Map data) => _$ChatMemberDTOFromMap(data);

  Map toMap() => _$ChatMemberDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class ChatOfferDTO {
  int from;
  int to;
  bool isAnswer;
  Map description;

  ChatOfferDTO();

  factory ChatOfferDTO.fromMap(Map data) => _$ChatOfferDTOFromMap(data);

  Map toMap() => _$ChatOfferDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class IceCandidateDTO {
  int from;
  int to;
  Map candidate;

  IceCandidateDTO();

  factory IceCandidateDTO.fromMap(Map data) => _$IceCandidateDTOFromMap(data);

  Map toMap() => _$IceCandidateDTOToMap(this);

  Map toJson() => toMap();
}

