part of auth.entity;

@MSerializable()
class UserGroup {
  int user_group_id;

  String name;

  Map permissions;

  UserGroup();

  void init(Map data) => _$UserGroupFromMap(this, data);

  Map<String, dynamic> toMap() => _$UserGroupToMap(this);

  Map<String, dynamic> toJson() => _$UserGroupToMap(this, true);
}

class UserGroupCollection<E extends UserGroup> extends Collection<E> {
  List<Map> pair() => map((g) => {'k': g.user_group_id, 'v': g.name}).toList();
}
