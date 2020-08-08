import 'package:intl/intl.dart';
export 'package:cl_base/intl/client.dart';

String Task() => Intl.message('Task', name: 'Task');
String Tasks() => Intl.message('Tasks', name: 'Tasks');
String Task_title(int id) => id == null ? Task_new() : Task_title_e(id);
String Task_new() => Intl.message('New Task', name: 'Task_new');
String Task_title_e(int id) =>
    Intl.message('Task # $id', name: 'Task_title_e', args: [id]);

String Project() => Intl.message('Project', name: 'Project');
String Projects() => Intl.message('Projects', name: 'Projects');
String Project_title(int id) =>
    id == null ? Project_new() : Project_title_e(id);
String Project_new() => Intl.message('New Project', name: 'Project_new');
String Project_title_e(int id) =>
    Intl.message('Project # $id', name: 'Project_title_e', args: [id]);

String Created_by() => Intl.message('Created By', name: 'Created_by');
String Modified_by() => Intl.message('Modified By', name: 'Modified_by');
String Created() => Intl.message('Created', name: 'Created');
String Modified() => Intl.message('Modified', name: 'Modified');
String Assigned_to() => Intl.message('Assigned_to', name: 'Assigned_to');
String Deadline() => Intl.message('Deadline', name: 'Deadline');
String Progress() => Intl.message('Progress', name: 'Progress');
String Date_done() => Intl.message('Date Done', name: 'Date_done');
