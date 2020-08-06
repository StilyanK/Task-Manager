import 'package:cl/app.dart' as cl_app;

import 'src/gui.dart';

export 'src/gui.dart';
export 'src/path.dart';
export 'src/permission.dart';

abstract class MenuItem {
  static final cl_app.MenuElement TaskList = cl_app.MenuElement()
    ..title = 'Задачи'
    ..icon = Icon.Tasks
    ..action = (ap) => ap.run('task/list');
  static final cl_app.MenuElement Settings = cl_app.MenuElement()
    ..title = 'Настройки'
    ..icon = Icon.Settings;
  static final cl_app.MenuElement ProjectList = cl_app.MenuElement()
    ..title = 'Проекти'
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
}
