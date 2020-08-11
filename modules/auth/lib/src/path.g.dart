// GENERATED CODE - DO NOT MODIFY BY HAND

part of auth.path;

// **************************************************************************
// DTOSerializableGenerator
// **************************************************************************

abstract class $ChatRoomDTO {
  static const String room_id = 'room_id';
  static const String context = 'context';
  static const String title = 'title';
  static const String members = 'members';
  static const String lsm_id = 'lsm_id';
  static const String unseen = 'unseen';
  static const String messages = 'messages';
}

ChatRoomDTO _$ChatRoomDTOFromMap(Map data) => new ChatRoomDTO()
  ..room_id = data[$ChatRoomDTO.room_id]
  ..context = data[$ChatRoomDTO.context]
  ..title = data[$ChatRoomDTO.title]
  ..members = (data[$ChatRoomDTO.members] as List)
      ?.map((v0) => v0 == null ? null : new ChatMemberDTO.fromMap(v0))
      ?.toList()
  ..lsm_id = data[$ChatRoomDTO.lsm_id]
  ..unseen = data[$ChatRoomDTO.unseen]
  ..messages = data[$ChatRoomDTO.messages];

Map<String, dynamic> _$ChatRoomDTOToMap(ChatRoomDTO obj) => <String, dynamic>{
      $ChatRoomDTO.room_id: obj.room_id,
      $ChatRoomDTO.context: obj.context,
      $ChatRoomDTO.title: obj.title,
      $ChatRoomDTO.members: obj.members == null
          ? null
          : new List.generate(
              obj.members.length, (i0) => obj.members[i0]?.toMap()),
      $ChatRoomDTO.lsm_id: obj.lsm_id,
      $ChatRoomDTO.unseen: obj.unseen,
      $ChatRoomDTO.messages: obj.messages
    };

abstract class $ChatMessageDTO {
  static const String id = 'id';
  static const String member = 'member';
  static const String room_id = 'room_id';
  static const String context = 'context';
  static const String content = 'content';
  static const String timestamp = 'timestamp';
}

ChatMessageDTO _$ChatMessageDTOFromMap(Map data) => new ChatMessageDTO()
  ..id = data[$ChatMessageDTO.id]
  ..member = data[$ChatMessageDTO.member] == null
      ? null
      : new ChatMemberDTO.fromMap(data[$ChatMessageDTO.member])
  ..room_id = data[$ChatMessageDTO.room_id]
  ..context = data[$ChatMessageDTO.context]
  ..content = data[$ChatMessageDTO.content]
  ..timestamp = data[$ChatMessageDTO.timestamp] is String
      ? DateTime.tryParse(data[$ChatMessageDTO.timestamp])
      : data[$ChatMessageDTO.timestamp];

Map<String, dynamic> _$ChatMessageDTOToMap(ChatMessageDTO obj) =>
    <String, dynamic>{
      $ChatMessageDTO.id: obj.id,
      $ChatMessageDTO.member: obj.member?.toMap(),
      $ChatMessageDTO.room_id: obj.room_id,
      $ChatMessageDTO.context: obj.context,
      $ChatMessageDTO.content: obj.content,
      $ChatMessageDTO.timestamp: obj.timestamp?.toIso8601String()
    };

abstract class $ChatMemberDTO {
  static const String user_id = 'user_id';
  static const String name = 'name';
  static const String picture = 'picture';
}

ChatMemberDTO _$ChatMemberDTOFromMap(Map data) => new ChatMemberDTO()
  ..user_id = data[$ChatMemberDTO.user_id]
  ..name = data[$ChatMemberDTO.name]
  ..picture = data[$ChatMemberDTO.picture];

Map<String, dynamic> _$ChatMemberDTOToMap(ChatMemberDTO obj) =>
    <String, dynamic>{
      $ChatMemberDTO.user_id: obj.user_id,
      $ChatMemberDTO.name: obj.name,
      $ChatMemberDTO.picture: obj.picture
    };

abstract class $PasswordDTO {
  static const String id = 'id';
  static const String password = 'password';
}

PasswordDTO _$PasswordDTOFromMap(Map data) => new PasswordDTO()
  ..id = data[$PasswordDTO.id]
  ..password = data[$PasswordDTO.password];

Map<String, dynamic> _$PasswordDTOToMap(PasswordDTO obj) => <String, dynamic>{
      $PasswordDTO.id: obj.id,
      $PasswordDTO.password: obj.password
    };

abstract class $SettingsDTO {
  static const String settings = 'settings';
}

SettingsDTO _$SettingsDTOFromMap(Map data) =>
    new SettingsDTO()..settings = data[$SettingsDTO.settings];

Map<String, dynamic> _$SettingsDTOToMap(SettingsDTO obj) =>
    <String, dynamic>{$SettingsDTO.settings: obj.settings};

abstract class $UserSessionDTO {
  static const String username = 'username';
  static const String user_id = 'user_id';
  static const String user_group_id = 'user_group_id';
  static const String name = 'name';
  static const String picture = 'picture';
  static const String mail = 'mail';
  static const String settings = 'settings';
  static const String permissions = 'permissions';
}

UserSessionDTO _$UserSessionDTOFromMap(Map data) => new UserSessionDTO()
  ..username = data[$UserSessionDTO.username]
  ..user_id = data[$UserSessionDTO.user_id]
  ..user_group_id = data[$UserSessionDTO.user_group_id]
  ..name = data[$UserSessionDTO.name]
  ..picture = data[$UserSessionDTO.picture]
  ..mail = data[$UserSessionDTO.mail]
  ..settings = data[$UserSessionDTO.settings]
  ..permissions = data[$UserSessionDTO.permissions];

