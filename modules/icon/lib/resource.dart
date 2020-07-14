import 'dart:async';
import 'dart:io';

import 'package:resource/resource.dart';

Future<String> loadResourceString(
    String packageFile, String path, bool test) async {
  if (test) return Resource('package:$packageFile').readAsString();
  final file = File('$path/web/packages/$packageFile');
  return file.existsSync()
      ? await file.readAsString()
      : await Resource('package:$packageFile').readAsString();
}

Future<List<int>> loadResourceBytes(
    String packageFile, String path, bool test) async {
  if (test) return Resource('package:$packageFile').readAsBytes();
  final file = File('$path/web/packages/$packageFile');
  return file.existsSync()
      ? await file.readAsBytes()
      : await Resource('package:$packageFile').readAsBytes();
}
