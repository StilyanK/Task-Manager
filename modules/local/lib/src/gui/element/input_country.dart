part of hms_local.gui;

class InputCountry extends cl_form.InputLoader {
  InputCountry(ap) : super() {
    execute = () async {
      final s = getSuggestion();
      final params = s.isEmpty ? {'id': getValue()} : {'suggestion': s};
      return (await ap.serverCall(
              RoutesCountry.collectionSuggest.reverse([]), params, this))
          .cast<Map>();
    };

    domAction.addAction((e) => new CountryListChoose(
        (obj) => setValue(obj[entity.$Address.country_id]), ap));
  }
}
