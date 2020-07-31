library local.timezone;

import 'dart:async';

import 'package:timezone/standalone.dart';

export 'src/exception.dart';
export 'src/zone.dart';

/// Converts [timestamp] from UTC to [timezone]
///
/// Warning: [timestamp] is expected to be in UTC and will apply the offset
/// regardless of whether the DateTime object is in utc or local time.
Future<DateTime> inTimeZone(DateTime timestamp, String timezone) async {
  if (timestamp == null) return null;
  if (timestamp.isUtc) {
    final tz = getLocation(timezone);
    final r = TZDateTime.from(timestamp, tz);
    return new DateTime.utc(r.year, r.month, r.day, r.hour, r.minute, r.second,
        r.millisecond, r.microsecond);
  } else {
    final utc = new DateTime.utc(
        timestamp.year,
        timestamp.month,
        timestamp.day,
        timestamp.hour,
        timestamp.minute,
        timestamp.second,
        timestamp.millisecond,
        timestamp.microsecond);
    final tz = getLocation(timezone);
    final r = TZDateTime.from(utc, tz);
    return new DateTime.utc(r.year, r.month, r.day, r.hour, r.minute, r.second,
        r.millisecond, r.microsecond);
  }
}

/// Converts [timestamp] from [timezone] to UTC
///
/// Warning: [timestamp] is expected to be in [timezone]'s time and will apply
/// the offset regardless of whether the DateTime object is in utc or local
/// time.
Future<DateTime> fromTimeZone(DateTime timestamp, String timezone) async {
  if (timestamp == null) return null;
  final tz = getLocation(timezone);
  final r = new TZDateTime(
      tz,
      timestamp.year,
      timestamp.month,
      timestamp.day,
      timestamp.hour,
      timestamp.minute,
      timestamp.second,
      timestamp.millisecond,
      timestamp.microsecond).toUtc();
  return new DateTime.utc(r.year, r.month, r.day, r.hour, r.minute, r.second,
      r.millisecond, r.microsecond);
}
