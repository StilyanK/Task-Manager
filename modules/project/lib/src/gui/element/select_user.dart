part of project.gui;

class SelectUser extends cl_form.Select {
  SelectUser(cl_app.Application ap, [first]) {
    execute = () async {
      final params = {};
      final data = await ap.serverCall(
          RoutesTask.collectionPair.reverse([]), params, this);
      if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
      return data;
    };
  }
}