part of project.path;

class RoutesTask {
  static UrlPattern get itemGet => UrlPattern('task/item/get');

  static UrlPattern get itemSave => UrlPattern('task/item/save');

  static UrlPattern get itemDelete => UrlPattern('task/item/delete');

  static UrlPattern get collectionSuggest =>
      UrlPattern('task/collection/suggest');

  static UrlPattern get collectionGet => UrlPattern('task/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('task/collection/delete');

  static UrlPattern get collectionPair =>
      new UrlPattern(r'/task/collection/pair');

  static const String eventCreate = '${Group.Document}:${Scope.Doctor}:create';
  static const String eventUpdate = '${Group.Document}:${Scope.Doctor}:update';
  static const String eventDelete = '${Group.Document}:${Scope.Doctor}:delete';
}

class RoutesGadget {
  static UrlPattern get cardInfo => UrlPattern('task/card/info');

  static UrlPattern get updateCard => UrlPattern('task/card/update');
}

class RoutesProject {
  static UrlPattern get itemGet => UrlPattern('project/item/get');

  static UrlPattern get itemSave => UrlPattern('project/item/save');

  static UrlPattern get itemDelete => UrlPattern('project/item/delete');

  static UrlPattern get collectionGet => UrlPattern('project/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('project/collection/delete');
}
