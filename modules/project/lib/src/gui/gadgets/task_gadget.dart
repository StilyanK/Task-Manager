part of project.gui;

class TaskGadget extends hms_local.CardListGadget<TaskDTO, CardWaiting> {
  TaskGadget(ap)
      : super(ap, 'Задачи', 'hospital/hospitalization-queue-patient/list',
            Icon.Calendar);

  cl_app.GadgetController<List<TaskDTO>> getController() {
//    final init = (el) async {
//      final res = await ap.serverCall<List>(
//          RoutesGadget.allWaiting.reverse([]),
//          {
//            'date': date.getValue(),
//            'code': getDepStationary(ap.client.departments)
//          },
//          el);
//
//      return res.map((el) => new WaitingPatientsDTO.fromMap(el)).toList();
//    };
//
//    ap.onServerCall
//        .filter(RoutesHospitalizationQueuePatient.eventCreate)
//        .listen((r) async {
//      await _updateCardWaiting(r);
//    });
//
//    ap.onServerCall
//        .filter(RoutesHospitalizationQueuePatient.eventUpdate)
//        .listen((r) async {
//      await _updateCardWaiting(r);
//    });
//
//    ap.onServerCall.filter(RoutesCaseHistory.eventUpdate).listen((r) async {
//      final res = await ap.serverCall<Map>(
//          RoutesGadget.waiting.reverse([]),
//          {
//            'case_history_id': r,
//            'date': date.getValue(),
//            'dep': getDepStationary(ap.client.departments)
//          },
//          this);
//      if (res != null) updateCard(new WaitingPatientsDTO.fromMap(res));
//    });
//
//    ap.onServerCall
//        .filter(RoutesHospitalizationQueuePatient.eventDelete)
//        .listen(removeCard);

    return new cl_app.GadgetController<List<TaskDTO>>(
        feed: ap.onServerCall.filter('event'));
  }

//
//  Future<void> _updateCardWaiting(int id) async {
//    final res = await ap.serverCall<Map>(
//        RoutesGadget.waiting.reverse([]),
//        {
//          'id': id,
//          'date': date.getValue(),
//          'dep': getDepStationary(ap.client.departments)
//        },
//        this);
//    if (res != null) updateCard(new WaitingPatientsDTO.fromMap(res));
//  }

  CardWaiting getCard(TaskDTO r) => new CardWaiting(ap, r);
}
