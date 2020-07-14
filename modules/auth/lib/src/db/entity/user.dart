part of auth.entity;

@MSerializable()
class User {
  int user_id;

  int user_group_id;

  String username;

  String password;

  String name;

  String mail;

  bool active;

  Map settings;

  String picture;

  bool hidden;

  DateTime date_created;

  DateTime date_modified;

  User();

  String get uin => settings['uin'];

  void init(Map data) => _$UserFromMap(this, data);

  String getRepresentation() => name ?? username;

  Map<String, Object> pair() => {'k': user_id, 'v': getRepresentation()};

  Map<String, dynamic> toMap() => _$UserToMap(this);

  Map<String, dynamic> toJson() => _$UserToMap(this, true)..['password'] = null;
}

class UserCollection<E extends User> extends Collection<E> {
  List<Map> pair() =>
      map((u) => {'k': u.user_id, 'v': u.getRepresentation()}).toList();
}
