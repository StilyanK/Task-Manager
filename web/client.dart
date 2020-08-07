library hms_cloud.client;

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:auth/client.dart' as auth;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:cl_base/client.dart' as base;
import 'package:communicator/client.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project/client.dart' as project;

import 'intl/messages_all.dart';

Future<void> main() async {
  final settings = cl_app.AppSettings()
    ..desktopIcons = true
    ..menuStyle = 2
    ..menuDefaultOpen = false
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
//  local.init(ap);
  project.init(ap);
  initMain(ap);
}

//
void initMain(Application ap) {
  ap
    ..setMenu([
      project.MenuItem.ProjectList..desktop = true,
      project.MenuItem.TaskList..desktop = true,
    ])
    ..setMenu([
      project.MenuItem.Settings
        ..addChild(auth.MenuItem.Users)
        ..addChild(auth.MenuItem.Groups)
    ])
    ..done();

  final leftCont = new cl.Container()..addClass('gadgets-left');
  final rightCont = new cl.Container()..addClass('gadgets-right');
  ap.gadgetsContainer..addCol(leftCont..auto = true)..addCol(rightCont);

  final cont = new cl_app.GadgetContainer();

  final cont2 = new cl_app.GadgetContainer()..addClass('gadget-outer');

  rightCont.append(project.TaskGadget(ap)..load());
  leftCont..addRow(cont)..addRow(cont2);
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
