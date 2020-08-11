// GENERATED CODE - DO NOT MODIFY BY HAND

part of auth.entity;

// **************************************************************************
// EntitySerializableGenerator
// **************************************************************************

abstract class $ChatAttachment {
  static const String chat_attachment_id = 'chat_attachment_id';
  static const String chat_message_id = 'chat_message_id';
  static const String source = 'source';
  static const String name = 'name';
}

void _$ChatAttachmentFromMap(ChatAttachment obj, Map data) => obj
  ..chat_attachment_id = data[$ChatAttachment.chat_attachment_id]
  ..chat_message_id = data[$ChatAttachment.chat_message_id]
  ..source = data[$ChatAttachment.source]
  ..name = data[$ChatAttachment.name];

Map<String, dynamic> _$ChatAttachmentToMap(ChatAttachment obj,
        [asJson = false]) =>
    <String, dynamic>{
      $ChatAttachment.chat_attachment_id: obj.chat_attachment_id,
      $ChatAttachment.chat_message_id: obj.chat_message_id,
      $ChatAttachment.source: obj.source,
      $ChatAttachment.name: obj.name
    };

abstract class $ChatMembership {
  static const String chat_membership_id = 'chat_membership_id';
  static const String chat_room_id = 'chat_room_id';
  static const String user_id = 'user_id';
  static const String timestamp_join = 'timestamp_join';
  static const String timestamp_leave = 'timestamp_leave';
  static const String chat_message_seen_id = 'chat_message_seen_id';
}

void _$ChatMembershipFromMap(ChatMembership obj, Map data) => obj
  ..chat_membership_id = data[$ChatMembership.chat_membership_id]
  ..chat_room_id = data[$ChatMembership.chat_room_id]
  ..user_id = data[$ChatMembership.user_id]
  ..timestamp_join = data[$ChatMembership.timestamp_join] is String
      ? DateTime.tryParse(data[$ChatMembership.timestamp_join])
      : data[$ChatMembership.timestamp_join]
  ..timestamp_leave = data[$ChatMembership.timestamp_leave] is String
      ? DateTime.tryParse(data[$ChatMembership.timestamp_leave])
      : data[$ChatMembership.timestamp_leave]
  ..chat_message_seen_id = data[$ChatMembership.chat_message_seen_id];

Map<String, dynamic> _$ChatMembershipToMap(ChatMembership obj,
        [asJson = false]) =>
    <String, dynamic>{
      $ChatMembership.chat_membership_id: obj.chat_membership_id,
      $ChatMembership.chat_room_id: obj.chat_room_id,
      $ChatMembership.user_id: obj.user_id,
      $ChatMembership.timestamp_join:
          asJson ? obj.timestamp_join?.toIso8601String() : obj.timestamp_join,
      $ChatMembership.timestamp_leave:
          asJson ? obj.timestamp_leave?.toIso8601String() : obj.timestamp_leave,
      $ChatMembership.chat_message_seen_id: obj.chat_message_seen_id
    };

abstract class $ChatMessage {
  static const String chat_message_id = 'chat_message_id';
  static const String chat_room_id = 'chat_room_id';
  static const String user_id = 'user_id';
  static const String timestamp = 'timestamp';
  static const String content = 'content';
  static const String type = 'type';
}

void _$ChatMessageFromMap(ChatMessage obj, Map data) => obj
  ..chat_message_id = data[$ChatMessage.chat_message_id]
  ..chat_room_id = data[$ChatMessage.chat_room_id]
  ..user_id = data[$ChatMessage.user_id]
  ..timestamp = data[$ChatMessage.timestamp] is String
      ? DateTime.tryParse(data[$ChatMessage.timestamp])
      : data[$ChatMessage.timestamp]
  ..content = data[$ChatMessage.content]
  ..type = data[$ChatMessage.type];

