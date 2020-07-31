part of local.ctrl;

class CLabUnit extends base.Collection<App, LaboratoryUnit, int> {
  final String group = Group.Local;
  final String scope = Scope.LabUnit;

  CLabUnit(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) {
    final cb = manager.app.laboratoryUnit.findAllByBuilder()
      ..filter = filter
      ..order(order['field'], order['way'])
      ..page = paginator['page']
      ..limit = paginator['limit'];
    return cb.process(true);
  }

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.laboratoryUnit.deleteById))
          .then((_) => true);

  Future pair() => run(group, scope, 'read', () async {
        manager = await new Database().init(new App());
        final c = await manager.app.laboratoryUnit.findAll();
        return response(c.pair());
      });
}
