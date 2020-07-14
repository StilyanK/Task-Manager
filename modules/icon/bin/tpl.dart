import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:protocol_icon/resource.dart';

Future main() async {
  final server = await HttpServer.bind('localhost', 5050);
  // ignore: avoid_print
  print('Template server listening on ${server.address.host}:${server.port}');

  server.listen((request) async {
    var folder = request.uri.path.replaceFirst('/', '').toLowerCase();
    var genPdf = false;
    final gegPdfPortrait = folder.startsWith('pdf/');
    if (gegPdfPortrait) {
      genPdf = true;
      folder = folder.replaceAll('pdf/', '');
    }
    final fp = 'test/template/$folder.dart';
    if (File(fp).existsSync()) {
      if (genPdf) {
        final params = <String>[
          '--no-sandbox',
          '--headless',
          '--disable-gpu',
          '--print-to-pdf=output.pdf',
          'http://${server.address.host}:${server.port}/$folder'
        ];
        await Process.run('google-chrome', params);
        final data = File('output.pdf').readAsBytesSync();
        request.response.headers.contentType = ContentType.binary;
        request.response.headers.add('Content-type', 'application/pdf');
        request.response.add(data);
        await request.response.close();
        File('output.pdf').deleteSync();
      } else {
        final content = await isoCall(fp);
        request.response.headers.contentType = ContentType.html;
        request.response.write(content);
        await request.response.close();
      }
    } else if (folder.endsWith('.png') ||
        folder.endsWith('.jpg') ||
        folder.endsWith('.gif') ||
        folder.endsWith('.css') ||
        folder.endsWith('.woff2') ||
        folder.endsWith('.woff') ||
        folder.endsWith('.ttf') ||
        folder.endsWith('.svg')) {
      final type = folder.split('.').last;
      if (['css'].any((e) => e == type))
        request.response.headers.contentType = ContentType('text', 'css');
      else if (['jpg', 'png', 'gif'].any((e) => e == type))
        request.response.headers.contentType = ContentType('image', type);
      else if (['woff2', 'woff', 'ttf'].any((e) => e == type))
        request.response.headers.contentType =
            ContentType('application', 'font-$type');
      final content = await loadResourceBytes(folder, '../not-used', true);
      request.response.add(content);
      await request.response.close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Bad Request!');
      await request.response.close();
    }
  });
}

Future<dynamic> isoCall(String file) async {
  final response = ReceivePort();
  final remote = Isolate.spawnUri(
      Uri.parse('file://${File(file).absolute.path}'),
      null,
      response.sendPort,
      onError: response.sendPort);
  return remote.then((_) => response.first);
}
