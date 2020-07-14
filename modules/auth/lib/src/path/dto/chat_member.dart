part of auth.path;

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
