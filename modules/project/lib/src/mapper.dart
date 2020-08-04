library project.mapper;

import 'package:auth/server.dart' as auth;
import 'package:cl_base/server.dart' as base;
import 'package:mapper/mapper.dart';

import 'entity.dart' as entity;

part 'db/mapper/task.dart';

mixin AppMixin {
  Manager m;

  TaskMapper get task => TaskMapper(m.convert(App()))
    ..notifier = notifierTask
    ..entity = (() => Task())
    ..collection = () => TaskCollection();
}

class App extends Application with AppMixin, base.AppMixin, auth.AppMixin {}

EntityNotifier<Task> notifierTask = new EntityNotifier<Task>();
