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
      .serve(RoutesTask.cardInfo, method: 'POST')
      .listen((req) => new TaskCollection(req).getCardInfo());
  router
      .serve(RoutesTask.collectionPair, method: 'POST')
      .listen((req) => new TaskCollection(req).pair());
}