Map<String, dynamic> _$UserSessionDTOToMap(UserSessionDTO obj) =>
    <String, dynamic>{
      $UserSessionDTO.username: obj.username,
      $UserSessionDTO.user_id: obj.user_id,
      $UserSessionDTO.user_group_id: obj.user_group_id,
      $UserSessionDTO.name: obj.name,
      $UserSessionDTO.picture: obj.picture,
      $UserSessionDTO.mail: obj.mail,
      $UserSessionDTO.settings: obj.settings,
      $UserSessionDTO.permissions: obj.permissions
    };

abstract class $EventPersistDTO {
  static const String id = 'id';
  static const String date_start = 'date_start';
  static const String date_end = 'date_end';
  static const String recurring_persist_exclude = 'recurring_persist_exclude';
  static const String recurring_persist = 'recurring_persist';
}

EventPersistDTO _$EventPersistDTOFromMap(Map data) => new EventPersistDTO()
  ..id = data[$EventPersistDTO.id]
  ..date_start = data[$EventPersistDTO.date_start] is String
      ? DateTime.tryParse(data[$EventPersistDTO.date_start])
      : data[$EventPersistDTO.date_start]
  ..date_end = data[$EventPersistDTO.date_end] is String
      ? DateTime.tryParse(data[$EventPersistDTO.date_end])
      : data[$EventPersistDTO.date_end]
  ..recurring_persist_exclude =
      data[$EventPersistDTO.recurring_persist_exclude] is String
          ? DateTime.tryParse(data[$EventPersistDTO.recurring_persist_exclude])
          : data[$EventPersistDTO.recurring_persist_exclude]
  ..recurring_persist = data[$EventPersistDTO.recurring_persist];

Map<String, dynamic> _$EventPersistDTOToMap(EventPersistDTO obj) =>
    <String, dynamic>{
      $EventPersistDTO.id: obj.id,
      $EventPersistDTO.date_start: obj.date_start?.toIso8601String(),
      $EventPersistDTO.date_end: obj.date_end?.toIso8601String(),
      $EventPersistDTO.recurring_persist_exclude:
          obj.recurring_persist_exclude?.toIso8601String(),
      $EventPersistDTO.recurring_persist: obj.recurring_persist
    };

abstract class $EventDTO {
  static const String id = 'id';
  static const String title = 'title';
  static const String date_start = 'date_start';
  static const String date_end = 'date_end';
  static const String all_day = 'all_day';
  static const String type = 'type';
}

EventDTO _$EventDTOFromMap(Map data) => new EventDTO()
  ..id = data[$EventDTO.id]
  ..title = data[$EventDTO.title]
  ..date_start = data[$EventDTO.date_start] is String
      ? DateTime.tryParse(data[$EventDTO.date_start])
      : data[$EventDTO.date_start]
  ..date_end = data[$EventDTO.date_end] is String
      ? DateTime.tryParse(data[$EventDTO.date_end])
      : data[$EventDTO.date_end]
  ..all_day = data[$EventDTO.all_day]
  ..type = data[$EventDTO.type];

Map<String, dynamic> _$EventDTOToMap(EventDTO obj) => <String, dynamic>{
      $EventDTO.id: obj.id,
      $EventDTO.title: obj.title,
      $EventDTO.date_start: obj.date_start?.toIso8601String(),
      $EventDTO.date_end: obj.date_end?.toIso8601String(),
      $EventDTO.all_day: obj.all_day,
      $EventDTO.type: obj.type
    };

abstract class $RecurringDTO {
  static const String start_on = 'start_on';
  static const String end_on = 'end_on';
  static const String date_start = 'date_start';
  static const String date_end = 'date_end';
  static const String end_after = 'end_after';
  static const String repeat_type = 'repeat_type';
  static const String repeat_every = 'repeat_every';
}

RecurringDTO _$RecurringDTOFromMap(Map data) => new RecurringDTO()
  ..start_on = data[$RecurringDTO.start_on] is String
      ? DateTime.tryParse(data[$RecurringDTO.start_on])
      : data[$RecurringDTO.start_on]
  ..end_on = data[$RecurringDTO.end_on] is String
      ? DateTime.tryParse(data[$RecurringDTO.end_on])
      : data[$RecurringDTO.end_on]
  ..date_start = data[$RecurringDTO.date_start] is String
      ? DateTime.tryParse(data[$RecurringDTO.date_start])
      : data[$RecurringDTO.date_start]
  ..date_end = data[$RecurringDTO.date_end] is String
      ? DateTime.tryParse(data[$RecurringDTO.date_end])
      : data[$RecurringDTO.date_end]
  ..end_after = data[$RecurringDTO.end_after]
  ..repeat_type = data[$RecurringDTO.repeat_type]
  ..repeat_every = data[$RecurringDTO.repeat_every];

Map<String, dynamic> _$RecurringDTOToMap(RecurringDTO obj) => <String, dynamic>{
      $RecurringDTO.start_on: obj.start_on?.toIso8601String(),
      $RecurringDTO.end_on: obj.end_on?.toIso8601String(),
      $RecurringDTO.date_start: obj.date_start?.toIso8601String(),
      $RecurringDTO.date_end: obj.date_end?.toIso8601String(),
      $RecurringDTO.end_after: obj.end_after,
      $RecurringDTO.repeat_type: obj.repeat_type,
      $RecurringDTO.repeat_every: obj.repeat_every
    };
