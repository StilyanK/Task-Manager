part of local.entity;

@MSerializable()
class Currency {
  int currency_id;

  String title;

  String symbol;

  int symbol_position;

  bool active;

  Currency();

  void init(Map data) => _$CurrencyFromMap(this, data);

  Map<String, dynamic> toMap() => _$CurrencyToMap(this);

  Map<String, dynamic> toJson() => _$CurrencyToMap(this, true);
}

class CurrencyCollection<E extends Currency> extends Collection<E> {}
