import 'package:cl_base/api.dart' as base_api;

import 'src/api.dart';

export 'src/api.dart';

void init() {
  base_api.routes.add((a) => a.addApi(new ApiLocal()));
}
