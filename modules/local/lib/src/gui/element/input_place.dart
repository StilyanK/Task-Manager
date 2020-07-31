part of hms_local.gui;

class InputPlace extends cl_form.InputLoader {
  InputPlace(ap) : super() {
    execute = () async {
      final s = getSuggestion();
      if (s.isEmpty) {
        return (await ap.serverCall(RoutesPlace.collectionSuggest.reverse([]),
                {'id': getValue()}, this))
            .cast<Map>();
      } else {
        final param = <String, dynamic>{'suggestion': s};
        if (dependencies.isNotEmpty) {
          final dep = dependencies.first.getValue();
          param[entity.$Place.region_code] = dep;
          if (getValue() != null) param['id'] = getValue();
        }
        return (await ap.serverCall(
                RoutesPlace.collectionSuggest.reverse([]), param, this))
            .cast<Map>();
      }
    };
    domAction.addAction((e) => new PlaceListChoose(
        (o) =>
            setValue([o[entity.$Place.place_id], '${o[entity.$Place.name]}']),
        ap)
      ..filterRegion.setValue(
          dependencies.isNotEmpty ? dependencies.first?.getValue() : null)
      ..getData());
  }
}
