part of auth.mapper;

class UserEventMapper extends Mapper<UserEvent, UserEventCollection, App> {
  String table = 'user_event';
  dynamic pkey = 'id';

  UserEventMapper(m) : super(m);

  Future<UserEventCollection> getRange(DateTime d1, DateTime d2,
      [int user_id]) {
    final q = selectBuilder()
      ..where('(date_start BETWEEN @d1 AND @d2) '
          'OR (date_end BETWEEN @d1 AND @d2) '
          'OR ((date_start <= @d1 OR date_start IS null) '
          'AND (date_end >= @d2 OR date_end IS null))')
      ..setParameter('d1', d1)
      ..setParameter('d2', d2);
    if (user_id != null)
      q
        ..andWhere('user_id = @user_id')
        ..setParameter('user_id', user_id);
    return loadC(q);
  }
}

class UserEvent extends entity.UserEvent with Entity<App> {}

class UserEventCollection extends entity.UserEventCollection<UserEvent> {}
