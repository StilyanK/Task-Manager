part of auth.generator;

class UserDTO {
  String username;
  String password;
  int userGroup;
  String name;
  String email;
  String nin;
  String uin;
}

//TODO MC code

Future<void> insertUser(Manager mgr, UserDTO dto) async {
  final Manager<App> manager = mgr.convert(App());

  final bc = DBCrypt();
  final pass = bc.hashpw(dto.password, bc.gensalt());

  final user = manager.app.user.createObject()
    ..name = dto.name
    ..username = dto.username
    ..password = pass
    ..user_group_id = dto.userGroup
    ..mail = dto.email
    ..active = true
    ..hidden = false
    ..settings = {
      'theme': 'main',
      'language': 'bg_BG',
      //'specialty': '06',
      //'medical_center': mc.code,
      'timezone': 'Europe/Sofia',
      'uin': dto.uin,
      'nin': dto.nin,
      'access': [],
    };

  await manager.app.user.insert(user);
  user.settings.addAll(await updateSession(manager, user));
  await manager.app.user.update(user);
}
