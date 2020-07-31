library hms_local.server;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:local/src/mapper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mapper/mapper.dart';

part 'svc/server/currency/base.dart';
part 'svc/server/currency/ecb.dart';
part 'svc/server/dashboard.dart';
part 'svc/server/language_set.dart';
part 'svc/server/tr_service.dart';

String translate(String key, Map dict) {
  final parts = new Queue.from(key.trim().split('|'));
  if (parts.isEmpty) return '';
  final s = parts.removeFirst();
  String string = dict[s];
  if (string == null) return s;
  if (parts.isNotEmpty) {
    string = string
        .split('%s')
        .map((r) => r + ((parts.isNotEmpty) ? parts.removeFirst() : ''))
        .join('');
  }
  return string;
}

bool isEUCountry(int country_id) {
  final eu_countries = [
    13, //Austria
    21, //Belgium
    23, //Bulgaria
    97, //Croatia
    54, //Cyprus
    55, //Czech Republic
    58, //Denmark
    63, //Estonia
    69, //Finland
    74, //France
    56, //Germany
    88, //Greece
    99, //Hungary
    101, //Ireland
    109, //Italy
    134, //Latvia
    132, //Lithuania
    133, //Luxembourg
    152, //Malta
    165, //Netherlands
    178, //Poland
    183, //Portugal
    188, //Romania
    201, //Slovakia
    199, //Slovenia
    67, //Spain
    196, //Sweden
    76, //United Kingdom
  ];
  return eu_countries.contains(country_id);
}
