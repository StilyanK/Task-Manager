library project.mapper;

import 'dart:io';

import 'package:auth/server.dart' as auth;
import 'package:cl_base/server.dart' as base;
import 'package:mapper/mapper.dart';
import 'package:path/path.dart';

import 'entity.dart' as entity;
import 'shared.dart';

part 'db/mapper/project.dart';
part 'db/mapper/task.dart';
part 'db/mapper/task_media.dart';

mixin AppMixin {
  Manager m;

  TaskMapper get task => TaskMapper(m.convert(new App()))
    ..notifier = notifierTask
    ..entity = (() => new Task())
    ..collection = () => new TaskCollection();

  TaskMediaMapper get taskMedia => new TaskMediaMapper(m.convert(new App()))
    ..entity = (() => new TaskMedia())
    ..collection = () => new TaskMediaCollection();

  ProjectMapper get project => new ProjectMapper(m.convert(new App()))
    ..notifier = notifierProject
    ..entity = (() => new Project())
    ..collection = () => new ProjectCollection();
}

class App extends Application with AppMixin, base.AppMixin, auth.AppMixin {}

EntityNotifier<Task> notifierTask = new EntityNotifier<Task>();
EntityNotifier<Project> notifierProject = new EntityNotifier<Project>();
