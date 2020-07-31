part of local.ctrl;

Future<Map<dynamic, dynamic>> bootCall(Map data) {
  data['quantity'] = fetchQuantityUnits();
  data['weight'] = fetchWeightUnits();
  data['currency'] = fetchCurrency();
  data['tax'] = fetchTax();
  data['language'] = fetchLanguage();
  data['payments'] = fetchPaymentMethod();
  data['lab_units'] = fetchLabUnits();
  return new Future.value(data);
}

void routesLabUnit(Router router) {
  router
      .serve(RoutesLabUnit.itemGet, method: 'POST')
      .listen((req) => new ILabUnit(req).get());
  router
      .serve(RoutesLabUnit.itemSave, method: 'POST')
      .listen((req) => new ILabUnit(req).save());
  router
      .serve(RoutesLabUnit.itemDelete, method: 'POST')
      .listen((req) => new ILabUnit(req).delete());
  router
      .serve(RoutesLabUnit.collectionGet, method: 'POST')
      .listen((req) => new CLabUnit(req).get());
  router
      .serve(RoutesLabUnit.collectionDelete, method: 'POST')
      .listen((req) => new CLabUnit(req).delete());
  router
      .serve(RoutesLabUnit.collectionPair, method: 'POST')
      .listen((req) => new CLabUnit(req).pair());
}

void routesAddress(Router router) {
  router
      .serve(RoutesAddress.itemGet, method: 'POST')
      .listen((req) => new IAddress(req).get());
  router
      .serve(RoutesAddress.itemSave, method: 'POST')
      .listen((req) => new IAddress(req).save());
  router
      .serve(RoutesAddress.itemDelete, method: 'POST')
      .listen((req) => new IAddress(req).delete());
  router
      .serve(RoutesAddress.collectionGet, method: 'POST')
      .listen((req) => new CAddress(req).get());
  router
      .serve(RoutesAddress.collectionDelete, method: 'POST')
      .listen((req) => new CAddress(req).delete());
}

void routesCountry(Router router) {
  router
      .serve(RoutesCountry.itemGet, method: 'POST')
      .listen((req) => new ICountry(req).get());
  router
      .serve(RoutesCountry.itemSave, method: 'POST')
      .listen((req) => new ICountry(req).save());
  router
      .serve(RoutesCountry.itemDelete, method: 'POST')
      .listen((req) => new ICountry(req).delete());
  router
      .serve(RoutesCountry.collectionGet, method: 'POST')
      .listen((req) => new CCountry(req).get());
  router
      .serve(RoutesCountry.collectionDelete, method: 'POST')
      .listen((req) => new CCountry(req).delete());
  router
      .serve(RoutesCountry.collectionPair, method: 'POST')
      .listen((req) => new CCountry(req).pair());
  router
      .serve(RoutesCountry.collectionPairCodes, method: 'POST')
      .listen((req) => new CCountry(req).pairCodes());
  router
      .serve(RoutesCountry.collectionSuggest, method: 'POST')
      .listen((req) => new CCountry(req).suggest());
}

void routesZone(Router router) {
  router
      .serve(RoutesZone.itemGet, method: 'POST')
      .listen((req) => new IZone(req).get());
  router
      .serve(RoutesZone.itemSave, method: 'POST')
      .listen((req) => new IZone(req).save());
  router
      .serve(RoutesZone.itemDelete, method: 'POST')
      .listen((req) => new IZone(req).delete());
  router
      .serve(RoutesZone.collectionGet, method: 'POST')
      .listen((req) => new CZone(req).get());
  router
      .serve(RoutesZone.collectionDelete, method: 'POST')
      .listen((req) => new CZone(req).delete());
  router
      .serve(RoutesZone.collectionPair, method: 'POST')
      .listen((req) => new CZone(req).pair());
}

void routesCurrency(Router router) {
  router
      .serve(RoutesCurrency.itemGet, method: 'POST')
      .listen((req) => new ICurrency(req).get());
  router
      .serve(RoutesCurrency.itemSave, method: 'POST')
      .listen((req) => new ICurrency(req).save());
  router
      .serve(RoutesCurrency.itemDelete, method: 'POST')
      .listen((req) => new ICurrency(req).delete());
  router
      .serve(RoutesCurrency.collectionGet, method: 'POST')
      .listen((req) => new CCurrency(req).get());
  router
      .serve(RoutesCurrency.collectionDelete, method: 'POST')
      .listen((req) => new CCurrency(req).delete());
  router
      .serve(RoutesCurrency.update, method: 'POST')
      .listen((req) => new CCurrency(req).update());
}

