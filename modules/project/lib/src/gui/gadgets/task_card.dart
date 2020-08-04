part of project.gui;

class CardTask extends local.Card<TaskDTO> {
  CardTask(ap, TaskDTO rCard) : super(ap, rCard.id, rCard);

  void createDom() {
    addClass('task-card');
    addClass('journal-card');

    final statusSelect = new SelectTaskStatus()..setValue(rCard.status);
    final prioritySelect = new SelectTaskPriority()..setValue(rCard.priority);
    final headCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-head'));

    final bodyCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-body'));

    final bodyContent =
        new cl.CLElement(new DivElement()..classes.add('journal-card-dates'));

    final actionCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-actions'));

    final nameCont = new cl.CLElement(new SpanElement()
      ..append(new HeadingElement.h1()..text = rCard.shortTitle));

    final description = new cl.CLElement(new SpanElement())
      ..setText(rCard.shortDescription);

    setHover(nameCont, rCard.longTitle);
    setHover(description, rCard.longDescription);

    final endDate = local.Date(rCard.deadLine).get().toString();
    final dateCreated = new cl.CLElement(new SpanElement())
      ..setClass('date-format')
      ..setText(endDate);

    final dateContent = new cl.CLElement(new DivElement())..setClass('time');

    final dateIconWait = new cl.CLElement(
        new SpanElement()..append(new cl.Icon(icon.Icon.timer).dom));

    dateContent..append(dateIconWait)..append(dateCreated);

    final statusCont = new cl.CLElement(new DivElement())..append(statusSelect);

    final priorityCont = new cl.CLElement(new DivElement())
      ..setClass('priority')
      ..append(prioritySelect);

    final bar = new cl_chart.BarSmall(100);

    manageProgressData(bar, rCard.progress);
    manageProgressStyle(bar, rCard.progress);

    statusSelect.onValueChanged.listen((e) async {
      await ap.serverCall<Map>(RoutesTask.itemSave.reverse([]), {
        'id': rCard.id,
        'data': {'status': e.getValue()},
      });
    });

    prioritySelect.onValueChanged.listen((e) async {
      await ap.serverCall<Map>(RoutesTask.itemSave.reverse([]), {
        'id': rCard.id,
        'data': {'priority': e.getValue()},
      });
    });

    setHover(bar, 'Прогрес');
    setHover(dateContent, 'Дата за завършване');

    final cl_action.ButtonOption group = new cl_action.ButtonOption()
      ..setIcon(cl.Icon.print)
      ..addAction<Event>((e) => e.stopPropagation());

    final btn1 = new cl_action.Button()
      ..setTitle('20%')
      ..addAction((e) {
        manageProgressStyle(bar, 20);
        manageProgressData(bar, 20);
      });
    final btn2 = new cl_action.Button()
      ..setTitle('40%')
      ..addAction((e) {
        manageProgressStyle(bar, 40);
        manageProgressData(bar, 40);
      });
    final btn3 = new cl_action.Button()
      ..setTitle('60%')
      ..addAction((e) {
        manageProgressStyle(bar, 60);
        manageProgressData(bar, 60);
      });
    final btn4 = new cl_action.Button()
      ..setTitle('80%')
      ..addAction((e) {
        manageProgressStyle(bar, 80);
        manageProgressData(bar, 80);
      });
    final btn5 = new cl_action.Button()
      ..setTitle('100%')
      ..addAction((e) {
        manageProgressStyle(bar, 100);
        manageProgressData(bar, 100);
      });

    group..addSub(btn1)..addSub(btn2)..addSub(btn3)..addSub(btn4)..addSub(btn5);

    final actionCont2 = new cl.CLElement(new DivElement())
      ..append(bar.dom)
      ..append(group);
    actionCont.append(actionCont2);

    bodyCont..append(description)..append(priorityCont);

    headCont..append(nameCont)..append(statusCont);

    actionCont.append(dateContent);

    append(headCont);
    append(bodyCont);
    append(actionCont);

    addAction((e) {
      e.stopPropagation();
      new TaskGui(ap, id: id);
    });
  }

  Future<void> manageProgressData(cl_chart.BarSmall el, int percentage) async {
    el.setPercents(percentage);
    await ap.serverCall<Map>(RoutesTask.itemSave.reverse([]), {
      'id': rCard.id,
      'data': {'progress': percentage},
    });
  }

  void manageProgressStyle(cl_chart.BarSmall el, int percentage) {
    if (percentage == 20) {
      el
        ..removeClass('progress-40')
        ..removeClass('progress-60')
        ..removeClass('progress-80')
        ..removeClass('progress-100')
        ..addClass('progress-20');
    } else if (percentage == 40) {
      el
        ..removeClass('progress-20')
        ..removeClass('progress-60')
        ..removeClass('progress-80')
        ..removeClass('progress-100')
        ..addClass('progress-40');
    } else if (percentage == 60) {
      el
        ..removeClass('progress-20')
        ..removeClass('progress-40')
        ..removeClass('progress-80')
        ..removeClass('progress-100')
        ..addClass('progress-60');
    } else if (percentage == 80) {
      el
        ..removeClass('progress-20')
        ..removeClass('progress-40')
        ..removeClass('progress-60')
        ..removeClass('progress-100')
        ..addClass('progress-80');
    } else if (percentage == 100) {
      el
        ..removeClass('progress-20')
        ..removeClass('progress-40')
        ..removeClass('progress-60')
        ..removeClass('progress-80')
        ..addClass('progress-100');
    }
  }
}

void setHover(cl.CLElement el, String text) {
  new cl_app.BubbleVisualizer(el, () => new DivElement()..text = '$text');
}
