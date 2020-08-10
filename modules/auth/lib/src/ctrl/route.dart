part of auth.ctrl;

void routesUser(Router router) {
  router.filter(RoutesU.isLogged,
          (req) => CLogin(req).isLogged());
  router
      .serve(RoutesU.login)
      .listen((req) => CLogin(req).login());
  router
      .serve(RoutesU.forgotten)
      .listen((req) => CLogin(req).forgotten());
  router
      .serve(RoutesU.logout)
      .listen((req) => CLogin(req).logout());
  router
      .serve(RoutesU.itemGet, method: 'POST')
      .listen((req) => IUser(req).get());
  router
      .serve(RoutesU.itemSave, method: 'POST')
      .listen((req) => IUser(req).save());
  router
      .serve(RoutesU.itemSaveProfile, method: 'POST')
      .listen((req) => IUser(req).saveProfile());
  router
      .serve(RoutesU.itemDelete, method: 'POST')
      .listen((req) => IUser(req).delete());
  router
      .serve(RoutesU.itemPassword, method: 'POST')
      .listen((req) => IUser(req).password());
  router
      .serve(RoutesU.collectionGet, method: 'POST')
      .listen((req) => CUser(req).get());
  router
      .serve(RoutesU.collectionDelete, method: 'POST')
      .listen((req) => CUser(req).delete());
  router
      .serve(RoutesU.collectionPair, method: 'POST')
      .listen((req) => CUser(req).pair());
  router
      .serve(RoutesU.collectionSuggest, method: 'POST')
      .listen((req) => CUser(req).suggest());
  router
      .serve(RoutesU.settings, method: 'POST')
      .listen((req) => IUser(req).settingsSave());
  router
      .serve(RoutesU.image_resize, method: 'GET')
      .listen((req) => CAsset(req).outputImageResize());
  router
      .serve(RoutesU.file, method: 'GET')
      .listen((req) => CAsset(req).outputMedia());
}

void routesGroup(Router router) {
  router
      .serve(RoutesG.itemGet, method: 'POST')
      .listen((req) => IGroup(req).get());
  router
      .serve(RoutesG.itemSave, method: 'POST')
      .listen((req) => IGroup(req).save());
  router
      .serve(RoutesG.itemDelete, method: 'POST')
      .listen((req) => IGroup(req).delete());
  router
      .serve(RoutesG.itemInit, method: 'POST')
      .listen((req) => IGroup(req).init());
  router
      .serve(RoutesG.collectionGet, method: 'POST')
      .listen((req) => CGroup(req).get());
  router
      .serve(RoutesG.collectionDelete, method: 'POST')
      .listen((req) => CGroup(req).delete());
  router
      .serve(RoutesG.collectionPair, method: 'POST')
      .listen((req) => CGroup(req).pair());
}

void routesCalendar(Router router) {
  router
      .serve(CRouter.itemGet, method: 'POST')
      .listen((req) => ICalendar(req).get());
  router
      .serve(CRouter.itemSave, method: 'POST')
      .listen((req) => ICalendar(req).save());
  router
      .serve(CRouter.itemPersist, method: 'POST')
      .listen((req) => ICalendar(req).persist());
  router
      .serve(CRouter.itemDelete, method: 'POST')
      .listen((req) => ICalendar(req).delete());
  router
      .serve(CRouter.collection, method: 'POST')
      .listen((req) => CCalendar(req).getEvents());
}

void routesNotifications(Router router) {
  router
      .serve(RoutesN.userNotificationsPersist, method: 'POST')
      .listen((req) => CNotification(req).persist());
  router
      .serve(RoutesN.userNotificationsArchive, method: 'POST')
      .listen((req) => CNotification(req).archive());
  router
      .serve(RoutesN.userNotificationsRecent, method: 'POST')
      .listen((req) => CNotification(req).recent());
  router
      .serve(RoutesN.userNotificationsUnread, method: 'POST')
      .listen((req) => CNotification(req).unread());
  router
      .serve(RoutesN.userNotificationRemove, method: 'POST')
      .listen((req) => CNotification(req).remove());
  router
      .serve(RoutesN.userNotificationsMarkRead, method: 'POST')
      .listen((req) => CNotification(req).markRead());
  router
      .serve(RoutesN.userNotificationsMarkUnread, method: 'POST')
      .listen((req) => CNotification(req).markUnRead());
}

void routesChat(Router router) {
  router
      .serve(RoutesChat.createRoom, method: 'POST')
      .listen((req) => CChat(req).createRoom());
  router
      .serve(RoutesChat.loadRooms, method: 'POST')
      .listen((req) => CChat(req).loadRooms());
  router
      .serve(RoutesChat.loadRoomMessages, method: 'POST')
      .listen((req) => CChat(req).loadMessages());
  router
      .serve(RoutesChat.loadRoomMessagesNew, method: 'POST')
      .listen((req) => CChat(req).loadMessagesNew());
  router
      .serve(RoutesChat.messagePersist, method: 'POST')
      .listen((req) => CChat(req).messagePersist());
  router
      .serve(RoutesChat.messageSeen, method: 'POST')
      .listen((req) => CChat(req).messageSeen());
}
