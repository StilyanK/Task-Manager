import 'package:cl/app.dart' as cl_app;

import 'intl/client.dart' as intl;
import 'src/gui.dart';
import 'src/path.dart';

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

  cl_app.NotificationMessage.registerDecorator(EVENT_TASK_UPDATE, (not) {
    final taskId = int.parse(not.text);
    return not
      ..priority = cl_app.NotificationMessage.attention
      ..text = '${intl.Task()} #$taskId - редактирана'
      ..action = (() => ap.run('task/item/$taskId'));
  });

  cl_app.NotificationMessage.registerDecorator(EVENT_TASK_CREATE, (not) {
    final taskId = int.tryParse(not.text);
    return not
      ..priority = cl_app.NotificationMessage.attention
      ..text = '${intl.Task()} #$taskId - създадена'
      ..action = (() => ap.run('task/item/$taskId'));
  });

  ap.onServerCall.filter(EVENT_TASK_UPDATE).listen((res) {
    ap.notify.add(new cl_app.NotificationMessage.fromMap(res));
  });

  ap.onServerCall.filter(EVENT_TASK_CREATE).listen((res) {
    ap.notify.add(new cl_app.NotificationMessage.fromMap(res));
  });
}
