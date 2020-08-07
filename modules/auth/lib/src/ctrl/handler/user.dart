part of auth.ctrl;

class IUser extends base.Item<App, User, int> {
  final String group = Group.Auth;

  final String scope = Scope.User;

  IUser(req) : super(req, App());

  Future<Map<String, dynamic>> doGet(int id) async {
    final user = await manager.app.user.find(id);
    if (user == null) throw base.ResourceNotFoundException();
    return user.toJson();
  }

  Future<int> doSave(int id, Map data) async {
    final picture = data.remove('picture');
    final user = await manager.app.user.prepare(id, data);
    user.settings.addAll(await updateSession(manager, user));
    await manager.persist();
    if (picture['insert'] != null) {
      final sync = base.FileSync()
        ..path_from = '${base.path}/tmp'
        ..path_to = '${base.path}/media/user/${user.user_id}'
        ..file_name = picture['insert']['source'];
      user.picture = await sync.sync();
      manager.addDirty(user);
    }
    user.date_modified = DateTime.now();
    await manager.commit();
    return user.user_id;
  }

  Future<void> saveProfile() => run(null, null, null, () async {
        final body = await getData();
        final data = body['data'];
        data.remove('user_group_id');
        manager = await Database().init(App());
        final picture = data.remove('picture');
        final user = await manager.app.user.prepare(body['id'], data);
        user.settings.addAll(await updateSession(manager, user));
        await manager.persist();
        if (picture['insert'] != null) {
          final sync = base.FileSync()
            ..path_from = '${base.path}/tmp'
            ..path_to = '${base.path}/media/user/${user.user_id}'
            ..file_name = picture['insert']['source'];
          user.picture = await sync.sync();
          manager.addDirty(user);
        }
        await manager.commit();
        response({'id': user.user_id});
      });

  //Seems not used
  Future settingsSave() => run(null, null, null, () async {
        manager = await Database().init(App());
        final sd = SettingsDTO.fromMap(await getData());
        final userSession = UserSessionDTO.fromMap(req.session['client']);
        userSession.settings.addAll(sd.settings);
        await new UserService(manager).updateUserSession(userSession);
        return response(true);
      });

  Future<bool> doDelete(int id) => manager.app.user.deleteById(id);

  Future<void> password() => run(null, null, null, () async {
        final pd = PasswordDTO.fromMap(await getData());
        manager = await Database().init(App());
        final e = await manager.app.user.find(pd.id);
        if (UserSessionDTO.fromMap(req.session['client']).user_id == pd.id ||
            base.permissionCheck(req.session, group, scope, 'update')) {
          e.password = e.getPassword(pd.password);
          await manager.app.user.update(e);
          return response(true);
        } else {
          response(null, {
            'type': 'permission',
            'title': 'Permission',
            'message': base.permissionMessage(group, scope, 'create')
          });
        }
      });
}
