part of auth.entity;

@MSerializable()
class UserNotification {
  int user_notification_id;

  int user_id;

  int notification_id;

  bool read;

  base.Notification notification;

  UserNotification();

  void init(Map data) => _$UserNotificationFromMap(this, data);

  Map<String, dynamic> toMap() => _$UserNotificationToMap(this);

  Map<String, dynamic> toJson() => _$UserNotificationToMap(this, true);
}

class UserNotificationCollection<E extends UserNotification>
    extends Collection<E> {}
