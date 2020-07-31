part of project.gui;

class TaskGadget extends local.CardListGadget<TaskDTO, CardTask> {
  TaskGadget(ap) : super(ap, 'Задачи', 'task/list', cl.Icon.schedule);

  cl_app.GadgetController<List<TaskDTO>> getController() {
    final init = (el) async {
      final List<TaskDTO> result = [];
      final res = await ap.serverCall(
          RoutesTask.cardInfo.reverse([]),
          {
            'date': date.getValue(),
          },
          el);

      return (res.map((el) => new TaskDTO.fromMap(el)).toList())
          .cast<TaskDTO>();
    };

//    ap.onServerCall
//        .filter(RoutesTask.eventCreate)
//        .listen((r) async {
//    });
//
//    ap.onServerCall
//        .filter(RoutesTask.eventUpdate)
//        .listen((r) async {
//    });
//
//    ap.onServerCall
//        .filter(RoutesTask.eventDelete)
//        .listen(removeCard);

    return new cl_app.GadgetController<List<TaskDTO>>(
        init: init, feed: ap.onServerCall.filter('event'));
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

  CardTask getCard(TaskDTO r) => new CardTask(ap, r);
}
