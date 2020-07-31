part of hms_local.shared;

class PaymentMethodService {
  static const String inCash = 'in_cash';
  static const String bankTransfer = 'bank_transfer';
  static const String debitCard = 'debit_card';
  static const String creditCard = 'credit_card';

  static PaymentMethodService instance;

  PaymentMethodCollection _pc;

  factory PaymentMethodService([PaymentMethodCollection pc]) {
    if (instance == null || pc != null)
      instance = new PaymentMethodService._(pc);
    return instance;
  }

  PaymentMethodService._(pc) {
    _pc = pc;
  }

  PaymentMethodCollection getCollection() => _pc;

  List<Map<String, dynamic>> pair() => _pc.pair();

  int getPaymentMethodIdByName(String name) {
    final pm = _pc.firstWhere((d) => d.name == name, orElse: () => null);
    return pm?.payment_method_id;
  }

  String getPaymentMethodNameById(int id) {
    final pm =
        _pc.firstWhere((d) => d.payment_method_id == id, orElse: () => null);
    return pm?.name;
  }

  String get(int payment_id, [dynamic localeOrLanguageId]) {
    final language_id = (localeOrLanguageId is String)
        ? new LanguageService().getLanguageId(localeOrLanguageId)
        : localeOrLanguageId;
    final pm = _pc.firstWhere((d) => d.payment_method_id == payment_id,
        orElse: () => null);
    return pm != null ? pm.getTitle(language_id) : '';
  }
}
