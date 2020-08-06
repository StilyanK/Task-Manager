library project.mapper;

import 'dart:io';

import 'package:auth/server.dart' as auth;
import 'package:cl_base/server.dart' as base;
import 'package:mapper/mapper.dart';
import 'package:path/path.dart';

import 'entity.dart' as entity;
import 'shared.dart';

part 'db/mapper/task.dart';
part 'db/mapper/task_media.dart';

mixin AppMixin {
  Manager m;

  TaskMapper get task => TaskMapper(m.convert(App()))
    ..notifier = notifierTask
    ..entity = (() => Task())
    ..collection = () => TaskCollection();

  TaskMediaMapper get taskMedia => TaskMediaMapper(m.convert(App()))
    ..entity = (() => TaskMedia())
    ..collection = () => TaskMediaCollection();
}

class App extends Application with AppMixin, base.AppMixin, auth.AppMixin {}

EntityNotifier<Task> notifierTask = new EntityNotifier<Task>();
