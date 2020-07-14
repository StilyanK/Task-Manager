import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sass/sass.dart' as sass;
import 'package:template/mustache.dart' as m;
import 'package:template/template.dart';

import 'resource.dart';

class HeaderDTO {
  String logo;
  String name;
  String address;
  String phone;
  String mail;

  String headerTemplate = '''
<div class="logo-header">
    <img src="{{logo}}" alt="" />
    <ul>
        <li class="hospital">{{name}}</li>
        <li>{{address}}, тел: {{phone}}, имейл: {{mail}}</li>
    </ul>
</div>
''';

  void setLogo(String value) => logo = value;

  void setName(String value) => name = value;

  void setAddress(String value) => address = value;

  void setPhone(String value) => phone = value;

  void setMail(String value) => mail = value;

  //type should be 'company' or 'medical_center'
  Future<String> generateLogo(
      String basePath, LogoType type, int id, String picture) async {
    final path = '$basePath/media/${_logoTypeMap[type]}/$id/$picture';
    final logoFile = File(path);
    if (logoFile.existsSync()) {
      final logoBytes = await File(path).readAsBytes();
      String logo = '';

      if (path.endsWith('.jpg')) {
        logo = 'data:image/jpeg;base64,${base64.encode(logoBytes)}';
      } else if (path.endsWith('.png')) {
        logo = 'data:image/png;base64,${base64.encode(logoBytes)}';
      } else if (path.endsWith('.svg')) {
        logo = 'data:image/svg;base64,${base64.encode(logoBytes)}';
      }
      return logo;
    }
    return null;
  }
}

abstract class BaseDTO {
  HeaderDTO _header;
  String path;
  String pathCore;
  String print;
  String css;

  Future<String> get header async {
    _header ??= (HeaderDTO()
      ..setLogo(
          'data:image/png;base64,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')
      ..setName('Medicframe Ltd')
      ..setPhone('+000 101 010')
      ..setMail('office@medicframe.com')
      ..setAddress('Варна, ул. "Девня 10", офис 9'));
    return Template.renderString(_header.headerTemplate, _header);
  }

  void setHeader(HeaderDTO dto) => _header = dto;

  String textEllipsis(String text, int length) {
    if (text == null) return '';
    if (text.length < length) return text;

    final cut = text.substring(0, length);
    final words = cut.split(' ');
    words[words.length - 1] = '...';
    return words.join(' ');
  }

  List<String> padLeftValue(String value, int width, [String padding = '0']) =>
      value?.padLeft(width, padding)?.split('');

  List<String> padRightValue(String value, int width, [String padding = '0']) =>
      value?.padRight(width, padding)?.split('');

  String formatDate(DateTime ts, String separator) {
    if (ts == null) return null;
    final y = ts.year.toString().padLeft(4, ' ');
    final m = ts.month.toString().padLeft(2, '0');
    final d = ts.day.toString().padLeft(2, '0');
    return '$d$separator$m$separator$y';
  }

  String formatDateTime(DateTime ts) {
    if (ts == null) return null;
    final y = ts.year.toString().padLeft(4, ' ');
    final m = ts.month.toString().padLeft(2, '0');
    final d = ts.day.toString().padLeft(2, '0');
    final h = ts.hour.toString().padLeft(2, '0');
    final mi = ts.minute.toString().padLeft(2, '0');
    return '$d$m$y$h$mi';
  }

  String formatTime(DateTime ts, [String separator = '']) {
    if (ts == null) return null;
    final h = ts.hour.toString().padLeft(2, '0');
    final m = ts.minute.toString().padLeft(2, '0');
    return '$h$separator$m';
  }
}

abstract class LogoTypePath {
  static const String Company = 'company';
  static const String MedicalCenter = 'medical_center';
}

const Map _logoTypeMap = const {
  LogoType.Company: LogoTypePath.Company,
  LogoType.MedicalCenter: LogoTypePath.MedicalCenter,
};

enum LogoType { Company, MedicalCenter }

Future<String> generate(
    String package, String document, BaseDTO o, String basePath,
    {bool test = false, bool wrap = true, bool landscape = false}) async {
  String content = await loadResourceString(
      '$package/template/$document/index.html', basePath, test);

  //TODO Hack to determine if we are running locally
  final deployed = Directory('$basePath/web/packages').existsSync();

  final cssSuffix = deployed ? 'css' : 'scss';

  var printCss =
      await loadResourceString('hms_icon/css/print.$cssSuffix', basePath, test);
  var css = await loadResourceString(
      '$package/template/$document/main.$cssSuffix', basePath, test);

  String pathCore;
  String path;

  if (!test) {
    if (deployed) {
      path = '$basePath/web/packages/$package/template/$document/';
      pathCore = '$basePath/web/packages/hms_icon/';
    } else {
      printCss = await sass.compileStringAsync(printCss);
      css = await sass.compileStringAsync(css);
      path = '$basePath/../$package/lib/template/$document/';
      pathCore = '$basePath/../hms_icon/lib/';
    }
  } else {
    printCss = await sass.compileStringAsync(printCss);
    css = await sass.compileStringAsync(css);
    path = '/$package/template/$document/';
    pathCore = '/$package/../hms_icon/';
  }

  o
    ..print = printCss
    ..css = css
    ..path = path
    ..pathCore = pathCore;

  if (wrap) {
    content = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{title}}</title>
    <style>
        @page {size: A4${landscape ? ' landscape' : ''}; margin: 5mm;}
        body {padding: 0; margin: 0;}
        ${o.print}
        ${o.css}
    </style>
</head>
<body>
$content
</body>
</html>
''';
  }

  m.PartialResolver partial;
  partial = (name) async =>
      template(await loadResourceString(name, basePath, test), partial);

  return template(content, partial).renderString(o);
}

m.Template template(String content, m.PartialResolver partial) =>
    m.Template(content,
        lenient: true, htmlEscapeValues: false, partialResolver: partial);
