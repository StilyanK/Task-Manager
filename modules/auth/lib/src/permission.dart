library auth.permission;

String AUTHCOOKIENAME = 'CENTRYLSESSID';

String SESSIONKEY = 'client';

abstract class AccountGroup {
  static const int Administrator = 1;
  static const int User = 2;
}

abstract class Group {
  static const String Auth = 'auth';
}

abstract class Scope {
  static const String User = 'user';
  static const String Group = 'group';
}
