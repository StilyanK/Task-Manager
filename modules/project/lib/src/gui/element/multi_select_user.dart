part of project.gui;

class MultiSelectUser extends cl_form.SelectMulti {
  MultiSelectUser(cl_app.Application ap) : super() {
    addClass('xl');
    execute = () async {
      final params = {};
      final data = await ap.serverCall(
          RoutesTask.collectionPair.reverse([]), params, this);
      return data;
    };
  }
}
