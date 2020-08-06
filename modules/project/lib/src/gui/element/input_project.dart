part of project.gui;

class InputProject extends cl_form.InputLoader {

  InputProject(ap) : super() {
    execute = () async {
      final sug = getSuggestion();
      Map<String, dynamic> param;
      if (sug.isNotEmpty) {
        param = {'suggestion': sug};
      } else {
        param = {'id': getValue()};
      }
      return (await ap.serverCall<List>(
          RoutesProject.collectionSuggest.reverse([]), param, this))
          .cast<Map>();
    };
    domAction.addAction((e) => new ProjectListChoose(
            (o) => setValue(o[entity.$Project.project_id]),
        ap));
  }
}
