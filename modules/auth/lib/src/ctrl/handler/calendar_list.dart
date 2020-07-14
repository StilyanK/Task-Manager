part of auth.ctrl;

class CCalendar extends base.Base<App> {
  CCalendar(req) : super(req);

  Future<dynamic> getEvents() => run(null, null, null, () async {
        final d = await getData();
        final date_start = DateTime.parse(d['date_start']);
        final date_end = DateTime.parse(d['date_end']);
        manager = await Database().init(App());
        final col = await manager.app.user_event.getRange(date_start, date_end,
            UserSessionDTO.fromMap(req.session['client']).user_id);
        final result = [];
        for (final c in col) {
          if (c.recurring == null) {
            result.add(EventDTO()
              ..id = c.id.toString()
              ..title = c.title
              ..date_start = c.date_start
              ..date_end = c.date_end
              ..type = c.type
              ..all_day = c.all_day);
          } else {
            final pairs =
                c.recurring.generateDatePairsTill(date_start, date_end);
            if (pairs != null) {
              for (var i = 0; i < pairs.length; i++) {
                final date = pairs[i];
                result.add(EventDTO()
                  ..id = '${c.id}_$i'
                  ..title = c.title
                  ..date_start = date
                  ..date_end = c.recurring.getEndDate(date)
                  ..type = c.type
                  ..all_day = c.all_day);
              }
            }
          }
          //result.add(c.toJson());
        }
        return response(result);
      });
}
