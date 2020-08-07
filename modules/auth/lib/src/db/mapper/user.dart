part of auth.mapper;

class UserMapper extends Mapper<User, UserCollection, App> {
  String table = 'user';

  UserMapper(m) : super(m);

  Future<bool> deleteById(dynamic id) => Future.sync(() {
        if (id == 1)
          throw Exception('Admin User');
        else
          return super.deleteById(id);
      });

  Future<UserCollection> findAllByGroupId(int groupId) =>
      findWhere<UserCollection>([Equals(entity.$User.user_group_id, groupId)]);

  Future<UserCollection> findAll() =>
      loadC(selectBuilder()..addOrderBy('user_id', 'ASC'));

  Future<User> findByUsername(String username) =>
      findWhere<User>([Equals(entity.$User.username, username)]);

  Future<User> findByUin(String uin) => loadE(selectBuilder()
    ..where('settings->>\'uin\' = @uin')
    ..setParameter('uin', uin));

  CollectionBuilder<User, UserCollection, App> findAllByBuilder([String uin]) {
    //'uin': 'settings->>\'uin\''
    final b = selectBuilder();
    if (uin != null)
      b
        ..where('${entity.$User.settings}->>\'uin\' = @uin')
        ..setParameter('uin', uin);
    final cb = collectionBuilder(b)
      ..filterRule = (FilterRule()
        ..eq = [entity.$User.user_group_id, entity.$User.active]
        ..like = [entity.$User.username, entity.$User.name, entity.$User.mail]
        ..map = {
          'group': entity.$User.user_group_id,
        });
    return cb;
  }

  Future<UserCollection> findBySuggestion(String s) => loadC(selectBuilder()
    ..where('to_tsvector(coalesce(name,\'\')) '
        '|| to_tsvector(coalesce(username,\'\')) @@ to_tsquery(@p1)')
    ..andWhere('"active" = TRUE')
    ..andWhere('"hidden" = FALSE')
    ..setParameter('p1', TSquery(s).toString())
    ..limit(10));
}

class User extends entity.User with Entity<App> {
  UserGroup user_group;

  Future<UserGroup> loadUserGroup() async =>
      user_group = await manager.app.user_group.find(user_group_id);

  String getPassword(String password) {
    final bc = DBCrypt();
    return bc.hashpw(password, bc.gensalt());
  }

  bool checkPassword(String password) {
    if (password == null || password.isEmpty || this.password == null)
      return false;
    final bc = DBCrypt();
    return bc.checkpw(password, this.password);
  }
}

class UserCollection extends entity.UserCollection<User> {}
