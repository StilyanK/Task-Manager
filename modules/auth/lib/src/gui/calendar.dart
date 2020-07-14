part of auth.gui;

typedef EventMessageCallback = Function(bool way);

class UserCalendar extends cl_app.Item {
  cl_app.Application ap;
  cl_app.WinApp wapi;
  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = ((dynamic _) => intl.Event())
    ..icon = Icon.Calendar;

  EventCalendar event_calendar;

  UserCalendar(this.ap) {
    wapi = cl_app.WinApp(ap)
      ..load(meta, this)
      ..render();
    event_calendar = EventCalendar(ap, wapi.win.getContent())
      ..setViewMonth();
    wapi.addLayoutHook((_) {
      event_calendar.layout();
      return true;
    });
  }
}

class EventCalendar extends cl_calendar.EventCalendar {
  cl_app.Application ap;

  EventCalendar(this.ap, container) : super(container) {
    nav.prepend(cl_action.Button()
      ..setTitle(intl.Create_event())
      ..addClass('important')
      ..addAction((e) {
        ap.run<UserEvent>('user/event/0').calendar = this;
      }));
  }

  Future persistEvent(cl_calendar.Event event) async {
    Future _send([all = false]) async {
      final dto = EventPersistDTO()
        ..id = event.id
        ..date_start = event.start.toUtc()
        ..date_end = event.end.toUtc();

      if (EventDTO.getSubId(event.id) != null) {
        if (!all)
          dto.recurring_persist_exclude = event.startPrev.toUtc();
        else
          dto.recurring_persist = true;
      }
      await ap.serverCall(CRouter.itemPersist.reverse([]), dto);
      await refresh();
    }

    if (EventDTO.getSubId(event.id) != null)
      UserEvent.askEvent(ap, _send);
    else
      await _send();
  }

  Future<dynamic> loadEvents(DateTime start, DateTime end) {
    end = DateTime(end.year, end.month, end.day, 23, 59, 59);
    start = start.toUtc();
    end = end.toUtc();
    events = [];
    return ap
        .serverCall(
            CRouter.collection.reverse([]),
            {
              $UserEvent.date_start: start.toIso8601String(),
              $UserEvent.date_end: end.toIso8601String()
            },
            null)
        .then((data) {
      data.forEach((event_map) {
        final dto = EventDTO.fromMap(event_map);
        final event = cl_calendar.Event(
            dto.title, dto.date_start, dto.date_end, dto.all_day)
          ..id = dto.id
          ..color = 'color${dto.type}';
        events.add(event);
      });
    });
  }

  void createEvent(DateTime start_date, DateTime end_date,
      [bool full_day = false]) {
    ap.run<UserEvent>('user/event/0', [
      UserEventInit()
        ..calendar = this
        ..type = 1
        ..startDate = start_date
        ..endDate = end_date
        ..fullDay = full_day
    ]).addHook(ItemBase.save_after, (_) {
      refresh();
      return true;
    });
  }

  void editEvent(cl_calendar.Event event) {
    ap.run<UserEvent>(
        'user/event/${event.id}', [UserEventInit()..calendar = this])
      ..addHook(ItemBase.del_after, (_) {
        refresh();
        return true;
      })
      ..addHook(ItemBase.save_after, (_) {
        refresh();
        return true;
      });
  }
}

class UserEventInit {
  EventCalendar calendar;
  DateTime startDate;
  DateTime endDate;
  int type;
  bool fullDay;
}

class UserEvent extends ItemBuilder {
  UrlPattern contr_get = CRouter.itemGet;
  UrlPattern contr_save = CRouter.itemSave;
  UrlPattern contr_del = CRouter.itemDelete;

  EventCalendar calendar;

  UserEventInit initData;

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.Event()
    ..icon = 'i-calendar'
    ..width = 500
    ..height = 750;

  List<cl_gui.LabelField> hidden = [];

  bool all;

  cl_form.Input title = cl_form.Input()
    ..setRequired(true)
    ..setName($UserEvent.title);

