part of auth.entity;

@MSerializable()
class UserEvent with Event {
  int user_id;
  String title;
  String description;
  DateTime date_created;
  DateTime date_modified;

  UserEvent();

  void init(Map data) => _$UserEventFromMap(this, data);

  Map<String, dynamic> toMap() => _$UserEventToMap(this);

  Map<String, dynamic> toJson() => _$UserEventToMap(this, true);
}

class UserEventCollection<E extends UserEvent> extends Collection<E> {}
