part of project.gui;


class MultiSelectUser extends cl_form.SelectMulti {

  MultiSelectUser(cl_app.Application ap,[first]) : super() {
    execute = () async {
      final params = {};
      final data = await ap.serverCall(
          RoutesTask.collectionPair.reverse([]), params, this);
      if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
      return data;
    };
  }
}