library sw;

import 'dart:convert';

import 'package:service_worker/worker.dart';

void main(List<String> args) {
  onPush.listen((event) {
    final data = json.decode(event.data.text());
    registration.showNotification(
        data['title'],
        new ShowNotificationOptions()
          ..icon = '/images/logo.png'
          ..body = data['message']
          ..vibrate = [200, 100, 300]);
  });
}
