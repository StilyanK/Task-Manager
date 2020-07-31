import 'package:cl/app.dart' as cl_app;
import 'src/gui.dart';
export 'src/gui.dart';
export 'src/path.dart';
export 'src/permission.dart';

abstract class MenuItem {
  static final cl_app.MenuElement CreatTask = cl_app.MenuElement()
    ..title = 'Добави задача'
    ..icon = Icon.DocComments
    ..action = (ap) => ap.run('task/create');
  static final cl_app.MenuElement TaskList = cl_app.MenuElement()
    ..title = 'Задачи'
    ..icon = Icon.Tasks
    ..action = (ap) => ap.run('task/list');
}

void init(cl_app.Application ap) {
  ap
    ..addRoute(cl_app.Route('task/create', (ap, p) => TaskGui(ap)))
    ..addRoute(cl_app.Route('task/list', (ap, p) => TaskList(ap)));
}
