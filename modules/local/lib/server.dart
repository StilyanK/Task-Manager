import 'dart:async';

import 'package:cl_base/server.dart' as base;
import 'package:cl_base/task.dart' as task;
import 'package:auth/server.dart' as auth;
import 'package:timezone/data/latest.dart';

import 'src/ctrl.dart';
import 'src/mapper.dart';
import 'src/path.dart';
import 'src/permission.dart';

export 'src/mapper.dart';
export 'src/server.dart';
export 'src/shared.dart';
export 'src/svc/server/timezone/timezone.dart';

void init() {
  initializeTimeZones();

  base.boot_call.add(bootCall);

  base.routes.add(routesCountry);
  base.routes.add(routesZone);
  base.routes.add(routesCurrency);
  base.routes.add(routesLanguage);
  base.routes.add(routesDictionary);
  base.routes.add(routesTax);
  base.routes.add(routesQuantity);
  base.routes.add(routesWeight);
  base.routes.add(routesPayment);
  base.routes.add(routesAddress);
  base.routes.add(routesRhif);
  base.routes.add(routesRegion);
  base.routes.add(routesPlace);
  base.routes.add(routesLabUnit);

  entityLaboratoryUnit.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadLabUnits(manager);
            base.sendEvent(EVENT_LAB_UNIT, fetchLabUnits());
          }));

  entityCurrency.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadCurrencies(manager);
            base.sendEvent(EVENT_CURRENCY, fetchCurrency());
          }));

  entityCurrencyHistory.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadCurrencies(manager);
            base.sendEvent(EVENT_CURRENCY, fetchCurrency());
          }));

  entityLanguage.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadLanguages(manager);
            base.sendEvent(EVENT_LANGUAGE, fetchLanguage());
          }));

  entityPaymentMethod.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadPayments(manager);
            base.sendEvent(EVENT_PAYMENT, fetchPaymentMethod());
          }));

  entityTaxProduct.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadTaxes(manager);
            base.sendEvent(EVENT_TAX, fetchTax());
          }));

  entityTaxClient.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadTaxes(manager);
            base.sendEvent(EVENT_TAX, fetchTax());
          }));

  entityTaxRate.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadTaxes(manager);
            base.sendEvent(EVENT_TAX, fetchTax());
          }));

  entityTaxRule.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadTaxes(manager);
            base.sendEvent(EVENT_TAX, fetchTax());
          }));

  entityLanguage.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadLanguages(manager);
            base.sendEvent(EVENT_LANGUAGE, fetchLanguage());
          }));

  entityQuantity.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadUnits(manager);
            base.sendEvent(EVENT_QUANTITY, fetchQuantityUnits());
          }));

  entityWeight.onChange
      .listen((e) => base.dbWrap<void, App>(new App(), (manager) async {
            await preloadWeights(manager);
            base.sendEvent(EVENT_WEIGHT, fetchWeightUnits());
          }));

  new task.ScheduleManager().register('currency', new task.Schedule());
  schedCurrencyUpdate();
  base.dbWrap<void, App>(
      new App(),
      (manager) => Future.wait([
            preloadCurrencies(manager),
            preloadUnits(manager),
            preloadWeights(manager),
            preloadTaxes(manager),
            preloadLanguages(manager),
            preloadPayments(manager),
            preloadLabUnits(manager),
          ]));

  new auth.PermissionManager()
    // Crud for All
    ..register(Group.Local, Scope.Country, auth.PA.crud, false)
    ..register(Group.Local, Scope.Currency, auth.PA.crud, false)
    ..register(Group.Local, Scope.Quantity, auth.PA.crud, false)
    ..register(Group.Local, Scope.Language, auth.PA.crud, false)
    ..register(Group.Local, Scope.Payment, auth.PA.crud, false)
    ..register(Group.Local, Scope.Tax, auth.PA.crud, false)
    ..register(Group.Local, Scope.Weight, auth.PA.crud, false)
    ..register(Group.Local, Scope.Zone, auth.PA.crud, false)
    ..register(Group.Local, Scope.Dictionary, auth.PA.crud, false)
    ..register(Group.Local, Scope.Address, auth.PA.crud, false)
    ..register(Group.Local, Scope.Rhif, auth.PA.crud, false)
    ..register(Group.Local, Scope.Region, auth.PA.crud, false)
    ..register(Group.Local, Scope.Place, auth.PA.crud, false)
    ..register(Group.Local, Scope.LabUnit, auth.PA.crud, false)
    // Read for All
    ..register(Group.Local, Scope.Country, [auth.PA.read], true)
    ..register(Group.Local, Scope.Currency, [auth.PA.read], true)
    ..register(Group.Local, Scope.Quantity, [auth.PA.read], true)
    ..register(Group.Local, Scope.Language, [auth.PA.read], true)
    ..register(Group.Local, Scope.Payment, [auth.PA.read], true)
    ..register(Group.Local, Scope.Tax, [auth.PA.read], true)
    ..register(Group.Local, Scope.Weight, [auth.PA.read], true)
    ..register(Group.Local, Scope.Zone, [auth.PA.read], true)
    ..register(Group.Local, Scope.Dictionary, [auth.PA.read], true)
    ..register(Group.Local, Scope.Address, [auth.PA.read], true)
    ..register(Group.Local, Scope.Rhif, [auth.PA.read], true)
    ..register(Group.Local, Scope.Region, [auth.PA.read], true)
    ..register(Group.Local, Scope.Place, [auth.PA.read], true)
    ..register(Group.Local, Scope.LabUnit, [auth.PA.read], true);
}
