part of local.mapper;

class PaymentMethodMapper
    extends Mapper<PaymentMethod, PaymentMethodCollection, App> {
  String table = 'payment_method';

  PaymentMethodMapper(m) : super(m);

  Future<PaymentMethod> findByName(String name) => loadE(selectBuilder()
    ..where('name = @n')
    ..setParameter('n', name));

  CollectionBuilder<PaymentMethod, PaymentMethodCollection, App>
      findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['payment_method_id']
        ..llike = ['unit']);
    return cb;
  }
}

class PaymentMethod extends entity.PaymentMethod with Entity<App> {}

class PaymentMethodCollection
    extends entity.PaymentMethodCollection<PaymentMethod> {}
