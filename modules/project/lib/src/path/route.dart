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

  static const String eventCreate = '${Group.Project}:${Scope.Task}:create';
  static const String eventUpdate = '${Group.Project}:${Scope.Task}:update';
  static const String eventDelete = '${Group.Project}:${Scope.Task}:delete';
}

class RoutesProject {
  static UrlPattern get itemGet => UrlPattern('project/item/get');

  static UrlPattern get itemSave => UrlPattern('project/item/save');

  static UrlPattern get itemDelete => UrlPattern('project/item/delete');

  static UrlPattern get collectionGet => UrlPattern('project/collection/get');

  static UrlPattern get collectionDelete =>
      UrlPattern('project/collection/delete');

  static UrlPattern get collectionSuggest =>
      UrlPattern('project/collection/suggest');

  static const String eventCreate = '${Group.Project}:${Scope.Project}:create';
  static const String eventUpdate = '${Group.Project}:${Scope.Project}:update';
  static const String eventDelete = '${Group.Project}:${Scope.Project}:delete';
}

class RoutesGadget {
  static UrlPattern get cardInfo => UrlPattern('task/card/info');

  static UrlPattern get updateCard => UrlPattern('task/card/update');
}
