part of auth.path;

@DTOSerializable()
class EventPersistDTO {
  String id;
  DateTime date_start;
  DateTime date_end;
  DateTime recurring_persist_exclude;
  bool recurring_persist;

  EventPersistDTO();

  factory EventPersistDTO.fromMap(Map data) => _$EventPersistDTOFromMap(data);

  Map toMap() => _$EventPersistDTOToMap(this);

  Map toJson() => toMap();
}

@DTOSerializable()
class EventDTO {
  String id;
  String title;
  DateTime date_start;
  DateTime date_end;
  bool all_day;
  int type;

  EventDTO();

  factory EventDTO.fromMap(Map data) => _$EventDTOFromMap(data);

  Map toMap() => _$EventDTOToMap(this);

  Map toJson() => toMap();

  static int getId(String id) {
    if (id == null) return null;
    final parts = id.split('_').map(int.tryParse);
    return parts.first;
  }

  static int getSubId(String id) {
    if (id == null) return null;
    final parts = id.split('_').map(int.tryParse);
    return parts.length == 2 ? parts.last : null;
  }
}

@DTOSerializable()
class RecurringDTO {
  static int DAILY = 1;
  static int WEEKLY = 2;
  static int MONTHLY = 3;
  static int YEARLY = 4;

  DateTime start_on;
  DateTime end_on;
  DateTime date_start;
  DateTime date_end;
  int end_after;
  int repeat_type;
  int repeat_every;
  @MIgnore()
  List<DateTime> excludes;
  @MIgnore()
  int _event_length;

  RecurringDTO() {
    excludes = [];
  }

  factory RecurringDTO.fromMap(Map data) {
    final ent = _$RecurringDTOFromMap(data);
    if (ent.date_start != null && ent.date_end != null)
      ent._event_length = ent.date_end.difference(ent.date_start).inDays;
    ent.excludes = (data['excludes'] is List)
        ? data['excludes'].cast<String>().map<DateTime>(DateTime.parse).toList()
        : [];
    return ent;
  }

  Map toMap() => _$RecurringDTOToMap(this)
    ..['excludes'] = excludes.map<String>((e) => e.toIso8601String()).toList();

  Map toJson() => toMap();

  DateTime calcLastDate() {
    if (end_on != null) return end_on;
    if (end_after != null) {
      var iterations = end_after;
      var date = start_on;
      while (iterations > 0) {
        if (repeat_type == DAILY)
          date = nextDaySequence(date, repeat_every);
        else if (repeat_type == WEEKLY)
          date = nextWeekSequence(date, repeat_every);
        else if (repeat_type == MONTHLY)
          date = nextMonthSequence(date, repeat_every);
        else if (repeat_type == YEARLY)
          date = nextYearSequence(date, repeat_every);
        iterations--;
      }
      return date;
    }
    return null;
  }

  DateTime nextDaySequence(DateTime start, [int multiplier = 1]) {
    start = start.toUtc();
    final day = start.day + multiplier * 1;
    return DateTime.utc(start.year, start.month, day, start.hour,
        start.minute, start.second, start.millisecond);
  }

  DateTime nextWeekSequence(DateTime start, [int multiplier = 1]) {
    start = start.toUtc();
    final day = start.day + multiplier * 7;
    return DateTime.utc(start.year, start.month, day, start.hour,
        start.minute, start.second, start.millisecond);
  }

  DateTime nextMonthSequence(DateTime start, [int multiplier = 1, int i = 1]) {
    start = start.toUtc();
    final month = start.month + multiplier * i;
    var date = DateTime.utc(start.year, month, start.day, start.hour,
        start.minute, start.second, start.millisecond);
    if (date.day != start.day) date = nextMonthSequence(start, multiplier, ++i);
    return date;
  }

  DateTime nextYearSequence(DateTime start, [int multiplier = 1]) {
    start = start.toUtc();
    final year = start.year +
        multiplier * ((start.month == 2 && start.day == 29) ? 4 : 1);
    return DateTime.utc(year, start.month, start.day, start.hour,
        start.minute, start.second, start.millisecond);
  }

