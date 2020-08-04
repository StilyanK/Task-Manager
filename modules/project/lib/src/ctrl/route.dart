part of project.ctrl;

void routesTask(Router router) {
  router
      .serve(RoutesTask.itemGet, method: 'POST')
      .listen((req) => new ITask(req).get());
  router
      .serve(RoutesTask.itemSave, method: 'POST')
      .listen((req) => new ITask(req).save());
  router
      .serve(RoutesTask.itemDelete, method: 'POST')
      .listen((req) => new ITask(req).delete());
  router
      .serve(RoutesTask.collectionGet, method: 'POST')
      .listen((req) => new TaskCollection(req).get());
  router
      .serve(RoutesTask.collectionDelete, method: 'POST')
      .listen((req) => new TaskCollection(req).delete());
  router
      .serve(RoutesTask.collectionPair, method: 'POST')
      .listen((req) => new TaskCollection(req).pair());
  notifierTask.onCreate
      .listen((o) => base.sendEvent(RoutesTask.eventCreate, o.entity.task_id));
  notifierTask.onUpdate
      .listen((o) => base.sendEvent(RoutesTask.eventUpdate, o.entity.task_id));
  notifierTask.onDelete
      .listen((o) => base.sendEvent(RoutesTask.eventDelete, o.entity.task_id));
}

void routesGadget(Router router) {
  router
      .serve(RoutesGadget.updateCard, method: 'POST')
      .listen((req) => new ITask(req).updateTaskCard());
  router
      .serve(RoutesGadget.cardInfo, method: 'POST')
      .listen((req) => new TaskCollection(req).getCardInfo());
}
