part of hms_local.shared;

class Date {
  DateTime date;

  Date(this.date);

  String get({bool toLocal = true, String separator = '/'}) =>
      new DateFormat('dd${separator}MM${separator}yyyy')
          .format(toLocal ? date.toLocal() : date);

  String getTime({bool toLocal = true}) =>
      new DateFormat('HH:mm').format(toLocal ? date.toLocal() : date);

  String getWithTime({bool toLocal = true}) =>
      new DateFormat('dd/MM/yyyy HH:mm')
          .format(toLocal ? date.toLocal() : date);

  bool isInSameDay(DateTime d) =>
      date.year == d.year && date.month == d.month && date.day == d.day;

  int getDaysInclusive(DateTime endDate) => getDaysDuration(endDate).inDays + 1;

  Duration getDaysDuration(DateTime endDate) {
    final start = normDate(date);
    final end = normDate(endDate);
    return UTCDifference(end, start);
  }

  static Duration UTCDifference(DateTime date1, DateTime date2) =>
      normDateFullUtc(date1).difference(normDateFullUtc(date2));

  static DateTime UTCAdd(DateTime date, Duration dur) {
    final utc = normDateFullUtc(date).add(dur);
    return normDateFull(utc);
  }

  static DateTime UTCSub(DateTime date, Duration dur) {
    final utc = normDateFullUtc(date).subtract(dur);
    return normDateFull(utc);
  }

  static String toTimeString(num object) {
    final hours = (object / 60).floor();
    final minutes = object - hours * 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}';
  }

  static DateTime normDate(DateTime date) =>
      new DateTime(date.year, date.month, date.day);

  static DateTime normDateUtc(DateTime date) =>
      new DateTime.utc(date.year, date.month, date.day);

  static DateTime normDateMinute(DateTime date) =>
      new DateTime(date.year, date.month, date.day, date.hour, date.minute);

  static DateTime normDateFull(DateTime date) => new DateTime(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond);

  static DateTime normDateFullUtc(DateTime date) => new DateTime.utc(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond);

  String toString() => get();
}
