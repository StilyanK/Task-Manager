part of project.gui;

class CardTask extends local.Card<TaskDTO> {
  CardTask(ap, TaskDTO rCard) : super(ap, rCard.id, rCard);

  void createDom() {
    addClass('task-card');
    addClass('journal-card');

    final statusSelect = new SelectTaskStatus()..setValue(rCard.status);
    final prioritySelect = new SelectTaskPriority()..setValue(rCard.priority);
    final progress = new ProgressComponent()..setValue(rCard.progress);
    final headCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-head'));

    final bodyCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-body'));

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


    Future<void> persistData(Map data) async {
      await ap.serverCall<Map>(RoutesTask.itemSave.reverse([]), {
        'id': rCard.id,
        'data': data,
      });
    }

    progress.onValueChanged.listen((e) async {
      await persistData({'progress': e.getValue()});
    });

    statusSelect.onValueChanged.listen((e) async {
      await persistData({'status': e.getValue()});
    });

    prioritySelect.onValueChanged.listen((e) async {
      await persistData({'priority': e.getValue()});
    });

    setHover(dateContent, 'Дата за завършване');

    final cl_action.ButtonOption group = new cl_action.ButtonOption()
      ..setIcon(cl.Icon.print)
      ..addAction<Event>((e) => e.stopPropagation());

    actionCont.append(statusSelect);

    bodyCont..append(prioritySelect)..append(progress);

    headCont..append(nameCont)..append(description);

    actionCont.append(dateContent);

    dateContent..append(dateIconWait)..append(dateCreated);

    append(headCont);
    append(bodyCont);
    append(actionCont);

    addAction((e) {
      e.stopPropagation();
      new TaskGui(ap, id: id);
    });
  }

}

void setHover(cl.CLElement el, String text) {
  new cl_app.BubbleVisualizer(el, () => new DivElement()..text = '$text');
}

String getShortText(String text) {
  String shortText = '';
  if (text == null) return shortText;
  const int maxLen = 50;
  if (text.length > maxLen) {
    shortText = '${text.substring(0, maxLen)}...';
  } else {
    shortText = text;
  }
  return shortText;
}


