part of local.shared;

//TODO Добавяне на -ма, -има, (седмина, осмина ?) за човешки същества

/// Gender (Род)
///
///     0 - Мъжки Род
///     1 - Женски Род
///     2 - Среден Род
String encodeInteger(int number, {int gender = 0}) {
  if (number == 0) return WordConst.zero;

  final list = <String>[];
  for (final t in thresholds) number = encodeThreshold(t, list, number, gender);
  encodeThousands(list, number, gender);
  if (list.length > 1) list.insert(list.length - 1, WordConst.and);
  return list.join(' ');
}

/*String encodeDouble(double number, {int gender = 0}) {
  //TODO
}*/

const Map genders = const {
  0: maps0,
  1: maps1,
  2: maps2,
};

// За мъжки род
const Map maps0 = const {
  1: 'един',
  2: 'два',
  3: 'три',
  4: 'четири',
  5: 'пет',
  6: 'шест',
  7: 'седем',
  8: 'осем',
  9: 'девет',
  10: 'десет',
  11: 'единайсет',
  12: 'дванайсет',
  13: 'тринайсет',
  14: 'четиринайсет',
  15: 'петнайсет',
  16: 'шестнайсет',
  17: 'седемнайсет',
  18: 'осемнайсет',
  19: 'деветнайсет',
};

// За женски род
const Map maps1 = const {
  1: 'една',
  2: 'две',
  3: 'три',
  4: 'четири',
  5: 'пет',
  6: 'шест',
  7: 'седем',
  8: 'осем',
  9: 'девет',
  10: 'десет',
  11: 'единайсет',
  12: 'дванайсет',
  13: 'тринайсет',
  14: 'четиринайсет',
  15: 'петнайсет',
  16: 'шестнайсет',
  17: 'седемнайсет',
  18: 'осемнайсет',
  19: 'деветнайсет',
};

// За среден род
const Map maps2 = const {
  1: 'едно',
  2: 'две',
  3: 'три',
  4: 'четири',
  5: 'пет',
  6: 'шест',
  7: 'седем',
  8: 'осем',
  9: 'девет',
  10: 'десет',
  11: 'единайсет',
  12: 'дванайсет',
  13: 'тринайсет',
  14: 'четиринайсет',
  15: 'петнайсет',
  16: 'шестнайсет',
  17: 'седемнайсет',
  18: 'осемнайсет',
  19: 'деветнайсет',
};

class LargeNumberObject {
  final String singular;
  final String plural;
  final int length;

  const LargeNumberObject(this.length, this.singular, this.plural);
}

const List thresholds = const [
  const LargeNumberObject(18, 'куинтилион', 'куинтилиона'),
  const LargeNumberObject(15, 'куадрилион', 'куадрилиона'),
  const LargeNumberObject(12, 'трилион', 'трилиона'),
  const LargeNumberObject(9, 'милиард', 'милиарда'),
  const LargeNumberObject(6, 'милион', 'милиона'),
];

abstract class WordConst {
  static const String and = 'и';
  static const String zero = 'нула';

  // 10^3
  static const String thousandSingular = 'хиляда';
  static const String thousandPlural = 'хиляди';
}

const Map mapTens = const {
  2: 'двайсет',
  3: 'трийсет',
  4: 'четиресет',
  5: 'петдесет',
  6: 'шейсет',
  7: 'седемдесет',
  8: 'осемдесет',
  9: 'деветдесет',
};

const Map mapHundreds = const {
  1: 'сто',
  2: 'двеста',
  3: 'триста',
  4: 'четиристотин',
  5: 'петстотин',
  6: 'шестстотин',
  7: 'седемстотин',
  8: 'осемстотин',
  9: 'деветстотин',
};

void encodeTens(List<String> list, int number, int gender) {
  if (number > 19) {
    list.add(mapTens[number ~/ 10]);
    number %= 10;
  }

  if (number == 0) return;

  list.add(genders[gender][number]);
}

void encodeHundreds(List<String> list, int number, int gender) {
  if (number > 99) {
    list.add(mapHundreds[number ~/ 100]);
    number %= 100;
  }

  encodeTens(list, number, gender);
}

void encodeThousands(List<String> list, int number, int gender) {
  if (number > 999) {
    if (number < 2000) {
      list.add(WordConst.thousandSingular);
    } else {
      final l = <String>[];
      encodeHundreds(l, number ~/ 1000, 2);
      if (l.length > 1) l.insert(l.length - 1, WordConst.and);
      l.add(WordConst.thousandPlural);
      list.add(l.join(' '));
    }
    number %= 1000;
  }

  encodeHundreds(list, number, gender);
}

int encodeThreshold(
    LargeNumberObject o, List<String> list, int number, int gender) {
  final t = pow(10, o.length).toInt();

  if (number > t - 1) {
    final l = <String>[];
    encodeHundreds(l, number ~/ t, 0);
    if (l.length > 1) l.insert(l.length - 1, WordConst.and);
    l.add(number < (t << 1) ? o.singular : o.plural);
    list.add(l.join(' '));
    number %= t;
  }

  return number;
}
