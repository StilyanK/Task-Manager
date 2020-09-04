library auth.entity;

import 'dart:async';

import 'package:cl_annotation/annotation.dart';
import 'package:cl_base/shared.dart' as base;
import 'package:mapper/client.dart';

import 'path.dart';

part 'db/entity/chat_membership.dart';
part 'db/entity/chat_message.dart';
part 'db/entity/chat_room.dart';
part 'db/entity/event.dart';
part 'db/entity/group.dart';
part 'db/entity/notification.dart';
part 'db/entity/user.dart';
part 'db/entity/user_session.dart';
part 'entity.g.dart';

mixin Event {
  int id;
  int parent_id;
  int type;
  DateTime date_start;
  DateTime date_end;
  bool all_day;
  @MField()
  RecurringDTO recurring;
}