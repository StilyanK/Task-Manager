part of auth.gui;

class SelectUser extends cl_form.Select {
  SelectUser(cl_app.Application ap, [first]) : super() {
    execute = () => ap
            .serverCall<List>(RoutesU.collectionPair.reverse([]), null)
            .then((data) {
          data ??= [];
          if (first != null)
            data.cast<Map>().insert(0, {'k': first[0], 'v': first[1]});
          return data.cast<Map>();
        });
  }
}
