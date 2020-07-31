part of hms_local.gui;

class SelectCountry extends cl_form.Select {
  SelectCountry(cl_app.Application ap, [first]) : super() {
    execute = () => ap
            .serverCall(RoutesCountry.collectionPair.reverse([]), null, this)
            .then((data) {
          if (first != null) data.insert(0, {'k': first[0], 'v': first[1]});
          return data;
        });
  }

  dynamic getCountryISO2() {
    final row =
        list.firstWhere((e) => e['k'] == getValue(), orElse: () => null);
    return (row != null) ? row['iso2'] : null;
  }
}
