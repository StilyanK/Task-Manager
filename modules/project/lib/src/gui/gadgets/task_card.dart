part of project.gui;

class CardTask extends local.Card<TaskDTO> {
  CardTask(ap, TaskDTO rCard) : super(ap, rCard.id, rCard);

  void createDom() {
    addClass('task-card');
    addClass('journal-card');

    final statusSelect = new SelectTaskStatus();
    final prioritySelect = new SelectTaskPriority();
    final headCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-head'));

    final bodyCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-body'));

    final bodyContent =
        new cl.CLElement(new DivElement()..classes.add('journal-card-dates'));

    final actionCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-actions'));

    final nameCont = new cl.CLElement(new SpanElement()
      ..append(new HeadingElement.h1()
        ..text = 'Добавяне на опция в селекта на КДБ прегледа'));

    final description = new cl.CLElement(new SpanElement())
      ..setText('Необходимо е да се добави...');

    setHover(
        nameCont,
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа, '
        'Добавяне на опция в селекта на КДБ прегледа');
    setHover(
        description,
        'Необходимо е да се добави опция в селекта на КДБ прегледа,'
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа, '
        'опция в селекта на КДБ прегледа');

    final dateCreated = new cl.CLElement(new SpanElement())
      ..setClass('date-format')
      ..setText('25/07/2020');

    final dateContent = new cl.CLElement(new DivElement())..setClass('time');

    final dateIconWait = new cl.CLElement(
        new SpanElement()..append(new cl.Icon(icon.Icon.timer).dom));

    dateContent..append(dateIconWait)..append(dateCreated);

    final statusCont = new cl.CLElement(new DivElement())..append(statusSelect);

    final priorityCont = new cl.CLElement(new DivElement())
      ..setClass('priority')
      ..append(prioritySelect);

    int percent = 68;
    final bar = new cl_chart.BarSmall(100)..setPercents(percent);

    setHover(bar, 'Прогрес');
    setHover(dateContent, 'Дата за завършване');

    final cl_action.ButtonOption group = new cl_action.ButtonOption()
      ..setIcon(cl.Icon.print)
      ..addAction<Event>((e) => e.stopPropagation());

    final btn1 = new cl_action.Button()
      ..setTitle('20%')
      ..addAction((e) => null);
    final btn2 = new cl_action.Button()
      ..setTitle('40%')
      ..addAction((e) => null);
    final btn3 = new cl_action.Button()
      ..setTitle('60%')
      ..addAction((e) => null);
    final btn4 = new cl_action.Button()
      ..setTitle('80%')
      ..addAction((e) => null);
    final btn5 = new cl_action.Button()
      ..setTitle('100%')
      ..addAction((e) => null);

    group..addSub(btn1)..addSub(btn2)..addSub(btn3)..addSub(btn4)..addSub(btn5);

    final actionCont2 = new cl.CLElement(new DivElement())
      ..append(bar.dom)
      ..append(group);
    actionCont.append(actionCont2);
//    actionCont.append(group);

    bodyCont..append(description)..append(priorityCont);

    headCont..append(nameCont)..append(statusCont);

    actionCont.append(dateContent);

    append(headCont);
    append(bodyCont);
    append(actionCont);
  }
}

void setHover(cl.CLElement el, String text) {
  new cl_app.BubbleVisualizer(el, () => new DivElement()..text = '$text');
}
