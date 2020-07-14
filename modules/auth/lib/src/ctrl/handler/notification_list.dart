part of auth.ctrl;

class CNotification extends base.Base<App> {
  CNotification(req) : super(req);

  Future<void> persist() => run(null, null, null, () async {
        final data = await getData();
        manager = await Database().init(App());
        final n = manager.app.user_notification.createObject(data)
          ..user_id = UserSessionDTO.fromMap(req.session['client']).user_id
          ..read = false;
        await manager.app.user_notification.insert(n);
        return response(true);
      });

  Future<void> archive() => run(null, null, null, () async {
        final data = await getData();
        final start = DateTime.parse(data['start']);
        final end = DateTime.parse(data['end']);
        manager = await Database().init(App());
        final col = await manager.app.user_notification.findByUser(
            UserSessionDTO.fromMap(req.session['client']).user_id,
            start,
            end);
        for (final e in col) await e.loadNotification();
        return response(col.map(_format).toList());
      });

  Future<void> markRead() => run(null, null, null, () async {
        final data = await getData();
        manager = await Database().init(App());
        final id = data['id'];
        final not = await manager.app.user_notification.find(id);
        if (not != null) {
          not.read = true;
          await manager.app.user_notification.update(not);
        }
        return response(null);
      });

  Future<void> markUnRead() => run(null, null, null, () async {
        final data = await getData();
        manager = await Database().init(App());
        final id = data['id'];
        final not = await manager.app.user_notification.find(id);
        if (not != null) {
          not.read = false;
          await manager.app.user_notification.update(not);
        }
        return response(null);
      });

  Future<void> recent() => run(null, null, null, () async {
        manager = await Database().init(App());
        final col = await manager.app.user_notification
            .recent(UserSessionDTO.fromMap(req.session['client']).user_id);
        for (final e in col) await e.loadNotification();
        return response(col.map(_format).toList());
      });

  Future<void> remove() => run(null, null, null, () async {
        final data = await getData();
        final id = data['id'];
        manager = await Database().init(App());
        await manager.app.user_notification.deleteById(id);
        return response(true);
      });

  Future<void> unread() => run(null, null, null, () async {
        manager = await Database().init(App());
        return response(await manager.app.user_notification
            .unread(UserSessionDTO.fromMap(req.session['client']).user_id));
      });

  Map<String, dynamic> _format(UserNotification e) => {
        'id': e.user_notification_id,
        'event': e.notification.key,
        'text': e.notification.value,
        'read': e.read,
        'date': e.notification.date.toString()
      };
}
