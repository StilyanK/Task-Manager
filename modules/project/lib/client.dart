import 'package:cl/app.dart' as cl_app;
//import 'package:project/server.dart';

import 'intl/client.dart' as intl;
import 'src/gui.dart';

export 'src/gui.dart';
export 'src/path.dart';
export 'src/permission.dart';

abstract class MenuItem {
  static final cl_app.MenuElement TaskList = cl_app.MenuElement()
    ..title = intl.Tasks()
    ..icon = Icon.Tasks
    ..action = (ap) => ap.run('task/list');
  static final cl_app.MenuElement Settings = cl_app.MenuElement()
    ..title = intl.Settings()
    ..icon = Icon.Settings;
  static final cl_app.MenuElement ProjectList = cl_app.MenuElement()
    ..title = intl.Projects()
    ..icon = Icon.DocComments
    ..action = (ap) => ap.run('project/list');
}

void init(cl_app.Application ap) {
  ap
    ..addRoute(cl_app.Route('task/item/:int', (ap, p) => TaskGui(ap, id: p[0])))
    ..addRoute(cl_app.Route('task/list', (ap, p) => TaskList(ap)))
    ..addRoute(
        cl_app.Route('project/item/:int', (ap, p) => Project(ap, id: p[0])))
    ..addRoute(cl_app.Route('project/list', (ap, p) => ProjectList(ap)));

  cl_app.NotificationMessage.registerDecorator('task:read:update', (not) {
    final parts = not.text.split(':');
    final userId = int.parse(parts[0]);
    final taskId = int.parse(parts[1]);
    return not
      ..priority = cl_app.NotificationMessage.attention
      ..text = '${intl.Task()} #$taskId - редактиран'
      ..action = (() => ap.run('task/item/$taskId'));
  });

  cl_app.NotificationMessage.registerDecorator('task:read:create', (not) {
    final parts = not.text.split(':');
    final userId = int.parse(parts[0]);
    final taskId = int.parse(parts[1]);
    return not
      ..priority = cl_app.NotificationMessage.attention
      ..text = '${intl.Task()} #$taskId - създаден'
      ..action = (() => ap.run('task/item/$taskId'));
  });

  ap.onServerCall.filter('task:read:update').listen((res) {
    ap.notify.add(new cl_app.NotificationMessage.fromMap(res));
  });

  ap.onServerCall.filter('task:read:create').listen((res) {
    ap.notify.add(new cl_app.NotificationMessage.fromMap(res));
  });
}
