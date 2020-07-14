library auth.user.service;

import 'dart:async';
import 'dart:math';

import 'package:mapper/mapper.dart';

import '../mapper.dart';
import '../path.dart';
import 'permission.dart';

class UserService {
  User user;

  UserSession session;

  Manager<App> manager;

  UserService(Manager man) {
    manager = man.convert(App());
  }

  Future loadUserByUser(String username) async =>
      user = await manager.app.user.findByUsername(username);

  Future loadUserByUserPass(String username, String password) async {
    user = await manager.app.user.findByUsername(username);
    if (user != null && user.active && !user.checkPassword(password))
      user = null;
    return user;
  }

  Future<String> genereatePassword() async {
    String password;
    user.password = user.getPassword(password = _generatePassword());
    await manager.app.user.update(user);
    return password;
  }

  String _generatePassword([int length = 8]) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGH'
        'IJKLMNOPQRSTUVWXYZ0123456789!@#[]%^&';
    final count = chars.split('').length - 1;
    final rand = Random();
    final pass = StringBuffer();
    var i = 0;
    while (i <= length) {
      final rn = rand.nextInt(count);
      pass.write(chars.substring(rn, rn + 1));
      i++;
    }
    return pass.toString();
  }

  Future loadUserByUserIPAddress(String username, String ipAddress) async =>
      user = null;

  Future loadUserBySession(String sessid) async {
    session = await manager.app.user_session.findBySession(sessid);
    if (session != null) user = await session.loadUser();
  }

  Future<void> updateUserSession(UserSessionDTO session) async {
    final user = await manager.app.user.find(session.user_id);
    final userSession =
        await manager.app.user_session.findBySession(session.session);
    user.settings = session.settings;
    userSession.data = session.settings;
    await manager.app.user.update(user);
    await manager.app.user_session.update(userSession);
  }

  Future<UserSessionDTO> loadUserSessionFromSession() async {
    final sess = await loadUserSessionFromUser();
    if (session.data != null) sess.settings = session.data;
    return sess;
  }

  Future<UserSessionDTO> loadUserSessionFromUser() async {
    if (user == null) return null;
    final group = await user.loadUserGroup();

    return UserSessionDTO()
      ..username = user.username
      ..user_id = user.user_id
      ..user_group_id = user.user_group_id
      ..name = user.name
      ..picture = (user.picture != null)
          ? 'media/image100x100/user/${user.user_id}/${user.picture}'
          : null
      ..mail = user.mail
      ..settings = user.settings
      ..permissions = user.user_group_id == 1
          ? null
          : PermissionManager()
              .permission(user.user_group_id)
              .merge(group.permissions);
  }
}
