part of local.api;

@DTOSerializable()
class CurrencyDTO {
  String currency_symbol;
  int currency_position;
  String currency_code;

  CurrencyDTO();

  factory CurrencyDTO.fromMap(Map data) => _$CurrencyDTOFromMap(data);

  CurrencyDTO.fromCurrency(Currency c) {
    currency_symbol = c.symbol;
    currency_position = c.symbol_position;
    currency_code = c.title;
  }

  Map toMap() => _$CurrencyDTOToMap(this);
}
