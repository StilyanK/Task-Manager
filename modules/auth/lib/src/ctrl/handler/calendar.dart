part of auth.ctrl;

class ICalendar extends base.Item<App, UserEvent, dynamic> {
  ICalendar(req) : super(req, App());

  Future<Map<String, dynamic>> doGet(dynamic id) async {
    final event = await manager.app.user_event.find(EventDTO.getId(id));
    if (event == null) throw base.ResourceNotFoundException();

    if (event.recurring != null) {
      event
        ..date_start =
            event.recurring.getStartDateByRepeatId(EventDTO.getSubId(id) ?? 0)
        ..date_end = event.recurring
            .getEndDate(event.recurring.getEndDate(event.date_start));
    }
    return event.toJson();
  }

  Future<dynamic> doSave(dynamic id, Map data) async {
    if (id is int) id = id.toString();

    data['user_id'] = UserSessionDTO.fromMap(req.session['client']).user_id;

    final date_start = DateTime.parse(data['date_start']);
    final date_end = DateTime.parse(data['date_end']);

    if (id != null) {
      final calendar = await manager.app.user_event.find(EventDTO.getId(id));
      final res = await _testAndMerge(calendar, date_start, date_end);
      if (res != null) return res;
    }
    final recData = data.remove(entity.$UserEvent.recurring);
    final event =
        await manager.app.user_event.prepare(EventDTO.getId(id), data);
    if (recData != null) {
      final recurring = RecurringDTO.fromMap(recData);
      event
        ..recurring = (recurring
          ..date_start = date_start
          ..date_end = date_end
          ..start_on = date_start)
        ..date_end = recurring.calcLastDate();
    }

    await manager.commit();
    return event.id.toString();
  }

  Future<String> _testAndMerge(
      UserEvent calendar, DateTime date_start, DateTime date_end) async {
    if (calendar.parent_id != null) {
      final parent_event =
          await manager.app.user_event.find(calendar.parent_id);
      if (parent_event.recurring.testInSequence(date_start, date_end)) {
        parent_event.recurring.excludes.remove(date_start);

        await manager.begin();
        manager
          ..addDirty(parent_event)
          ..addDelete(calendar);
        await manager.commit();

        return parent_event.id.toString();
      }
    }
    return null;
  }

  Future<dynamic> persist() => run(group, scope, 'create', () async {
        manager = await Database().init(App());
        final dto = EventPersistDTO.fromMap(await getData());

        final calendar =
            await manager.app.user_event.find(EventDTO.getId(dto.id));

        final res = await _testAndMerge(calendar, dto.date_start, dto.date_end);
        if (res != null) return response(res);

        if (dto.recurring_persist_exclude != null) {
          final recurring = calendar.recurring;
          if (!recurring.excludes.contains(dto.recurring_persist_exclude)) {
            recurring.excludes.add(dto.recurring_persist_exclude);
            final n_event = manager.app.user_event.createObject()
              ..date_start = dto.date_start
              ..date_end = dto.date_end
              ..title = calendar.title
              ..type = calendar.type
              ..user_id = calendar.user_id
              ..description = calendar.description
              ..all_day = calendar.all_day
              ..parent_id = EventDTO.getId(dto.id);
            calendar.recurring = recurring;

            await manager.begin();
            manager
              ..addNew(n_event)
              ..addDirty(calendar);
            await manager.commit();

            return response(n_event.id.toString());
          }
        } else if (dto.recurring_persist != null) {
          final recurring = calendar.recurring
            ..date_start = dto.date_start
            ..date_end = dto.date_end
            ..start_on = dto.date_start;

          await manager.begin();
          manager.addDirty(calendar
            ..date_end = recurring.calcLastDate()
            ..recurring = recurring);
          await manager.commit();

          return response(calendar.id.toString());
        }
        calendar
          ..date_start = dto.date_start
          ..date_end = dto.date_end;
        await manager.app.user_event.update(calendar);
        return response(calendar.id.toString());
      });

  Future<bool> doDelete(dynamic id) => manager.app.user_event.deleteById(id);
}
