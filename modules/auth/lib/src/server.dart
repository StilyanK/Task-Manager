library auth.server;

import 'dart:async';

import 'package:mapper/mapper.dart';

import 'mapper.dart';

Future<Map<String, dynamic>> Function(Manager man, User user) updateSession =
    (man, u) async => {};
