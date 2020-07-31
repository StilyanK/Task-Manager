part of local.shared;

class ProcedureGroup extends Total {
  String group;

  ProcedureGroup(this.group, [TaxContract tax_contract, TaxService taxService])
      : super(tax_contract, taxService);

  Map toMap() =>
      {'group': group, 'tax_contract': tax_contract, 'collection': collection};
}

class TotalProcedure {
  List<ProcedureGroup> groups = [];

  TotalProcedure();

  void add(String group,
      {Price amount,
      num quantity,
      Mod discount,
      int taxProductId,
      TaxContract taxContract,
      TaxService taxService}) {
    var grp = groups.firstWhere((pg) => pg.group == group, orElse: () => null);
    if (grp == null) {
      grp = new ProcedureGroup(group, taxContract, taxService);
      groups.add(grp);
    }
    grp.add(
        amount: amount,
        quantity: quantity,
        discount: discount,
        taxProductId: taxProductId);
  }

  void mergeGroups(List<ProcedureGroup> grps) {
    grps.forEach((pg) {
      var grp =
          groups.firstWhere((p) => p.group == pg.group, orElse: () => null);
      if (grp == null) {
        grp = new ProcedureGroup(pg.group, pg.tax_contract, pg.ts);
        groups.add(grp);
      }
      pg.collection.forEach((k) => grp.collection.add(k));
    });
  }

  PriceCollection getTotal([String group]) {
    if (group != null) {
      final grp =
          groups.firstWhere((grp) => grp.group == group, orElse: () => null);
      return grp?.getTotal();
    }
    var total = new PriceCollection();
    groups.forEach((grp) => total += grp.getTotal());
    return total;
  }

  PriceCollection getSubTotal([String group]) {
    if (group != null) {
      final grp =
          groups.firstWhere((grp) => grp.group == group, orElse: () => null);
      return grp?.getSubTotal();
    }
    var subtotal = new PriceCollection();
    groups.forEach((grp) => subtotal += grp.getSubTotal());
    return subtotal;
  }

  PriceCollection getDiscount([String group]) {
    if (group != null) {
      final grp =
          groups.firstWhere((grp) => grp.group == group, orElse: () => null);
      return grp?.getDiscount();
    }
    var discount = new PriceCollection();
    groups.forEach((grp) => discount += grp.getDiscount());
    return discount;
  }

  List<Map> toJson() => groups.map((grp) => grp.toJson()).toList();
}
