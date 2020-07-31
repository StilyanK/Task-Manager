part of local.entity;

@MSerializable()
class PaymentMethod {
  int payment_method_id;

  String name;

  Map intl;

  Map settings;

  int active;

  PaymentMethod();

  void init(Map data) => _$PaymentMethodFromMap(this, data);

  Map<String, dynamic> toMap() => _$PaymentMethodToMap(this);

  Map<String, dynamic> toJson() => _$PaymentMethodToMap(this, true);

  String getTitle([int language_id]) {
    if (language_id == null) return name;
    final key = language_id.toString();
    return intl.containsKey(key)
        ? intl[key] as String
        : intl.values.first as String;
  }
}

class PaymentMethodCollection<E extends PaymentMethod> extends Collection<E> {
  List<Map<String, dynamic>> pair([int language_id]) => map((paymentm) => {
        'k': paymentm.payment_method_id,
        'v': paymentm.getTitle(language_id)
      }).toList();
}
