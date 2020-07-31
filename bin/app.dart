import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cl_base/server.dart' as cl_base;
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:mapper/mapper.dart' show Database, Pool;
//import 'package:protocol/intl/server/messages_all.dart';
import 'package:auth/server.dart' as auth;
import 'package:project/server.dart' as project;
import 'package:local/server.dart' as local;
import 'package:task/task.dart';
import 'package:yaml/yaml.dart';
// Base server libraries

// Registering init function for each package
Object init = [cl_base.init, auth.init, project.init, local.init()];

void main(List<String> args) {
  cl_base.path = args.length == 1
      ? args.first
      : Directory.current.path.endsWith('bin') ? '..' : '.';
  cl_base.baseURL = '';
  cl_base.appTitle = 'Таск мениджър';
  cl_base.logHandler();
  final log = Logger('App');
  runZoned(() async {
    // Initialize default server locale
    await Future.forEach(['bg', 'de', 'el', 'es', 'fr', 'it', 'ro', 'ru'],
        (locale) async {
      await initializeDateFormatting(locale, null);
    });

    // Setup database and manager
    final config = loadYaml(await File('${cl_base.path}/config/config.yaml')
        .readAsString(encoding: utf8));
    if (config.containsKey('devmode') && config['devmode'] is bool)
      cl_base.devmode = config['devmode'];
    final pool = Pool(
        config['db']['host'], config['db']['port'], config['db']['database'],
        user: config['db']['user'],
        password: config['db']['password'],
        min: 1,
        max: 5);
    await pool.start();
    Database().registerPool(pool);

    // Iterates over init functions and starts HTTP servers
    await Future.forEach(init, (f) => f());
    //await Future.forEach(api, (f) => f());
    await Future.wait([
      cl_base.server(
          config['app']['centryl']['address'], config['app']['centryl']['port'])
    ]);

    // SIG processing
    Future _serverDown(dynamic ProcessSignal) async {
      cl_base.onServerDown();
      await pool.destroy();
      ScheduleManager().destroy();
      log.info('Centryl stopped!');
      exit(0);
    }

    ProcessSignal.sighup.watch().listen(_serverDown);
    ProcessSignal.sigterm.watch().listen(_serverDown);
    ProcessSignal.sigint.watch().listen(_serverDown);
    log.info('Centryl started!');

    Timer(const Duration(seconds: 5), () async {
      final upd = await cl_base.checkForUpdates();
      if (upd == cl_base.AppStateStatus.updated)
        cl_base.onServerStartUpdate();
      else if (upd == cl_base.AppStateStatus.refresh)
        cl_base.onServerStartUpdateR();
      else
        cl_base.onServerStart();
    });
  }, onError: (e, s) => log.shout('Error', e, s));
}
