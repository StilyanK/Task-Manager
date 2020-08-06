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
}

void routesGadget(Router router) {
  router
      .serve(RoutesGadget.updateCard, method: 'POST')
      .listen((req) => new ITask(req).updateTaskCard());
  router
      .serve(RoutesGadget.cardInfo, method: 'POST')
      .listen((req) => new TaskCollection(req).getCardInfo());
}

void routesProject(Router router) {
  router
      .serve(RoutesProject.itemGet, method: 'POST')
      .listen((req) => new IProject(req).get());
  router
      .serve(RoutesProject.itemSave, method: 'POST')
      .listen((req) => new IProject(req).save());
  router
      .serve(RoutesProject.itemDelete, method: 'POST')
      .listen((req) => new IProject(req).delete());
  router
      .serve(RoutesProject.collectionGet, method: 'POST')
      .listen((req) => new CProject(req).get());
  router
      .serve(RoutesProject.collectionDelete, method: 'POST')
      .listen((req) => new CProject(req).delete());

  router
      .serve(RoutesProject.collectionSuggest, method: 'POST')
      .listen((req) => new IProject(req).suggest());
}


