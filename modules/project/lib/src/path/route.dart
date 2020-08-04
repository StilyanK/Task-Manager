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

  static UrlPattern get cardInfo => UrlPattern('task/card/info');

  static UrlPattern get collectionPair =>
      new UrlPattern(r'/task/collection/pair');

  static const String onCreate = '${Group.Document}:${Scope.Doctor}:create';
  static const String onUpdate = '${Group.Document}:${Scope.Doctor}:update';
  static const String onDelete = '${Group.Document}:${Scope.Doctor}:delete';
}
