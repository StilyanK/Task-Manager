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

    final shortTitle = getShortText(rCard.title);
    final shortDesc = getShortText(rCard.description);
    final nameCont = new cl.CLElement(
        new SpanElement()..append(new HeadingElement.h1()..text = shortTitle));

    final description = new cl.CLElement(new SpanElement())
      ..setText(removeHtmlTags(shortDesc));

    setHover(nameCont, rCard.title);
    setHover(description, removeHtmlTags(rCard.description));

    final endDate = local.Date(rCard.deadLine).getWithTime().toString();
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

    final bar = new cl_chart.BarSmall(100)..setPercents(0);

    Future<void> persistData(Map data) async {
      await ap.serverCall<Map>(RoutesTask.itemSave.reverse([]), {
        'id': rCard.id,
        'data': data,
      });
    }

    statusSelect.onValueChanged.listen((e) async {
      await persistData({'status': e.getValue()});
    });

    prioritySelect.onValueChanged.listen((e) async {
      await persistData({'priority': e.getValue()});
    });

    setHover(bar, 'Прогрес');
    setHover(dateContent, 'Дата за завършване');

    final cl_action.ButtonOption group = new cl_action.ButtonOption()
      ..setIcon(cl.Icon.print)
      ..addAction<Event>((e) => e.stopPropagation());

    void manageFields(int value) {
      if (value == rCard.progress) return;
      persistData({'progress': value});
    }

    final btn1 = new cl_action.Button()
      ..setTitle('20%')
      ..addAction((e) => manageFields(20));
    final btn2 = new cl_action.Button()
      ..setTitle('40%')
      ..addAction((e) => manageFields(40));
    final btn3 = new cl_action.Button()
      ..setTitle('60%')
      ..addAction((e) => manageFields(60));

    final btn4 = new cl_action.Button()
      ..setTitle('80%')
      ..addAction((e) => manageFields(80));

    final btn5 = new cl_action.Button()
      ..setTitle('100%')
      ..addAction((e) => manageFields(100));

    group..addSub(btn1)..addSub(btn2)..addSub(btn3)..addSub(btn4)..addSub(btn5);
    group.buttonOption.addClass('light');

    final actionCont2 = new cl.CLElement(new DivElement())
      ..append(bar.dom)
      ..append(group);
    actionCont.append(actionCont2);

    manageProgressStyle(bar, rCard.progress);

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

  void manageProgressStyle(cl_chart.BarSmall el, int percentage) {
    el
      ..removeClass('progress-20')
      ..removeClass('progress-40')
      ..removeClass('progress-60')
      ..removeClass('progress-80')
      ..removeClass('progress-100')
      ..addClass('progress-$percentage')
      ..setPercents(percentage);
  }
}

void setHover(cl.CLElement el, String text) {
  new cl_app.BubbleVisualizer(el, () => new DivElement()..text = '$text');
}

String getShortText(String text) {
  String shortText = '';
  if (text == null) return shortText;
  const int maxLen = 30;
  if (text.length > maxLen) {
    shortText = '${text.substring(0, maxLen)}...';
  } else {
    shortText = text;
  }
  return shortText;
}


