part of auth.entity;

@MSerializable()
class UserSession {
  int user_id;

  String session;

  DateTime date_start;

  DateTime date_end;

  Map data;

  UserSession();

  void init(Map data) => _$UserSessionFromMap(this, data);

  Map<String, dynamic> toMap() => _$UserSessionToMap(this);

  Map<String, dynamic> toJson() => _$UserSessionToMap(this, true);

  Future<User> loadUser() async => null;
}

class UserSessionCollection<E extends UserSession> extends Collection<E> {}
