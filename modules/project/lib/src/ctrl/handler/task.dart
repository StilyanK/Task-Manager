part of project.ctrl;

class ICommission extends base.Item<App, Commission, int> {
  final String group = Group.Document;
  final String scope = Scope.Commission;

  ICommission(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final cdata = await manager.app.commission.find(id);
    final ret = cdata.toJson();
    final dl = await manager.app.doctor.findByCommission(id);
    ret[e.Commission.$doctors] = dl.map((el) => el.doctor_id).toList();
    return ret;
  }

  Future<void> getDoctors() =>
      run(group, scope, base.$RunRights.read, () async {
        final data = await getData();
        final id = data[base.$BaseConsts.id];
        manager = await Database().init(App());
        final dl = await manager.app.doctor.findByCommission(id);
        final idl = dl.map((el) => el.doctor_id).toList();
        return response(idl);
      });

  Future<int> doSave(int id, Map data) async {
    final doctors = data.remove(e.Commission.$doctors) ?? [];
    final cdata = await manager.app.commission.prepare(id, data);

    ///Assign doctors to commission
    for (final el in doctors) {
      final doc = await manager.app.doctor.find(el);
      doc.com_id = id;
      manager.addDirty(doc);
    }

    await manager.commit();
    return cdata.com_id;
  }

  Future<bool> doDelete(int id) => manager.app.commission.deleteById(id);
}
