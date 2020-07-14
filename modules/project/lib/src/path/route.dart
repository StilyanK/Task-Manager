part of project.path;

const $module = '/protocol_doc';

class RoutesDoctor {
  static const String $base = '${$module}/doctor';

  static UrlPattern get itemGet => UrlPattern('${$base}/item/get');

  static UrlPattern get itemSave => UrlPattern('${$base}/item/save');

  static UrlPattern get itemDelete => UrlPattern('${$base}/item/delete');

  static UrlPattern get collectionSuggest =>
      UrlPattern('${$base}/collection/suggest');

  static UrlPattern get collectionGet => UrlPattern('${$base}/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('${$base}/collection/delete');

  static UrlPattern get findByUser =>
      UrlPattern('${$base}/item/get/find_by_user');

  static const String onCreate = '${Group.Document}:${Scope.Doctor}:create';
  static const String onUpdate = '${Group.Document}:${Scope.Doctor}:update';
  static const String onDelete = '${Group.Document}:${Scope.Doctor}:delete';
}

class RoutesPatient {
  static const String $base = '${$module}/patient';

  static UrlPattern get itemGet => UrlPattern('${$base}/item/get');

  static UrlPattern get itemSave => UrlPattern('${$base}/item/save');

  static UrlPattern get itemDelete => UrlPattern('${$base}/item/delete');

  static UrlPattern get collectionSuggest =>
      UrlPattern('${$base}/collection/suggest');

  static UrlPattern get collectionGet => UrlPattern('${$base}/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('${$base}/collection/delete');

  static UrlPattern get findByUser => UrlPattern('${$base}/item/find_by_user');

  static const String onCreate = '${Group.Document}:${Scope.Patient}:create';
  static const String onUpdate = '${Group.Document}:${Scope.Patient}:update';
  static const String onDelete = '${Group.Document}:${Scope.Patient}:delete';
}

class RoutesPatientRecord {
  static const String $base = '${$module}/patient_record';

  static UrlPattern get itemGet => UrlPattern('${$base}/item/get');

  static UrlPattern get itemSave => UrlPattern('${$base}/item/save');

  static UrlPattern get itemDelete => UrlPattern('${$base}/item/delete');

  static UrlPattern get collectionSuggest =>
      UrlPattern('${$base}/collection/suggest');

  static UrlPattern get collectionGet => UrlPattern('${$base}/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('${$base}/collection/delete');

  static UrlPattern get sendApproval =>
      UrlPattern('${$base}/item/send_approval');

  static const String onCreate =
      '${Group.Document}:${Scope.PatientRecord}:create';
  static const String onUpdate =
      '${Group.Document}:${Scope.PatientRecord}:update';
  static const String onDelete =
      '${Group.Document}:${Scope.PatientRecord}:delete';
}

class RoutesCommission {
  static const String $base = '${$module}/commission';

  static UrlPattern get itemGet => UrlPattern('${$base}/item/get');

  static UrlPattern get itemSave => UrlPattern('${$base}/item/save');

  static UrlPattern get itemDelete => UrlPattern('${$base}/item/delete');

  static UrlPattern get collectionSuggest =>
      UrlPattern('${$base}/collection/suggest');

  static UrlPattern get collectionGet => UrlPattern('${$base}/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('${$base}/collection/delete');

  static UrlPattern get getDoctors =>
      UrlPattern('${$base}/item/get_doctors');

  static const String onCreate = '${Group.Document}:${Scope.Doctor}:create';
  static const String onUpdate = '${Group.Document}:${Scope.Doctor}:update';
  static const String onDelete = '${Group.Document}:${Scope.Doctor}:delete';
}

class RoutesDisease {
  static const String $base = '${$module}/disease';

  static UrlPattern get itemGet => UrlPattern('${$base}/item/get');

  static UrlPattern get itemSave => UrlPattern('${$base}/item/save');

  static UrlPattern get itemDelete => UrlPattern('${$base}/item/delete');

  static UrlPattern get collectionSuggest =>
      UrlPattern('${$base}/collection/suggest');

  static UrlPattern get collectionGet => UrlPattern('${$base}/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('${$base}/collection/delete');

  static const String onCreate = '${Group.Document}:${Scope.Doctor}:create';
  static const String onUpdate = '${Group.Document}:${Scope.Doctor}:update';
  static const String onDelete = '${Group.Document}:${Scope.Doctor}:delete';
}

abstract class RoutesDocComment {
  static const String $base = '${$module}/doc_comment';

  static UrlPattern get collectionGet => UrlPattern('${$base}/collection/get');

  static UrlPattern get collectionSave =>
      UrlPattern('${$base}/collection/save');
}

class RoutesMotivation {
  static const String $base = '${$module}/motivation';

  static UrlPattern get itemGet => UrlPattern('${$base}/item/get');

  static UrlPattern get itemSave => UrlPattern('${$base}/item/save');

  static UrlPattern get getUser => UrlPattern('${$base}/item/get_user');
}
