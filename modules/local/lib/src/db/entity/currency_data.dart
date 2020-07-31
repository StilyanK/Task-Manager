part of hms_local.entity;

@MSerializable()
class CurrencyData {
  int currency_id;

  int currency_history_id;

  num rate;

  Currency currency;

  CurrencyHistory currency_history;

  CurrencyData();

  void init(Map data) => _$CurrencyDataFromMap(this, data);

  Map<String, dynamic> toMap() => _$CurrencyDataToMap(this);

  Map<String, dynamic> toJson() => _$CurrencyDataToMap(this, true);

  Future<CurrencyHistory> loadHistory() async => null;

  Future<Currency> loadCurrency() async => null;
}

class CurrencyDataCollection<E extends CurrencyData> extends Collection<E> {
  CurrencyDataCollection();

  factory CurrencyDataCollection.fromJson(List data) {
    final col = new CurrencyDataCollection();
    data.forEach((d) {
      col.add(new CurrencyData()
        ..init(d)
        ..currency = (new Currency()..init(d['currency']))
        ..currency_history =
            (new CurrencyHistory()..init(d['currency_history'])));
    });
    return col;
  }

  List<Map> toJson() {
    final List<Map> list = [];
    forEach((d) {
      final m = d.toJson();
      m['currency'] = d.currency.toJson();
      m['currency_history'] = d.currency_history.toJson();
      list.add(m);
    });
    return list;
  }
}
