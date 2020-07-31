part of hms_local.server;

enum Group { month, year, day }

class Chart {
  final Map<String, num> _range = {};
  Group group;
  DateTime date_from;
  DateTime date_to;
  String date_field;
  Builder query;
  String _date_format;
  String timezone;

  static const String xAxis = 'x';
  static const String yAxis = 'y';

  Chart(
      {this.date_from,
      this.date_to,
      this.group,
      this.query,
      this.date_field,
      this.timezone}) {
    _set();
  }

  void _set() {
    String format;
    switch (group) {
      case Group.day:
        _date_format = 'TO_CHAR($date_field::timestamptz AT TIME ZONE @tz,'
            ' \'yyyy-mm-dd\')';
        format = 'yyyy-MM-dd';
        break;
      case Group.month:
        _date_format =
            'TO_CHAR($date_field::timestamptz AT TIME ZONE @tz , \'yyyy-mm\')';
        format = 'yyyy-MM';
        break;
      case Group.year:
        _date_format =
            'TO_CHAR($date_field::timestamptz AT TIME ZONE @tz, \'yyyy\')';
        format = 'yyyy';
        break;
    }
    DateTime next = date_from;
    String cur;
    while (next.isBefore(date_to)) {
      final String d = new DateFormat(format).format(next);
      if (d != cur) {
        cur = d;
        _range[d] = 0;
      }
      next = next.add(const Duration(days: 1));
    }
    final end = new DateFormat(format).format(date_to);
    if (!_range.containsKey(end)) _range[end] = 0;
    query
      ..addSelect('$_date_format AS $xAxis')
      ..andWhere('$date_field::timestamptz AT TIME ZONE @tz  >= @date_from')
      ..setParameter('date_from', date_from)
      ..andWhere('$date_field::timestamptz AT TIME ZONE @tz < @date_to')
      ..setParameter('date_to', date_to)
      ..setParameter('tz', timezone)
      ..addGroupBy(xAxis);
  }

  Future<Map<String, num>> execute(Manager manager) async {
    final res = await manager.execute(query);
    res.forEach((r) => _range[r[xAxis]] = r[yAxis]);
    return _range;
  }
}
