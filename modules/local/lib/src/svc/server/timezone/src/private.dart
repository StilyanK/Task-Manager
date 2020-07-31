import 'dart:async';
import 'dart:io';

import 'exception.dart';

Future<String> executeDateCommand(String timezone, [DateTime timestamp]) async {
  final p = timestamp == null
      ? await Process.run('date', ['+%:z'], environment: {'TZ': timezone})
      : await Process.run(
          'date', ['--date', timestamp.toIso8601String(), '+%:z'],
          environment: {'TZ': timezone});
  if (p.exitCode != 0)
    throw new TimezoneCommandException(
        _removeTrailingNewline(p.stderr), timestamp, timezone);
  return _removeTrailingNewline(p.stdout);
}

String _removeTrailingNewline(String input) =>
    input.substring(0, input.length - 1);

Future<Duration> getOffset(String timezone, [DateTime timestamp]) async {
  final offset = await executeDateCommand(timezone, timestamp);
  final p = offset.split(':');
  return new Duration(hours: int.parse(p[0]), minutes: int.parse(p[1]));
}