  DateTime getFirstIntersection(DateTime window_start, DateTime window_end) {
    window_start = window_start.toUtc();
    window_end = window_end.toUtc();
    if (repeat_type == DAILY) {
      var diff = window_start.difference(date_end).inDays;
      DateTime in_range;
      if (diff > 0) {
        final devision_check = diff / repeat_every;
        if (devision_check == devision_check.floor()) diff--;
        final contains = (diff / repeat_every).floor();
        final offset = contains * repeat_every;
        final first_before = nextDaySequence(date_end, offset);
        in_range = nextDaySequence(first_before, repeat_every);
      } else {
        in_range = date_end;
      }

      final event_length = date_end.difference(date_start).inDays;
      final in_range_start =
          in_range.subtract(Duration(days: event_length));
      if ((window_start.compareTo(in_range) < 0 &&
              window_end.compareTo(in_range) >= 0) ||
          (window_end.compareTo(in_range_start) >= 0)) return in_range_start;
    } else if (repeat_type == WEEKLY) {
      var diff = window_start.difference(date_end).inDays / 7;
      DateTime in_range;
      if (diff > 0) {
        final devision_check = diff / repeat_every;
        if (devision_check == devision_check.floor()) diff--;
        final contains = (diff / repeat_every).floor();
        final offset = contains * repeat_every;
        final first_before = nextWeekSequence(date_end, offset);
        in_range = nextWeekSequence(first_before, repeat_every);
      } else {
        in_range = date_end;
      }

      final event_length = date_end.difference(date_start).inDays;
      final in_range_start =
          in_range.subtract(Duration(days: event_length));
      if ((window_start.compareTo(in_range) < 0 &&
              window_end.compareTo(in_range) >= 0) ||
          (window_end.compareTo(in_range_start) >= 0)) return in_range_start;
    } else if (repeat_type == MONTHLY) {
      final event_length = date_end.difference(date_start).inDays;
      var in_range = nextMonthSequence(date_end, repeat_every);
      while (window_start.compareTo(in_range) > 0)
        in_range = nextMonthSequence(in_range, repeat_every);
      in_range = in_range.subtract(Duration(days: event_length));
      if (window_end.compareTo(in_range) >= 0) return in_range;
    } else if (repeat_type == YEARLY) {
      final event_length = date_end.difference(date_start).inDays;
      var in_range = nextYearSequence(date_end, repeat_every);
      while (window_start.compareTo(in_range) > 0)
        in_range = nextYearSequence(in_range, repeat_every);
      in_range = in_range.subtract(Duration(days: event_length));
      if (window_end.compareTo(in_range) >= 0) return in_range;
    }
    return null;
  }

  List<DateTime> generateDatePairsTill(
      DateTime window_start, DateTime window_end) {
    window_start = window_start.toUtc();
    window_end = window_end.toUtc();
    final l = <DateTime>[];
    var date = getFirstIntersection(window_start, window_end);
    if (date == null) return null;
    var end = window_end;
    final end_calced = calcLastDate();
    if (end_calced != null)
      end = (end_calced.compareTo(window_end) < 0) ? end_calced : window_end;
    while (end.compareTo(date) >= 0) {
      if (!excludes.contains(date)) l.add(date);
      if (repeat_type == DAILY)
        date = nextDaySequence(date, repeat_every);
      else if (repeat_type == WEEKLY)
        date = nextWeekSequence(date, repeat_every);
      else if (repeat_type == MONTHLY)
        date = nextMonthSequence(date, repeat_every);
      else if (repeat_type == YEARLY)
        date = nextYearSequence(date, repeat_every);
    }
    return l;
  }

  DateTime getStartDateByRepeatId(int repeat_id) {
    var date = start_on;
    if (repeat_type == DAILY)
      date = nextDaySequence(date, repeat_every * repeat_id);
    else if (repeat_type == WEEKLY)
      date = nextWeekSequence(date, repeat_every * repeat_id);
    else if (repeat_type == MONTHLY)
      date = nextMonthSequence(date, repeat_every * repeat_id);
    else if (repeat_type == YEARLY)
      date = nextYearSequence(date, repeat_every * repeat_id);
    return date;
  }

  DateTime getEndDate(DateTime start_date) {
    start_date = start_date.toUtc();
    return start_date.add(Duration(days: _event_length));
  }

  bool testInSequence(DateTime start, DateTime end) {
    start = start.toUtc();
    end = end.toUtc();
    return excludes.contains(start) &&
        date_start.difference(date_end).inHours ==
            start.difference(end).inHours;
  }
}
