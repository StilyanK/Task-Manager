part of local.gui;

class SelectRegionCode extends cl_form.Select {
  SelectRegionCode(cl_app.Application ap, [first]) : super() {
    execute = () => ap
            .serverCall<List>(
                RoutesRegion.collectionPairCode.reverse([]), null, this)
            .then((data) {
          if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
          return data;
        });
  }
}
