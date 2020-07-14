part of auth.path;

@DTOSerializable()
class SettingsDTO {
  Map settings;

  SettingsDTO();

  factory SettingsDTO.fromMap(Map data) => _$SettingsDTOFromMap(data);

  Map toMap() => _$SettingsDTOToMap(this);

  Map toJson() => toMap();
}
