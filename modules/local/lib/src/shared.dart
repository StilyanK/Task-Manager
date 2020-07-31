library local.shared;

import 'dart:collection';
import 'dart:math';

import 'package:intl/intl.dart';

import '../intl/client.dart' as intl;
import 'entity.dart';

part 'svc/shared/amount.dart';
part 'svc/shared/cur_service.dart';
part 'svc/shared/date.dart';
part 'svc/shared/drug_convert.dart';
part 'svc/shared/lab_unit.dart';
part 'svc/shared/lab_unit_service.dart';
part 'svc/shared/language_service.dart';
part 'svc/shared/mod.dart';
part 'svc/shared/number_to_words.dart';
part 'svc/shared/payment_service.dart';
part 'svc/shared/price.dart';
part 'svc/shared/price_collection.dart';
part 'svc/shared/quantity.dart';
part 'svc/shared/quantity_service.dart';
part 'svc/shared/tax_service.dart';
part 'svc/shared/total.dart';
part 'svc/shared/total_procedure.dart';
part 'svc/shared/weight.dart';
part 'svc/shared/weight_service.dart';

Map getLanguageMap(String key, Iterable<Map> data) {
  final map = {};
  data.forEach((m) {
    m.forEach((k, v) {
      if (k != key && k != 'language_id') {
        if (map[k] == null) map[k] = {};
        map[k][m['language_id'].toString()] = v;
      }
    });
  });
  return map;
}
