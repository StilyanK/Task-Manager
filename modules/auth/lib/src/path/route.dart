// ignore_for_file: type_annotate_public_apis, always_declare_return_types
part of auth.path;

class RoutesU {
  static get isLogged => UrlPattern(r'(.*)');
  static get login => UrlPattern(r'/login');
  static get forgotten => UrlPattern(r'/forgotten');
  static get logout => UrlPattern(r'/logout');
  static get itemGet => UrlPattern(r'/auth/user/item/get');
  static get itemSave => UrlPattern(r'/auth/user/item/save');
  static get itemSaveProfile => UrlPattern(r'/auth/user/item/save-profile');
  static get itemDelete => UrlPattern(r'/auth/user/item/delete');
  static get itemPassword => UrlPattern(r'/auth/user/item/password');
  static get collectionGet => UrlPattern(r'/auth/user/collection/get');
  static get collectionDelete =>
      UrlPattern(r'/auth/user/collection/delete');
  static get collectionPair => UrlPattern(r'/auth/user/collection/pair');
  static get settings => UrlPattern(r'/auth/settings/save');
  static get image_resize =>
      UrlPattern(r'/(media|tmp)/image(\d+)x(\d+)/(.*)');
  static get file => UrlPattern(r'/(media|tmp)/(.*)');
  static get collectionSuggest =>
      UrlPattern(r'/auth/user/collection/suggest');
}

class RoutesG {
  static get itemGet => UrlPattern(r'/auth/group/item/get');
  static get itemSave => UrlPattern(r'/auth/group/item/save');
  static get itemDelete => UrlPattern(r'/auth/group/item/delete');
  static get itemInit => UrlPattern(r'/auth/group/item/init');
  static get collectionGet => UrlPattern(r'/auth/group/collection/get');
  static get collectionDelete =>
      UrlPattern(r'/auth/group/collection/delete');
  static get collectionPair => UrlPattern(r'/auth/group/collection/pair');
}

class RoutesN {
  static get userNotificationsPersist =>
      UrlPattern(r'/auth/user/notifications/persist');
  static get userNotificationsMarkRead =>
      UrlPattern(r'/auth/user/notifications/mark/read');
  static get userNotificationsMarkUnread =>
      UrlPattern(r'/auth/user/notifications/mark/unread');
  static get userNotificationsArchive =>
      UrlPattern(r'/auth/user/notifications/arhive');
  static get userNotificationsRecent =>
      UrlPattern(r'/auth/user/notifications/recent');
  static get userNotificationsUnread =>
      UrlPattern(r'/auth/user/notifications/unread');
  static get userNotificationRemove =>
      UrlPattern(r'/auth/user/notification/remove');
}

class CRouter {
  static get itemGet => UrlPattern(r'/user/event/item/get');
  static get itemSave => UrlPattern(r'/user/event/item/save');
  static get itemPersist => UrlPattern(r'/user/event/item/persist');
  static get itemDelete => UrlPattern(r'/user/event/item/delete');
  static get collection => UrlPattern(r'/user/event/collection/get');
}

class RoutesChat {
  static get createRoom => UrlPattern(r'/user/chat/room/create');
  static get loadRooms => UrlPattern(r'/user/chat/room/list');
  static get loadUnread => UrlPattern(r'/user/chat/unread');
  static get loadRoomMessages => UrlPattern(r'/user/chat/room/messages');
  static get loadRoomMessagesNew =>
      UrlPattern(r'/user/chat/room/messages_new');
  static get messagePersist => UrlPattern(r'/user/chat/message/persist');
  static get messageUpdate => UrlPattern(r'/user/chat/message/update');
  static get messageMarkSeen => UrlPattern(r'/user/chat/message/seen');
  static get messageType => UrlPattern(r'/user/chat/message/write');
  static String roomCreated = 'chat:room:create';
  static String roomUpdated = 'chat:room:update';
  static String messageCreated = 'chat:message:create';
  static String messageUpdated = 'chat:message:update';
  static String messageTyping = 'chat:message:type';
  static String messageSeen = 'chat:message:seen';
}
