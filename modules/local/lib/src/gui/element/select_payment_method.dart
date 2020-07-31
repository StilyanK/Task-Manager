part of local.gui;

class SelectPaymentMethod extends cl_form.Select {
  SelectPaymentMethod([List first]) : super() {
    final q = new shared.PaymentMethodService();
    if (first is List) addOption(first.first, first.last);
    q.getCollection().forEach((p) => addOption(
        p.payment_method_id,
        p.getTitle(
            new shared.LanguageService().getLanguageId(Intl.defaultLocale))));
  }
}