Map<String, dynamic> _$ChatMessageToMap(ChatMessage obj, [asJson = false]) =>
    <String, dynamic>{
      $ChatMessage.chat_message_id: obj.chat_message_id,
      $ChatMessage.chat_room_id: obj.chat_room_id,
      $ChatMessage.user_id: obj.user_id,
      $ChatMessage.timestamp:
          asJson ? obj.timestamp?.toIso8601String() : obj.timestamp,
      $ChatMessage.content: obj.content,
      $ChatMessage.type: obj.type
    };

abstract class $ChatRoom {
  static const String chat_room_id = 'chat_room_id';
  static const String name = 'name';
  static const String context = 'context';
}

void _$ChatRoomFromMap(ChatRoom obj, Map data) => obj
  ..chat_room_id = data[$ChatRoom.chat_room_id]
  ..name = data[$ChatRoom.name]
  ..context = data[$ChatRoom.context];

Map<String, dynamic> _$ChatRoomToMap(ChatRoom obj, [asJson = false]) =>
    <String, dynamic>{
      $ChatRoom.chat_room_id: obj.chat_room_id,
      $ChatRoom.name: obj.name,
      $ChatRoom.context: obj.context
    };

abstract class $UserEvent {
  static const String user_id = 'user_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String date_created = 'date_created';
  static const String date_modified = 'date_modified';
  static const String id = 'id';
  static const String parent_id = 'parent_id';
  static const String type = 'type';
  static const String date_start = 'date_start';
  static const String date_end = 'date_end';
  static const String all_day = 'all_day';
  static const String recurring = 'recurring';
}

void _$UserEventFromMap(UserEvent obj, Map data) => obj
  ..user_id = data[$UserEvent.user_id]
  ..title = data[$UserEvent.title]
  ..description = data[$UserEvent.description]
  ..date_created = data[$UserEvent.date_created] is String
      ? DateTime.tryParse(data[$UserEvent.date_created])
      : data[$UserEvent.date_created]
  ..date_modified = data[$UserEvent.date_modified] is String
      ? DateTime.tryParse(data[$UserEvent.date_modified])
      : data[$UserEvent.date_modified]
  ..id = data[$UserEvent.id]
  ..parent_id = data[$UserEvent.parent_id]
  ..type = data[$UserEvent.type]
  ..date_start = data[$UserEvent.date_start] is String
      ? DateTime.tryParse(data[$UserEvent.date_start])
      : data[$UserEvent.date_start]
  ..date_end = data[$UserEvent.date_end] is String
      ? DateTime.tryParse(data[$UserEvent.date_end])
      : data[$UserEvent.date_end]
  ..all_day = data[$UserEvent.all_day]
  ..recurring = data[$UserEvent.recurring] == null
      ? null
      : new RecurringDTO.fromMap(data[$UserEvent.recurring]);

Map<String, dynamic> _$UserEventToMap(UserEvent obj, [asJson = false]) =>
    <String, dynamic>{
      $UserEvent.user_id: obj.user_id,
      $UserEvent.title: obj.title,
      $UserEvent.description: obj.description,
      $UserEvent.date_created:
          asJson ? obj.date_created?.toIso8601String() : obj.date_created,
      $UserEvent.date_modified:
          asJson ? obj.date_modified?.toIso8601String() : obj.date_modified,
      $UserEvent.id: obj.id,
      $UserEvent.parent_id: obj.parent_id,
      $UserEvent.type: obj.type,
      $UserEvent.date_start:
          asJson ? obj.date_start?.toIso8601String() : obj.date_start,
      $UserEvent.date_end:
          asJson ? obj.date_end?.toIso8601String() : obj.date_end,
      $UserEvent.all_day: obj.all_day,
      $UserEvent.recurring: obj.recurring?.toMap()
    };

abstract class $UserGroup {
  static const String user_group_id = 'user_group_id';
  static const String name = 'name';
  static const String permissions = 'permissions';
}

void _$UserGroupFromMap(UserGroup obj, Map data) => obj
  ..user_group_id = data[$UserGroup.user_group_id]
  ..name = data[$UserGroup.name]
  ..permissions = data[$UserGroup.permissions];

