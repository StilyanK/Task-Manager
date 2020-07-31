part of local.entity;

@MSerializable()
class CurrencyHistory {
  int currency_history_id;

  DateTime date;

  CurrencyHistory();

  void init(Map data) => _$CurrencyHistoryFromMap(this, data);

  Map<String, dynamic> toMap() => _$CurrencyHistoryToMap(this);

  Map<String, dynamic> toJson() => _$CurrencyHistoryToMap(this, true);
}

class CurrencyHistoryCollection<E extends CurrencyHistory>
    extends Collection<E> {}
