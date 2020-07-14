import 'dart:html';

import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;

import 'intl/client.dart' as intl;
import 'src/gui.dart';
import 'src/path.dart';
import 'src/permission.dart';

export 'src/gui.dart';
export 'src/path.dart';
export 'src/permission.dart';

abstract class MenuItem {
  static final cl_app.MenuElement UserMain = cl_app.MenuElement()
    ..title = intl.Users()
    ..icon = Icon.UserMain;

  static final cl_app.MenuElement Users = cl_app.MenuElement()
    ..title = intl.Users()
    ..icon = Icon.User
    ..scope = '${Group.Auth}:${Scope.User}:read'
    ..action = (ap) => ap.run('user/list');

  static final cl_app.MenuElement Groups = cl_app.MenuElement()
    ..title = intl.User_groups()
    ..icon = Icon.UserGroup
    ..scope = '${Group.Auth}:${Scope.Group}:read'
    ..action = (ap) => ap.run('user_group/list');
}

void init(cl_app.Application ap) {
  ap
    ..addRoute(cl_app.Route('user/settings', (ap, p) => Settings(ap)))
    ..addRoute(cl_app.Route('user/profile', (ap, p) => UserHome(ap)))
    ..addRoute(
        cl_app.Route('user/calendar', (ap, p) => UserCalendar(ap)))
    ..addRoute(cl_app.Route(
        'user/event/:string',
        (ap, p) => UserEvent(ap,
            id: p[0], initData: (p.length > 1) ? p[1] : null)))
    ..addRoute(cl_app.Route('user/list', (ap, p) => UserList(ap)))
    ..addRoute(cl_app.Route('user/:int', (ap, p) => User(ap, p[0])))
    ..addRoute(
        cl_app.Route('user_group/list', (ap, p) => UserGroupList(ap)))
    ..addRoute(cl_app.Route(
        'user_group/:int', (ap, p) => UserGroup(ap, p[0])));

  cl_app.NotificationMessage.registerDecorator('error', (not) {
    final cont = cl.Container()
      ..append(ParagraphElement()..text = not.text);
    return not
      ..priority = cl_app.NotificationMessage.error
      ..action = (() => cl_app.Dialog(ap, cont)
        ..icon = cl.Icon.error
        ..title = intl.Error()
        ..render());
  });
  ap.notify
    ..persist = ((n) => ap.serverCall(
        RoutesN.userNotificationsPersist.reverse([]),
        {'local_key': n.event, 'local_value': n.text},
        null))
    ..remove = ((n) => ap.serverCall(
        RoutesN.userNotificationRemove.reverse([]), {'id': n.id}, null))
    ..load_archive = (([load, start, end]) => ap.serverCall(
        RoutesN.userNotificationsArchive.reverse([]),
        {'start': start.toString(), 'end': end.toString()},
        load))
    ..mark_read = ((n) => ap.serverCall(
        RoutesN.userNotificationsMarkRead.reverse([]), {'id': n.id}, null))
    ..mark_unread = ((n) => ap.serverCall(
        RoutesN.userNotificationsMarkUnread.reverse([]), {'id': n.id}, null))
    ..load_recent = (([load]) =>
        ap.serverCall(RoutesN.userNotificationsRecent.reverse([]), null, load))
    ..load_unread = (([load]) =>
        ap.serverCall(RoutesN.userNotificationsUnread.reverse([]), null, load));
}
