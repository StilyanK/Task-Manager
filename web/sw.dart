library sw;

import 'dart:convert';

import 'package:service_worker/worker.dart';

const String cacheName = 'app';

const List<String> cachePaths = [
  '/offline.html',
  '/packages/cl/fonts/roboto-regular.woff2',
  '/packages/cl/fonts/roboto-regular.woff',
  '/packages/cl/fonts/roboto-regular.otf',
  '/packages/cl/fonts/roboto-regular.svg',
  '/packages/cl/fonts/roboto-regular.ttf',
  '/images/android-chrome-192x192.png',
  '/images/android-chrome-512x512.png',
  '/images/apple-touch-icon.png',
  '/images/browserconfig.xml',
  '/images/favicon-16x16.png',
  '/images/favicon-32x32.png',
  '/images/logo.svg',
  '/images/manifest.json'
];

void main(List<String> args) {
  onActivate.listen((event) => event.waitUntil(_resetCache()));
  onFetch.listen((event) => event.respondWith(_fetchRequest(event.request)));
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

Future<Response> _fetchRequest(Request request) async {
  Response response;
  try {
    response = await fetch(request);
  } catch (e) {
    if (cachePaths.any((p) => request.url.endsWith(p)))
      response = await caches.match(request);
    else
      response = await caches.match('/offline.html');
  }
  return response;
}

Future _resetCache() async {
  final keys = await caches.keys();
  keys.forEach((key) => caches.delete(key));
  final cache = await caches.open(cacheName);
  await cache.addAll(cachePaths);
}
