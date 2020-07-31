part of hms_local.shared;

class CurrencyService {
  static const String pattern = '###,###,###,###,##0.00#####';

  static CurrencyService instance;

  int _currency_base;

  CurrencyDataCollection _cdc;
  final Map<int, CurrencyData> _currency = {};

  factory CurrencyService([CurrencyDataCollection cdc, int currency_base = 1]) {
    if (instance == null || cdc != null)
      instance = new CurrencyService._(cdc, currency_base);
    return instance;
  }

  CurrencyService._(this._cdc, currency_base) {
    _cdc ??= new CurrencyDataCollection()
      ..add(new CurrencyData()
        ..currency_id = currency_base
        ..rate = 1
        ..currency = (new Currency()
          ..title = 'BGN'
          ..symbol_position = 0
          ..currency_id = currency_base
          ..symbol = 'лв'));
    _currency_base = currency_base;
    _setCurrency();
  }

  DateTime getDate(int currency_id) =>
      _currency[currency_id].currency_history.date;

  num getRate(int currency_id) => _currency[currency_id].rate;

  CurrencyData getCurrencyBase() => _currency[_currency_base];

  int getCurrencyBaseId() => _currency_base;

  dynamic getCurrency([int currency_id]) =>
      (currency_id != null) ? _currency[currency_id] : _cdc;

  CurrencyDataCollection getCollection() => _cdc;

  num _conversion(int currency_id_from, int currency_id_to) =>
      _currency[currency_id_to].rate / _currency[currency_id_from].rate;

  num convert(num price, int currency_id_from,
      {int currency_id_to, int round = 2}) {
    currency_id_to ??= _currency_base;
    final conv = _conversion(currency_id_from, currency_id_to);
    return roundPrice(price * conv, round: round);
  }

  num roundPrice(num price, {int round = 2}) =>
      num.parse(price.toStringAsFixed(round));

  String formatPrice(num price, {int round = 2}) {
    final rounded =
        price.toStringAsFixed(round).replaceAll(new RegExp(r'0+$'), '');
    return new NumberFormat(pattern, 'en_US').format(num.parse(rounded));
  }

  dynamic setPrice(num price,
      {bool format = false,
      bool symbol = false,
      int currency_id,
      int round = 2}) {
    final pr = format
        ? formatPrice(price, round: round)
        : roundPrice(price, round: round);
    return symbol ? addSymbol(pr.toString(), currency_id) : pr;
  }

  String addSymbol(String price, int currency_id, [String space = ' ']) {
    currency_id = (currency_id != null) ? currency_id : _currency_base;
    final symbol = _currency[currency_id].currency.symbol;
    if (_currency[currency_id].currency.symbol_position == 0)
      return '$price$space$symbol';
    else
      return '$symbol$space$price';
  }

  String getCurrencyById(int currency_id) {
    if (_currency[currency_id] != null)
      return _currency[currency_id].currency.title;
    return null;
  }

  int getCurrencyIdByName(String title) {
    var id = 0;
    _currency.forEach((i, cd) {
      if (cd.currency.title == title) id = cd.currency_id;
    });
    return id;
  }

  void _setCurrency() {
    _cdc.forEach((cd) => _currency[cd.currency_id] = cd);
  }
}
