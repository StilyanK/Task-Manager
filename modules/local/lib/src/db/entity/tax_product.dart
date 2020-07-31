part of hms_local.entity;

@MSerializable()
class TaxProduct {
  int tax_product_id;

  String name;

  TaxProduct();

  void init(Map data) => _$TaxProductFromMap(this, data);

  Map<String, dynamic> toMap() => _$TaxProductToMap(this);

  Map<String, dynamic> toJson() => _$TaxProductToMap(this, true);
}

class TaxProductCollection<E extends TaxProduct> extends Collection<E> {
  Iterable<Map<String, String>> toJson() => map((t) => t.toJson());

  void fromList(List data) {
    data.forEach((r) => add(new TaxProduct()..init(r)));
  }

  List<String> toFString() => map((e) => e.name).toList();
}
