part of hms_local.shared;

class Amount extends Object {
  final int round;
  final num _amount;

  Amount(this._amount, {this.round = 3});

  num get amount => _round(_amount);

  Amount operator +(Object obj) {
    final Amount a = obj is! Amount ? new Amount(obj) : obj;
    return new Amount(_amount + a._amount, round: round);
  }

  Amount operator -(Object obj) {
    final Amount a = obj is! Amount ? new Amount(obj) : obj;
    return new Amount(_amount - a._amount, round: round);
  }

  Amount operator *(Object obj) {
    final Amount a = obj is! Amount ? new Amount(obj) : obj;
    return new Amount(_amount * a._amount, round: round);
  }

  Amount operator /(Object obj) {
    final Amount a = obj is! Amount ? new Amount(obj) : obj;
    return new Amount(_amount / a._amount, round: round);
  }

  bool operator >(Amount a) => amount > a.amount;

  bool operator <(Amount a) => amount < a.amount;

  bool operator ==(dynamic other) => other is Amount && other.amount == amount;

  int get hashCode => super.hashCode ^ amount;

  num _round(num amount) => num.parse(amount.toStringAsFixed(round));

  String toString() => new NumberFormat('###########.#########').format(amount);

  num toJson() => amount;
}
