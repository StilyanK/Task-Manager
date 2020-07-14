part of auth.mapper;

class UserSessionMapper
    extends Mapper<UserSession, UserSessionCollection, App> {
  String table = 'user_session';
  dynamic pkey = [entity.$UserSession.user_id, entity.$UserSession.session];

  UserSessionMapper(m) : super(m);

  Future<UserSessionCollection> findAllByUser(int id) =>
      findWhere<UserSessionCollection>(
          [Equals(entity.$UserSession.user_id, id)]);

  Future<UserSession> findUserCurrentSession(int userId) =>
      findWhere<UserSession>([
        Equals(entity.$UserSession.user_id, userId),
        Equals(entity.$UserSession.date_end, null)
      ]);

  Future<UserSession> findBySession(String session) =>
      findWhere<UserSession>([Equals(entity.$UserSession.session, session)]);
}

class UserSession extends entity.UserSession with Entity<App> {
  User user;

  Future<User> loadUser() async => user = await manager.app.user.find(user_id);
}

class UserSessionCollection extends entity.UserSessionCollection<UserSession> {}
