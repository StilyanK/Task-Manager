part of auth.gui;

class InputUser extends cl_form.InputLoader {
  InputUser(cl_app.Application ap) : super() {
    execute = () async {
      final sug = getSuggestion();
      Map<String, dynamic> param;
      if (sug.isNotEmpty) {
        param = {'suggestion': sug};
      } else {
        param = {'id': getValue()};
      }
      return (await ap.serverCall<List>(
              RoutesU.collectionSuggest.reverse([]), param, this))
          .cast<Map>();
    };
    domAction.addAction(
        (e) => UserListChoose((o) => setValue(o[$User.user_id]), ap));
  }
}
