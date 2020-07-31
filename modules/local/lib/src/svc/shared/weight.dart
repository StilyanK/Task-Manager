part of local.shared;

class Weight {
  WeightService _ws;

  num weight;

  int weight_unit_id;

  Weight([WeightService ws]) {
    _ws = ws ?? new WeightService();
  }

  Weight.fromMap(Map data, [WeightService ws]) {
    _ws = ws ?? new WeightService();
    weight = data['weight'];
    weight_unit_id = data['weight_unit_id'];
  }

  Weight operator +(Weight wght) => new Weight(_ws)
    ..weight = weight + wght.weight
    ..weight_unit_id = weight_unit_id;

  Weight operator -(Weight wght) => new Weight(_ws)
    ..weight = weight - wght.weight
    ..weight_unit_id = weight_unit_id;

  Weight operator *(num multiplier) => new Weight(_ws)
    ..weight = weight * multiplier
    ..weight_unit_id = weight_unit_id;

  Weight operator /(num delimiter) => new Weight(_ws)
    ..weight = weight / delimiter
    ..weight_unit_id = weight_unit_id;

  Weight convert(int weight_unit_id) => new Weight(_ws)
    ..weight = weight
    ..weight_unit_id = weight_unit_id;

  Weight clone() => new Weight(_ws)
    ..weight = weight
    ..weight_unit_id = weight_unit_id;

  bool isIdentical(Weight w) => weight_unit_id == w.weight_unit_id;

  String toStringSymboled([String locale]) => _ws.get(
      weight,
      weight_unit_id,
      new LanguageService()
          .getLanguageId(locale == null ? Intl.defaultLocale : locale));

  Map toMap() => {'weight': weight, 'weight_unit_id': weight_unit_id};

  Map toJson() => toMap();

  String toString() => toStringSymboled();
}

class WeightCollection extends ListQueue<Weight> {
  WeightCollection();

  WeightCollection.fromList(List data, [WeightService ws]) {
    data.forEach((r) => add(new Weight.fromMap(r, ws)));
  }

  void add(Weight value) {
    final identical =
        firstWhere((w) => w.isIdentical(value), orElse: () => null);
    if (identical != null)
      identical.weight = (identical + value).weight;
    else
      super.add(value.clone());
  }

  void subtract(Weight value) {
    final identical =
        firstWhere((w) => w.isIdentical(value), orElse: () => null);
    if (identical != null)
      identical.weight = (identical - value).weight;
    else
      super.add(value.clone()..weight *= -1);
  }

  WeightCollection clone() {
    final wc = new WeightCollection();
    forEach(wc.add);
    return wc;
  }

  List<Weight> getWeight() {
    final l = <Weight>[];
    forEach((w) {
      final ex =
          l.firstWhere((weight) => weight.isIdentical(w), orElse: () => null);
      if (ex != null)
        ex.weight = (ex + w).weight;
      else
        l.add(w.clone());
    });
    return l;
  }

  Iterable toListSymboled([String locale]) =>
      getWeight().map((w) => w.toStringSymboled(locale));

  List<Map> toMap() => getWeight().map<Map>((w) => w.toMap()).toList();

  List<Map> toJson() => toMap();
}

class WeightForm {
  WeightCollection col;

  WeightForm(this.col);

  String toHtml([String locale]) =>
      '<table class="total"><tr><td>${col.toListSymboled(locale).join('</td></tr></tr><td>')}</td></tr></table>';
}