  cl_form.Check chk = cl_form.Check('bool')..setName('check');
  cl_form.Check chk_day = cl_form.Check('bool')
    ..setName($UserEvent.all_day);
  cl_form.InputTime time1 = cl_form.InputTime()..setName('date_start_time');
  cl_form.InputTime time2 = cl_form.InputTime()..setName('date_end_time');
  cl_form.InputDate date_start = cl_form.InputDate()
    ..setName($UserEvent.date_start);
  cl_form.InputDate date_end = cl_form.InputDate()
    ..setName($UserEvent.date_end);
  cl_form.ColorChoose color_choose = cl_form.ColorChoose()
    ..setName($UserEvent.type);
  cl_form.TextArea description = cl_form.TextArea()
    ..setName($UserEvent.description);

  cl_form.Input chk2_input = cl_form.Input(cl_form.InputTypeInt())
    ..setName($RecurringDTO.end_after)
    ..addClass('xs')
    ..setContext($UserEvent.recurring);
  cl_form.InputDate chk3_input = cl_form.InputDate()
    ..setName($RecurringDTO.end_on)
    ..setContext($UserEvent.recurring);

  cl_form.Radio chk1 = cl_form.Radio()
    ..setValue(1)
    ..setLabel(intl.Never());
  cl_form.Radio chk2 = cl_form.Radio()
    ..setValue(2)
    ..setLabel(intl.After());
  cl_form.Radio chk3 = cl_form.Radio()
    ..setValue(3)
    ..setLabel(intl.On());
  cl_form.RadioGroup rgroup = cl_form.RadioGroup('check');

  cl_form.Input start = cl_form.InputDate()
    ..setName($RecurringDTO.start_on)
    ..setContext($UserEvent.recurring);
  cl_form.Select repeats = cl_form.Select()
    ..setName($RecurringDTO.repeat_type)
    ..setContext($UserEvent.recurring)
    ..addOption(RecurringDTO.DAILY, intl.Daily())
    ..addOption(RecurringDTO.WEEKLY, intl.Weekly())
    ..addOption(RecurringDTO.MONTHLY, intl.Monthly())
    ..addOption(RecurringDTO.YEARLY, intl.Yearly());

  cl_form.Select repeat_every = cl_form.Select()
    ..setName($RecurringDTO.repeat_every)
    ..setContext($UserEvent.recurring)
    ..addClass('s')
    ..addOption(1, '1')
    ..addOption(2, '2')
    ..addOption(3, '3')
    ..addOption(4, '4')
    ..addOption(5, '5')
    ..addOption(6, '6')
    ..addOption(7, '7')
    ..addOption(8, '8')
    ..addOption(9, '9')
    ..addOption(10, '10')
    ..addOption(11, '11')
    ..addOption(12, '12');

  UserEvent(ap, {id, this.initData}) : super(ap, id == '0' ? null : id) {
    chk.onValueChanged.listen((_) => checkRecurring());
    chk_day.onValueChanged.listen((_) => checkDay());
    rgroup..registerElement(chk1)..registerElement(chk2)..registerElement(chk3);
    rgroup.onValueChanged.listen((_) {
      final v = rgroup.getValue();
      switch (v) {
        case 1:
          chk2_input
            ..setValue(null)
            ..disable();
          chk3_input
            ..setValue(null)
            ..disable();
          break;
        case 2:
          chk2_input
            ..setValue(null)
            ..enable();
          chk3_input
            ..setValue(null)
            ..disable();
          break;
        case 3:
          chk2_input
            ..setValue(null)
            ..disable();
          chk3_input
            ..setValue(null)
            ..enable();
          break;
      }
    });
  }

  Future setDefaults() async {
    title.focus();
    if (initData != null) {
      calendar = initData.calendar;
      if (initData.startDate != null) {
        form.getElement($UserEvent.type).setValue(initData.type);
        setDates(initData.startDate, initData.endDate, initData.fullDay);
      }
    }
  }

  void setDates(DateTime date_start, DateTime date_end, bool all_day) {
    this.date_start.setValue(date_start);
    this.date_end.setValue(date_end);
    time1.setFromDateTime(date_start);
    time2.setFromDateTime(date_end);
    if (all_day) {
      chk_day.setValue(true);
      checkDay();
    }
  }

  Future setData() async {
    final recurring = data_response[$UserEvent.recurring];
    final date_start =
        DateTime.parse(data_response.remove($UserEvent.date_start));
    final date_end = DateTime.parse(data_response.remove($UserEvent.date_end));
    setDates(date_start, date_end, data_response.remove($UserEvent.all_day));
    if (recurring != null) {
      chk.setValue(true);
      checkRecurring();
      if (recurring[$RecurringDTO.end_on] != null)
        chk3.setValue(3);
      else if (recurring[$RecurringDTO.end_after] != null)
        chk2.setValue(2);
      else
        chk1.setValue(1);
    }
    form.setValue(data_response);
  }

