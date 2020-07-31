part of local.gui;

class SelectCountryCodes extends cl_form.Select {
  SelectCountryCodes(cl_app.Application ap, [first]) : super() {
    execute = () => ap
            .serverCall<List>(
                RoutesCountry.collectionPair.reverse([]), null, this)
            .then((data) {
          if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
          return data;
        });
  }
}