Map<String, dynamic> _$UserGroupToMap(UserGroup obj, [asJson = false]) =>
    <String, dynamic>{
      $UserGroup.user_group_id: obj.user_group_id,
      $UserGroup.name: obj.name,
      $UserGroup.permissions: obj.permissions
    };

abstract class $UserNotification {
  static const String user_notification_id = 'user_notification_id';
  static const String user_id = 'user_id';
  static const String notification_id = 'notification_id';
  static const String read = 'read';
}

void _$UserNotificationFromMap(UserNotification obj, Map data) => obj
  ..user_notification_id = data[$UserNotification.user_notification_id]
  ..user_id = data[$UserNotification.user_id]
  ..notification_id = data[$UserNotification.notification_id]
  ..read = data[$UserNotification.read];

Map<String, dynamic> _$UserNotificationToMap(UserNotification obj,
        [asJson = false]) =>
    <String, dynamic>{
      $UserNotification.user_notification_id: obj.user_notification_id,
      $UserNotification.user_id: obj.user_id,
      $UserNotification.notification_id: obj.notification_id,
      $UserNotification.read: obj.read
    };

abstract class $User {
  static const String user_id = 'user_id';
  static const String user_group_id = 'user_group_id';
  static const String username = 'username';
  static const String password = 'password';
  static const String name = 'name';
  static const String mail = 'mail';
  static const String active = 'active';
  static const String settings = 'settings';
  static const String picture = 'picture';
  static const String hidden = 'hidden';
  static const String date_created = 'date_created';
  static const String date_modified = 'date_modified';
}

void _$UserFromMap(User obj, Map data) => obj
  ..user_id = data[$User.user_id]
  ..user_group_id = data[$User.user_group_id]
  ..username = data[$User.username]
  ..password = data[$User.password]
  ..name = data[$User.name]
  ..mail = data[$User.mail]
  ..active = data[$User.active]
  ..settings = data[$User.settings]
  ..picture = data[$User.picture]
  ..hidden = data[$User.hidden]
  ..date_created = data[$User.date_created] is String
      ? DateTime.tryParse(data[$User.date_created])
      : data[$User.date_created]
  ..date_modified = data[$User.date_modified] is String
      ? DateTime.tryParse(data[$User.date_modified])
      : data[$User.date_modified];

Map<String, dynamic> _$UserToMap(User obj, [asJson = false]) =>
    <String, dynamic>{
      $User.user_id: obj.user_id,
      $User.user_group_id: obj.user_group_id,
      $User.username: obj.username,
      $User.password: obj.password,
      $User.name: obj.name,
      $User.mail: obj.mail,
      $User.active: obj.active,
      $User.settings: obj.settings,
      $User.picture: obj.picture,
      $User.hidden: obj.hidden,
      $User.date_created:
          asJson ? obj.date_created?.toIso8601String() : obj.date_created,
      $User.date_modified:
          asJson ? obj.date_modified?.toIso8601String() : obj.date_modified
    };

abstract class $UserSession {
  static const String user_id = 'user_id';
  static const String session = 'session';
  static const String date_start = 'date_start';
  static const String date_end = 'date_end';
  static const String data = 'data';
}

void _$UserSessionFromMap(UserSession obj, Map data) => obj
  ..user_id = data[$UserSession.user_id]
  ..session = data[$UserSession.session]
  ..date_start = data[$UserSession.date_start] is String
      ? DateTime.tryParse(data[$UserSession.date_start])
      : data[$UserSession.date_start]
  ..date_end = data[$UserSession.date_end] is String
      ? DateTime.tryParse(data[$UserSession.date_end])
      : data[$UserSession.date_end]
  ..data = data[$UserSession.data];

Map<String, dynamic> _$UserSessionToMap(UserSession obj, [asJson = false]) =>
    <String, dynamic>{
      $UserSession.user_id: obj.user_id,
      $UserSession.session: obj.session,
      $UserSession.date_start:
          asJson ? obj.date_start?.toIso8601String() : obj.date_start,
      $UserSession.date_end:
          asJson ? obj.date_end?.toIso8601String() : obj.date_end,
      $UserSession.data: obj.data
    };
