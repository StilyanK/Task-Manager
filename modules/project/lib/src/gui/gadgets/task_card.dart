part of project.gui;

class CardWaiting extends hms_local.Card<TaskDTO> {
  CardWaiting(ap, TaskDTO rCard) : super(ap, 1, rCard);

  void createDom() {
//    addClass('patient');
//    addClass('waiting-card');
//
//    final status = getStatusInfo(rCard.status);
//
//    final hospButton = new cl_action.Button()
//      ..setTip(intl.New_hospitalization())
//      ..setIcon(Icon.Hospitalizaion)
//      ..setStyle({'margin-left': '5px'})
//      ..addClass('important')
//      ..addAction((_) async {
//        _.stopPropagation();
//        final res = await ap.serverCall<Map>(
//            RoutesHospitalizationQueuePatient.initHospitalization.reverse([]), {
//          'kdb_id': rCard.kdbExaminationId,
//          'queue_id': rCard.id,
//        });
//        final dto = new HospitalizationInitDTO.fromMap(res);
//
//        final initData = new HospitalizationInit(rCard.patientId)
//          ..clinicalPathId = dto.clinicalPathId
//          ..externalReferralId = dto.externalRefferalId
//          ..plannedDate = rCard.plannedDate
//          ..kdbExaminationId = rCard.kdbExaminationId
//          ..kdbExaminationEnd = dto.examinationEnd
//          ..customerGroup = dto.customerGroup
//          ..departmentCode = dto.departmentCode
//          ..treatingDoctor = dto.treatingDoctor
//          ..hospitalizationQueueId = rCard.id
//          ..ambulatoryProcedureId = dto.ambulatoryPrId
//          ..mainDiagnosis = [dto.icd10, dto.icd10_second]
//          ..accDiseases = dto.accDisease;
//
//        new Hospitalization(ap, null, initData);
//      });
//
//    final caseHistoryButton = new cl_action.Button()
//      ..setTip(intl.Case_history())
//      ..setIcon(Icon.CaseHistory)
//      ..setStyle({'margin-left': '5px'})
//      ..addClass('important')
//      ..addAction((e) {
//        e.stopPropagation();
//        define_hospital_api.loadCaseHistory(ap, rCard.caseHistoryId);
//      });
//
//    final headCont = new cl_base.CLElement(
//        new DivElement()..classes.add('journal-card-head'));
//
//    final bodyCont = new cl_base.CLElement(
//        new DivElement()..classes.add('journal-card-body'));
//
//    final bodyContent = new cl_base.CLElement(
//        new DivElement()..classes.add('journal-card-dates'));
//
//    final actionCont = new cl_base.CLElement(
//        new DivElement()..classes.add('journal-card-actions'));
//
//    final nameCont = new cl_base.CLElement(
//        new SpanElement()..append(new HeadingElement.h1()..text = rCard.name));
//
//    final statusCont = new cl_base.CLElement(new DivElement())
//      ..setClass('status-waiting color${status['color']}')
//      ..setText(status['text']);
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
//    headCont..append(nameCont)..append(statusCont);
//    bodyCont.append(bodyContent);
//
//    append(headCont);
//    append(bodyCont);
//    append(actionCont);
//
//    addAction((e) {
//      new HospitalizationQueuePatient(ap, rCard.id);
//    });
  }
}
