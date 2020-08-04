part of project.gui;

class TaskGadget extends local.CardListGadget<TaskDTO, CardTask> {
  TaskGadget(ap) : super(ap, 'Задачи', 'task/list', cl.Icon.schedule);

  cl_app.GadgetController<List<TaskDTO>> getController() {
    final init = (el) async {
      final res = await ap.serverCall(
          RoutesGadget.cardInfo.reverse([]),
          {
            'date': date.getValue(),
            'user_id': ap.client.userId,
          },
          el);
      return (res.map((el) => new TaskDTO.fromMap(el)).toList())
          .cast<TaskDTO>();
    };

    ap.onServerCall.filter(RoutesTask.eventCreate).listen((r) async {
      await _updateTaskWaiting(r);
    });

    ap.onServerCall.filter(RoutesTask.eventUpdate).listen((r) async {
      await _updateTaskWaiting(r);
    });

    ap.onServerCall.filter(RoutesTask.eventDelete).listen(removeCard);

    return new cl_app.GadgetController<List<TaskDTO>>(
        init: init, feed: ap.onServerCall.filter('event'));
  }

  Future<void> _updateTaskWaiting(int id) async {
    final res = await ap.serverCall<Map>(
        RoutesGadget.updateCard.reverse([]),
        {
          'id': id,
          'user_id': ap.client.userId,
        },
        this);
    if (res != null) updateCard(new TaskDTO.fromMap(res));
  }

  CardTask getCard(TaskDTO r) => new CardTask(ap, r);
}
