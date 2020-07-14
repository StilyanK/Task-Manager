part of auth.mapper;

class UserNotificationMapper
    extends Mapper<UserNotification, UserNotificationCollection, App> {
  String table = 'user_notification';

  UserNotificationMapper(m) : super(m);

  Future<UserNotificationCollection> findByUser(
          int user_id, DateTime start, DateTime end) =>
      loadC(selectBuilder('user_notification.*')
        ..join('base_notification bn',
            'bn.notification_id = user_notification.notification_id')
        ..where('user_id = @user_id')
        ..andWhere('date >= @start AND date < @end')
        ..orderBy('user_notification.user_notification_id', 'DESC')
        ..setParameter('user_id', user_id)
        ..setParameter('start', start)
        ..setParameter('end', end));

  Future<UserNotificationCollection> recent(int user_id, [int limit = 5]) =>
      loadC(selectBuilder()
        ..where('user_id = @user_id')
        ..orderBy('user_notification_id', 'DESC')
        ..limit(limit)
        ..setParameter('user_id', user_id));

  Future<int> unread(int user_id) =>
      execute(selectBuilder('COUNT(user_notification_id) AS unread')
            ..where('user_id = @user_id', 'read = FALSE')
            ..setParameter('user_id', user_id))
          .then((res) => res[0]['unread']);
}

class UserNotification extends entity.UserNotification with Entity<App> {
  Future<base.Notification> loadNotification() async =>
      notification = await manager.app.notification.find(notification_id);
}

class UserNotificationCollection
    extends entity.UserNotificationCollection<UserNotification> {}
