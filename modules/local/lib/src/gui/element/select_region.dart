part of hms_local.gui;

class SelectRegion extends cl_form.Select {
  SelectRegion(cl_app.Application ap, [first]) : super() {
    execute = () => ap
            .serverCall<List>(
                RoutesRegion.collectionPairCode.reverse([]), null, this)
            .then((data) {
          if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
          return data;
        });
  }
}
