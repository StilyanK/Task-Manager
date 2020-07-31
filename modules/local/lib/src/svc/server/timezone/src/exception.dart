class TimezoneCommandException implements Exception {
  final String message;
  final DateTime timestamp;
  final String timezone;

  TimezoneCommandException(this.message, this.timestamp, this.timezone);

  String toString() =>
      '$runtimeType: $message\nTimezone: $timezone\nTimestamp: $timestamp';
}
