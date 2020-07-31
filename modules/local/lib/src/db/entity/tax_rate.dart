part of hms_local.entity;

@MSerializable()
class TaxRate {
  int tax_rate_id;

  String name;

  Map intl;

  double rate;

  int country_id;

  int country_zone_id;

  TaxRate();

  void init(Map data) => _$TaxRateFromMap(this, data);

  Map<String, dynamic> toMap() => _$TaxRateToMap(this);

  Map<String, dynamic> toJson() => _$TaxRateToMap(this, true);

  dynamic getName([int language_id]) {
    if (language_id == null) return name;
    final key = language_id.toString();
    return intl.containsKey(key) ? intl[key] : intl.values.first;
  }

  String toFormattedString([int language_id]) =>
      '${getName(language_id)} ($rate%)';
}

class TaxRateCollection<E extends TaxRate> extends Collection<E> {
  Iterable<Map<String, String>> toJson() => map((t) => t.toJson());

  void fromList(List data) {
    data.forEach((r) => add(new TaxRate()..init(r)));
  }

  List<String> toFString() => map((e) => e.name).toList();
}
