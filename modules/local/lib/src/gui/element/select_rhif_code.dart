part of hms_local.gui;

class SelectRhifCode extends cl_form.Select {
  SelectRhifCode(cl_app.Application ap, [first]) : super() {
    execute = () {
      final v = dependencies.first.getValue();
      return ap
          .serverCall<List>(RoutesRhif.collectionPairCode.reverse([]),
              {entity.$Place.region_code: v}, this)
          .then((data) {
        if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
        return data;
      });
    };
  }
}
