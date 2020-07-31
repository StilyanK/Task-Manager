part of local.entity;

@MSerializable()
class TaxClient {
  int tax_client_id;

  String name;

  TaxClient();

  void init(Map data) => _$TaxClientFromMap(this, data);

  Map<String, dynamic> toMap() => _$TaxClientToMap(this);

  Map<String, dynamic> toJson() => _$TaxClientToMap(this, true);
}

class TaxClientCollection<E extends TaxClient> extends Collection<E> {
  Iterable<Map<String, String>> toJson() => map((t) => t.toJson());

  void fromList(List data) {
    data.forEach((r) => add(new TaxClient()..init(r)));
  }

  List<String> toFString() => map((e) => e.name).toList();
}
