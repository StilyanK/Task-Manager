part of auth.gui;

class SelectGroup extends cl_form.Select {
  SelectGroup(cl_app.Application ap, [first]) : super() {
    execute = () => ap
            .serverCall<List>(RoutesG.collectionPair.reverse([]), null, this)
            .then((data) {
          if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
          return data;
        });
  }
}