void routesDictionary(Router router) {
  router
      .serve(RoutesDictionary.itemGet, method: 'POST')
      .listen((req) => new IDictionary(req).get());
  router
      .serve(RoutesDictionary.itemSave, method: 'POST')
      .listen((req) => new IDictionary(req).save());
  router
      .serve(RoutesDictionary.itemDelete, method: 'POST')
      .listen((req) => new IDictionary(req).delete());
  router
      .serve(RoutesDictionary.collectionGet, method: 'POST')
      .listen((req) => new CDictionary(req).get());
  router
      .serve(RoutesDictionary.collectionDelete, method: 'POST')
      .listen((req) => new CDictionary(req).delete());
  router
      .serve(RoutesDictionary.getTR, method: 'POST')
      .listen((req) => new CDictionary(req).getAllTR());
}

void routesLanguage(Router router) {
  router
      .serve(RoutesLanguage.itemGet, method: 'POST')
      .listen((req) => new ILanguage(req).get());
  router
      .serve(RoutesLanguage.itemSave, method: 'POST')
      .listen((req) => new ILanguage(req).save());
  router
      .serve(RoutesLanguage.itemDelete, method: 'POST')
      .listen((req) => new ILanguage(req).delete());
  router
      .serve(RoutesLanguage.collectionGet, method: 'POST')
      .listen((req) => new CLanguage(req).get());
  router
      .serve(RoutesLanguage.collectionDelete, method: 'POST')
      .listen((req) => new CLanguage(req).delete());
  router
      .serve(RoutesLanguage.collectionPair, method: 'POST')
      .listen((req) => new CLanguage(req).pair());
}

void routesPayment(Router router) {
  router
      .serve(RoutesPayment.itemGet, method: 'POST')
      .listen((req) => new IPayment(req).get());
  router
      .serve(RoutesPayment.itemSave, method: 'POST')
      .listen((req) => new IPayment(req).save());
  router
      .serve(RoutesPayment.itemDelete, method: 'POST')
      .listen((req) => new IPayment(req).delete());
  router
      .serve(RoutesPayment.genPaypalWebHook, method: 'POST')
      .listen((req) => new IPayment(req).generatePaypalWebhook());
  router
      .serve(RoutesPayment.delPaypalWebHook, method: 'POST')
      .listen((req) => new IPayment(req).deletePaypalWebhook());
  router
      .serve(RoutesPayment.collectionGet, method: 'POST')
      .listen((req) => new CPayment(req).get());
  router
      .serve(RoutesPayment.collectionDelete, method: 'POST')
      .listen((req) => new CPayment(req).delete());
  router
      .serve(RoutesPayment.collectionPair, method: 'POST')
      .listen((req) => new CPayment(req).pair());
  router
      .serve(RoutesPayment.paymentEpay, method: 'POST')
      .listen((req) => new IPayment(req).paymentEpay());
  router
      .serve(RoutesPayment.paymentPaypal, method: 'POST')
      .listen((req) => new IPayment(req).paymentPaypal());
  router
      .serve(RoutesPayment.paymentStripe, method: 'POST')
      .listen((req) => new IPayment(req).paymentStripe());
}

void routesQuantity(Router router) {
  router
      .serve(RoutesQuantity.itemGet, method: 'POST')
      .listen((req) => new IQuantity(req).get());
  router
      .serve(RoutesQuantity.itemSave, method: 'POST')
      .listen((req) => new IQuantity(req).save());
  router
      .serve(RoutesQuantity.itemDelete, method: 'POST')
      .listen((req) => new IQuantity(req).delete());
  router
      .serve(RoutesQuantity.collectionGet, method: 'POST')
      .listen((req) => new CQuantity(req).get());
  router
      .serve(RoutesQuantity.collectionDelete, method: 'POST')
      .listen((req) => new CQuantity(req).delete());
  router
      .serve(RoutesQuantity.collectionPair, method: 'POST')
      .listen((req) => new CQuantity(req).pair());
}

