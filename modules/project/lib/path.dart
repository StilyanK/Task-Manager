library document_client.path;

import 'package:cl/utils.dart' as cl_util;

class Path {
  static const String $base = 'project';
  static final cl_util.ClientPath task =
      cl_util.ClientPath('${$base}/task/:int');
  static final cl_util.ClientPath task_list =
      cl_util.ClientPath('${$base}/task_list');
}
