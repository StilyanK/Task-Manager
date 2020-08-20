library hms_cloud.client;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'dart:typed_data';

import 'package:auth/client.dart' as auth;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:cl_base/client.dart' as base;
import 'package:communicator/client.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project/client.dart' as project;
import 'package:service_worker/window.dart' as sw;

import 'intl/messages_all.dart';

Future<void> main() async {
  final subsData = await SWActivate(null);
  final settings = cl_app.AppSettings()
    ..desktopIcons = true
    ..menuStyle = 2
    ..menuDefaultOpen = false
    ..fullWindowMode = true
    ..baseurl = '/';
  final ap = Application(settings);
  final data = await initData(ap, subsData);
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

Future<Map> initData(Application ap, Map data) async {
  final communicator = Communicator(ap.baseurl);
  final port =
      (window.location.port.isNotEmpty) ? '' : ':${window.location.port}';
  final protocol = window.location.protocol.endsWith('ps:') ? 'wss' : 'ws';
  await communicator
      .upgrade('$protocol://${window.location.host}$port${ap.baseurl}ws');
  ap
    ..on_server_call = communicator.onServerCall
    ..server_call = communicator.send;
  return ap.serverCall<Map>('/init', data);
}

class Application extends cl_app.Application<auth.Client> {
  Application(cl_app.AppSettings settings) : super(settings: settings);
}

Future<Map> SWActivate(String appServerKey) async {
  if (sw.isNotSupported) return null;
  await sw.register('/sw.dart.js');

  final sw.ServiceWorkerRegistration registration = await sw.ready;
  registration.onUpdateFound.listen((event) => registration.update());

  if (appServerKey != null) {
    try {
      final subs = (await registration.pushManager.getSubscription()) ??
          (await registration.pushManager.subscribe(
              new sw.PushSubscriptionOptions(
                  userVisibleOnly: true,
                  applicationServerKey: urlBase64ToUint8List(appServerKey))));
      final subsData = subs.getKeysAsString();
      subsData['endpoint'] = subs.endpoint;
      return subsData;
    } on DomException catch (_) {}
  }
  return null;
}

Uint8List urlBase64ToUint8List(String base64String) {
  final padding = '=' * ((4 - base64String.length % 4) % 4);
  final base64 = (base64String + padding)
      .replaceAll(new RegExp(r'-'), '+')
      .replaceAll(new RegExp(r'_'), '/');
  final rawData = window.atob(base64);
  final outputArray = new Uint8List(rawData.length);
  for (var i = 0; i < rawData.length; ++i)
    outputArray[i] = rawData.codeUnitAt(i);
  return outputArray;
}
