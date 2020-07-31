part of local.gui;

class SelectZones extends cl_form.Select {
  SelectZones(cl_app.Application ap, [first]) : super() {
    execute = () {
      final v = dependencies.first.getValue();
      return ap
          .serverCall<List>(
              RoutesZone.collectionPair.reverse([]), {'param': v}, this)
          .then((data) {
        if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
        return data;
      });
    };
  }
}
