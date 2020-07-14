part of auth.path;

@DTOSerializable()
class PasswordDTO {
  int id;
  String password;

  PasswordDTO();

  factory PasswordDTO.fromMap(Map data) => _$PasswordDTOFromMap(data);

  Map toMap() => _$PasswordDTOToMap(this);

  Map toJson() => toMap();
}
