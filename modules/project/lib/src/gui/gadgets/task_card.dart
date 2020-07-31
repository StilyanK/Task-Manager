part of project.gui;

class CardTask extends local.Card<TaskDTO> {
  CardTask(ap, TaskDTO rCard) : super(ap, rCard.id, rCard);

  void createDom() {
    addClass('task-card');
    addClass('journal-card');

    final headCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-head'));

    final bodyCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-body'));

    final bodyContent =
        new cl.CLElement(new DivElement()..classes.add('journal-card-dates'));

    final actionCont =
        new cl.CLElement(new DivElement()..classes.add('journal-card-actions'));

    final nameCont = new cl.CLElement(
        new SpanElement()..append(new HeadingElement.h1()..text = rCard.title));

    final statusCont = new cl.CLElement(new DivElement())
      ..setClass('task-card-status');

    final st1 = new cl.CLElement(new SpanElement())
      ..setClass('status1')
      ..setText('In Progress');

    statusCont.append(st1);


//
//    final dateCont = new cl_base.CLElement(new SpanElement()
//      ..append(new Text(hms_local.Date(rCard.addedDate).get()))
//      ..classes.add('time'));
//
//    final pid = new SpanElement()..text = 'ЕГН: ${rCard.pid}';
//
//    final dateContent = new cl_base.CLElement(new DivElement());
//
//    final dateIconHosp = new cl_base.CLElement(
//        new SpanElement()..append(new cl_base.Icon(Icon.HadisIn).dom));
//
//    final dateIconDisch = new cl_base.CLElement(
//        new SpanElement()..append(new cl_base.Icon(Icon.HadisOut).dom));
//
//    final dateIconWait = new cl_base.CLElement(
//        new SpanElement()..append(new cl_base.Icon(hms_icon.Icon.timer).dom));
//
//    if (rCard.status == HospitalizationStatus.Hospitalized) {
//      dateContent.append(dateIconHosp);
//    } else if (rCard.status == HospitalizationStatus.Discharged) {
//      dateContent.append(dateIconDisch);
//    } else {
//      dateContent.append(dateIconWait);
//    }
//
//    dateContent.append(dateCont);
//
//    setHover(dateCont, status['hover']);
//
//    bodyContent..append(pid)..append(dateContent);
//
//    actionCont.append(new cl_action.Button()
//      ..setTip(intl.KDB_Examination())
//      ..setIcon(Icon.Examination)
//      ..addAction((e) {
//        e.stopPropagation();
//        new KDBExamination(ap, rCard.kdbExaminationId);
//      }));
//
//    if (rCard.caseHistoryId != null) {
//      actionCont.append(caseHistoryButton);
//    } else {
//      actionCont.append(hospButton);
//    }
    headCont
      ..append(nameCont)
      ..append(statusCont);
    bodyCont.append(bodyContent);
//
    append(headCont);
    append(bodyCont);
//    append(actionCont);
//
  }
}
