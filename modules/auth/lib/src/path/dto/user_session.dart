part of auth.path;

@DTOSerializable()
class UserSessionDTO {
  String username;
  int user_id;
  int user_group_id;
  String name;
  String picture;
  String mail;
  Map settings;
  Map permissions;

  UserSessionDTO();

  factory UserSessionDTO.fromMap(Map data) => _$UserSessionDTOFromMap(data);

  Map toMap() => _$UserSessionDTOToMap(this);

  Map toJson() => toMap();

  String get session => settings['session'];

  String get uin => settings['uin'];

  String get nin => settings['nin'];

  String get dpt => settings['dpt'];

  String get medicalCenter => settings['medical_center'];

  List<Department> get departments =>
      settings['departments']
          ?.map<Department>((d) => Department(
              d['code'], d['type'], d['specialties']?.cast<String>() ?? []))
          ?.toList() ??
      [];

  int get timeRate => settings['time_rate'];

  String get timezone => settings['timezone'] ?? 'Europe/Sofia';

  String get locale => settings['language'];

  bool isAdministrator() => user_group_id == AccountGroup.Administrator;

  bool isUser() => user_group_id == AccountGroup.User;
}

class Department {
  final String code;
  final String type;
  final List<String> specialties;

  Department(this.code, this.type, this.specialties);
}