  void prepareData() {
    super.prepareData();
    var date_start = this.date_start.getValue_();
    var date_end = this.date_end.getValue_();
    if (date_start == null) {
      this.date_start.setValid(false);
      return;
    }
    if (date_end == null) {
      this.date_end.setValid(false);
      return;
    }
    if (date_end.difference(date_start).inMinutes > 1440)
      chk_day.setValue(true);
    date_start =
        cl_util.Calendar.fromDateAndMinutes(date_start, time1.getValue());
    date_end = cl_util.Calendar.fromDateAndMinutes(date_end, time2.getValue());
    if (date_end.isBefore(date_start)) {
      this.date_end.setValid(false);
      time2.setValid(false);
      return;
    }
    this.date_start.setValid(true);
    this.date_end.setValid(true);
    time2.setValid(true);

    data_send['data'][$UserEvent.date_start] = date_start.toIso8601String();
    data_send['data'][$UserEvent.date_end] = date_end.toIso8601String();
    if (all != null && !all)
      data_send['data']['excludes'] = date_start.toIso8601String();
    if (!chk.getValue()) data_send['data'][$UserEvent.recurring] = null;
  }

  bool checkData() {
    if (getId() != null && chk.isChecked() && all == null) {
      askEvent(ap, (way) {
        all = way;
        save();
      });
      return false;
    }
    return super.checkData();
  }

  static void askEvent(cl_app.Application ap, EventMessageCallback callback) {
    final cont = cl.Container();
    final m = cl_action.Menu(cont);
    final b1 = cl_action.Button()..setTitle(intl.Only_this_instance());
    final b2 = cl_action.Button()
      ..setTitle(intl.All_events_in_the_series());
    m..add(b1)..add(b2);
    final mess = cl_app.Dialog(ap, cont)
      ..icon = cl.Icon.today
      ..title = intl.Event();
    b1
      ..setWidth(cl.Dimension.percent(100))
      ..addAction((e) {
        callback(false);
        mess.close();
      });
    b2
      ..setWidth(cl.Dimension.percent(100))
      ..addAction((e) {
        callback(true);
        mess.close();
      });
    mess.render(width: 300, height: 150);
  }

  void checkRecurring() {
    hidden.forEach((e) {
      if (chk.getValue())
        e.show();
      else
        e.hide();
    });
    if (chk.getValue()) {
      if (start.getValue() == null) {
        start.setValue(date_start.getValue_());
        chk1.setValue(1);
      }
      start.setRequired(true);
    } else {
      start.setRequired(false);
    }
  }

  void checkDay() {
    if (chk_day.getValue()) {
      time1
        ..setValue(0)
        ..hide();
      time2
        ..setValue(0)
        ..hide();
    } else {
      time1.show();
      time2.show();
    }
  }

  void setUI() {
    final t1 = cl_gui.FormElement(form)..addClass('top');
    final t = createTab(null, t1);
    layout.contInner.activeTab(t);
    t1
      ..addRow(intl.Title(), [title])
      ..addRow(null, [chk_day..setLabel(intl.All_day())])
      ..addRow(intl.Date_start(),
          [date_start..addClass('m'), time1..addClass('s')]).addClass('col3')
      ..addRow(intl.Date_end(), [date_end..addClass('m'), time2..addClass('s')])
          .addClass('col3')
      ..addRow(null, [color_choose])
      ..addRow(intl.Description(), [description])
      ..addRow(null, [chk..setLabel(intl.Reccuring())]);

    hidden
      ..add(
          t1.addRow(intl.Starts_on(), [start..addClass('m')])..addClass('col2'))
      ..add(t1.addRow(intl.Repeats(),
          [repeats..addClass('m'), intl.repeat_every(), repeat_every])
        ..addClass('col4'))
      ..add(t1.addRow(intl.Ends(), [chk1]))
      ..add(t1.addRow('', [chk2, chk2_input, intl.occurencies()]))
      ..add(t1.addRow('', [chk3, chk3_input..addClass('m')]))
      ..forEach((e) => e.hide());
  }
}
