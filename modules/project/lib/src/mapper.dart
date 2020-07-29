library project.mapper;

import 'dart:async';
import 'dart:io';

import 'package:cl_base/server.dart' as base;
import 'package:auth/server.dart' as auth;
import 'package:mapper/mapper.dart';
import 'package:path/path.dart';

import 'entity.dart' as entity;

part 'db/mapper/task.dart';


mixin AppMixin {
  Manager m;

  TaskMapper get task => TaskMapper(m.convert(App()))
    ..entity = (() => Task())
    ..collection = () => TaskCollection();

}

class App extends Application with AppMixin, base.AppMixin, auth.AppMixin {}
