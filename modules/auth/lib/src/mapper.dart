library auth.mapper;

import 'dart:async';

import 'package:cl_base/server.dart' as base;
import 'package:dbcrypt/dbcrypt.dart';
import 'package:mapper/mapper.dart';

import 'entity.dart' as entity;

part 'db/mapper/chat_attachment.dart';
part 'db/mapper/chat_membership.dart';
part 'db/mapper/chat_message.dart';
part 'db/mapper/chat_room.dart';
part 'db/mapper/event.dart';
part 'db/mapper/group.dart';
part 'db/mapper/notification.dart';
part 'db/mapper/user.dart';
part 'db/mapper/user_session.dart';

mixin AppMixin {
  Manager m;

  UserMapper get user => UserMapper(m.convert(App()))
    ..entity = (() => User())
    ..collection = () => UserCollection();

  UserSessionMapper get user_session =>
      UserSessionMapper(m.convert(App()))
        ..entity = (() => UserSession())
        ..collection = () => UserSessionCollection();

  UserGroupMapper get user_group => UserGroupMapper(m.convert(App()))
    ..entity = (() => UserGroup())
    ..collection = () => UserGroupCollection();

  UserNotificationMapper get user_notification =>
      UserNotificationMapper(m.convert(App()))
        ..entity = (() => UserNotification())
        ..collection = () => UserNotificationCollection();

  UserEventMapper get user_event => UserEventMapper(m.convert(App()))
    ..entity = (() => UserEvent())
    ..collection = () => UserEventCollection();

  ChatAttachmentMapper get chat_attachment =>
      ChatAttachmentMapper(m.convert(App()))
        ..entity = (() => ChatAttachment())
        ..collection = () => ChatAttachmentCollection();

  ChatMembershipMapper get chat_membership =>
      ChatMembershipMapper(m.convert(App()))
        ..entity = (() => ChatMembership())
        ..collection = (() => ChatMembershipCollection());

  ChatMessageMapper get chat_message =>
      ChatMessageMapper(m.convert(App()))
        ..entity = (() => ChatMessage())
        ..collection = (() => ChatMessageCollection())
        ..notifier = entityMessage;

  ChatRoomMapper get chat_room => ChatRoomMapper(m.convert(App()))
    ..entity = (() => ChatRoom())
    ..collection = (() => ChatRoomCollection())
    ..notifier = entityRoom;
}

class App extends Application with AppMixin, base.AppMixin {}

EntityNotifier<ChatRoom> entityRoom = EntityNotifier();
EntityNotifier<ChatMessage> entityMessage = EntityNotifier();
