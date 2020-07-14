part of auth.mapper;

class UserGroupMapper extends Mapper<UserGroup, UserGroupCollection, App> {
  String table = 'user_group';

  UserGroupMapper(m) : super(m);

  Future<bool> deleteById(dynamic id) {
    if (id == 1) throw Exception('Admin Group');
    return super.deleteById(id);
  }

  CollectionBuilder<UserGroup, UserGroupCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (FilterRule()
        ..eq = [entity.$UserGroup.user_group_id]
        ..llike = [entity.$UserGroup.name]);
    return cb;
  }
}

class UserGroup extends entity.UserGroup with Entity<App> {}

class UserGroupCollection extends entity.UserGroupCollection<UserGroup> {}
