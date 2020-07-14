part of project.ctrl;

class CCommission extends base.Collection<App, Commission, int> {
  final String group = Group.Document;
  final String scope = Scope.Commission;

  CCommission(req) : super(req, new App());

  Future<CollectionBuilder> doGet(Map filter, Map order, Map paginator) =>
      (manager.app.commission.findAllByBuilder()
            ..filter = filter
            ..order(order[base.$BaseConsts.field], order[base.$BaseConsts.way])
            ..page = paginator[base.$BaseConsts.page]
            ..limit = paginator[base.$BaseConsts.limit])
          .process(true);

  Future<bool> doDelete(List ids) =>
      Future.wait(ids.map(manager.app.commission.deleteById)).then((_) => true);

  Future<void> suggest() => run(group, scope, base.$RunRights.read, () async {
        final params = await getData();
        manager = await Database().init(App());
        CommissionCollection col;
        if (params[base.$BaseConsts.id] != null) {
          col = CommissionCollection()
            ..add(
                await manager.app.commission.find(params[base.$BaseConsts.id]));
        } else {
          col = await manager.app.commission
              .findBySuggestion(params[base.$BaseConsts.suggestion]);
        }
        return response(col.pair());
      });

  Future<Map> lister(Commission o) async {
    final m = o.toJson();
    if (o.disease_id != null) {
      final dis = await manager.app.disease.find(o.disease_id);
      m[e.Commission.$disease] = dis?.name;
    }
    return m;
  }
}
