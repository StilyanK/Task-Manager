library hms_bundle;

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:communicator/client.dart';
import 'package:cl_base/client.dart' as base;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:protocol/intl/client/messages_all.dart';
import 'package:protocol_auth/client.dart' as auth;
import 'package:protocol_document/client.dart' as document;

Future<void> main() async {
  final settings = cl_app.AppSettings()
    ..desktopIcons = true
    ..menuStyle = 2
    ..menuHideOnAction = true
    ..fullWindowMode = true
    ..baseurl = '/';
  final ap = Application(settings);
  final data = await initData(ap);
  final client = auth.Client(data);
  ap.setClient(client);

  if (!client.devmode) {
    context['console'].callMethod('log', [
      // ignore: no_adjacent_strings_in_list
      '%cВнимание! Работата със платформата може да бъде нарушена '
          'при използване на инструменти от този панел.',
      // ignore: no_adjacent_strings_in_list
      'font: 2rem sans-serif; color: red; '
          'text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;'
    ]);
  }

  await initLocale(ap);

  base.init(ap);
  auth.init(ap);
  document.init(ap);

  ap.setMenu(
      [auth.MenuItem.UserMain, auth.MenuItem.Users, auth.MenuItem.Groups]);

  ap.done();
}

Future initLocale(Application ap) async {
  final locale = ap.client.locale ?? Intl.getCurrentLocale();
  if (locale != 'en_US') {
    await initializeMessages(locale.split('_').first);
    Intl.defaultLocale = locale;
    await initializeDateFormatting(locale, null);
  }
}

Future<Map> initData(Application ap) async {
  final communicator = Communicator(ap.baseurl);
  final port =
      (window.location.port.isNotEmpty) ? '' : ':${window.location.port}';
  final protocol = window.location.protocol.endsWith('ps:') ? 'wss' : 'ws';
  await communicator
      .upgrade('$protocol://${window.location.host}$port${ap.baseurl}ws');
  ap
    ..on_server_call = communicator.onServerCall
    ..server_call = communicator.send;
  return ap.serverCall<Map>('/init', null);
}

class Application extends cl_app.Application<auth.Client> {
  Application(cl_app.AppSettings settings) : super(settings: settings);
}