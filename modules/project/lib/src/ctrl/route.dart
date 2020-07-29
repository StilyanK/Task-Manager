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
//  router
//      .serve(RoutesBloodRequest.collectionGet, method: 'POST')
//      .listen((req) => new CBloodRequest(req).get());
//  router
//      .serve(RoutesBloodRequest.collectionDelete, method: 'POST')
//      .listen((req) => new CBloodRequest(req).delete());
//  router
//      .serve(RoutesBloodRequest.getPatientBloodGroup, method: 'POST')
//      .listen((req) => new IBloodRequest(req).getPatientBloodGroup());
}