void routesTax(Router router) {
  router
      .serve(RoutesTRate.itemGet, method: 'POST')
      .listen((req) => new ITaxRate(req).get());
  router
      .serve(RoutesTRate.itemSave, method: 'POST')
      .listen((req) => new ITaxRate(req).save());
  router
      .serve(RoutesTRate.itemDelete, method: 'POST')
      .listen((req) => new ITaxRate(req).delete());
  router
      .serve(RoutesTRate.collectionGet, method: 'POST')
      .listen((req) => new CTaxRate(req).get());
  router
      .serve(RoutesTRate.collectionDelete, method: 'POST')
      .listen((req) => new CTaxRate(req).delete());

  router
      .serve(RoutesTClient.itemGet, method: 'POST')
      .listen((req) => new ITaxClient(req).get());
  router
      .serve(RoutesTClient.itemSave, method: 'POST')
      .listen((req) => new ITaxClient(req).save());
  router
      .serve(RoutesTClient.itemDelete, method: 'POST')
      .listen((req) => new ITaxClient(req).delete());
  router
      .serve(RoutesTClient.collectionGet, method: 'POST')
      .listen((req) => new CTaxClient(req).get());
  router
      .serve(RoutesTClient.collectionDelete, method: 'POST')
      .listen((req) => new CTaxClient(req).delete());

  router
      .serve(RoutesTProduct.itemGet, method: 'POST')
      .listen((req) => new ITaxProduct(req).get());
  router
      .serve(RoutesTProduct.itemSave, method: 'POST')
      .listen((req) => new ITaxProduct(req).save());
  router
      .serve(RoutesTProduct.itemDelete, method: 'POST')
      .listen((req) => new ITaxProduct(req).delete());
  router
      .serve(RoutesTProduct.collectionGet, method: 'POST')
      .listen((req) => new CTaxProduct(req).get());
  router
      .serve(RoutesTProduct.collectionDelete, method: 'POST')
      .listen((req) => new CTaxProduct(req).delete());

  router
      .serve(RoutesTRule.itemGet, method: 'POST')
      .listen((req) => new ITaxRule(req).get());
  router
      .serve(RoutesTRule.itemSave, method: 'POST')
      .listen((req) => new ITaxRule(req).save());
  router
      .serve(RoutesTRule.itemDelete, method: 'POST')
      .listen((req) => new ITaxRule(req).delete());
  router
      .serve(RoutesTRule.collectionGet, method: 'POST')
      .listen((req) => new CTaxRule(req).get());
  router
      .serve(RoutesTRule.collectionDelete, method: 'POST')
      .listen((req) => new CTaxRule(req).delete());
}

void routesWeight(Router router) {
  router
      .serve(RoutesWeight.itemGet, method: 'POST')
      .listen((req) => new IWeight(req).get());
  router
      .serve(RoutesWeight.itemSave, method: 'POST')
      .listen((req) => new IWeight(req).save());
  router
      .serve(RoutesWeight.itemDelete, method: 'POST')
      .listen((req) => new IWeight(req).delete());
  router
      .serve(RoutesWeight.collectionGet, method: 'POST')
      .listen((req) => new CWeight(req).get());
  router
      .serve(RoutesWeight.collectionDelete, method: 'POST')
      .listen((req) => new CWeight(req).delete());
  router
      .serve(RoutesWeight.collectionPair, method: 'POST')
      .listen((req) => new CWeight(req).pair());
}

void routesRhif(Router router) {
  router
      .serve(RoutesRhif.itemGet, method: 'POST')
      .listen((req) => new IRhif(req).get());
  router
      .serve(RoutesRhif.itemSave, method: 'POST')
      .listen((req) => new IRhif(req).save());
  router
      .serve(RoutesRhif.itemDelete, method: 'POST')
      .listen((req) => new IRhif(req).delete());
  router
      .serve(RoutesRhif.collectionGet, method: 'POST')
      .listen((req) => new CRhif(req).get());
  router
      .serve(RoutesRhif.collectionPairCode, method: 'POST')
      .listen((req) => new CRhif(req).pairCode());
}

void routesRegion(Router router) {
  router
      .serve(RoutesRegion.itemGet, method: 'POST')
      .listen((req) => new IRegion(req).get());
  router
      .serve(RoutesRegion.itemSave, method: 'POST')
      .listen((req) => new IRegion(req).save());
  router
      .serve(RoutesRegion.itemDelete, method: 'POST')
      .listen((req) => new IRegion(req).delete());
  router
      .serve(RoutesRegion.collectionGet, method: 'POST')
      .listen((req) => new CRegion(req).get());
  router
      .serve(RoutesRegion.collectionPairCode, method: 'POST')
      .listen((req) => new CRegion(req).pairCode());
}

void routesPlace(Router router) {
  router
      .serve(RoutesPlace.itemGet, method: 'POST')
      .listen((req) => new IPlace(req).get());
  router
      .serve(RoutesPlace.itemSave, method: 'POST')
      .listen((req) => new IPlace(req).save());
  router
      .serve(RoutesPlace.itemDelete, method: 'POST')
      .listen((req) => new IPlace(req).delete());
  router
      .serve(RoutesPlace.collectionGet, method: 'POST')
      .listen((req) => new CPlace(req).get());
  router
      .serve(RoutesPlace.collectionPair, method: 'POST')
      .listen((req) => new CPlace(req).pair());
  router
      .serve(RoutesPlace.collectionSuggest, method: 'POST')
      .listen((req) => new CPlace(req).suggest());
}
