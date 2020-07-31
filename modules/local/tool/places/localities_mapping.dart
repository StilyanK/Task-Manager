import 'dart:async';
import 'dart:io';

import 'package:cl_base/server.dart' as cl_base;

Future<void> main(List<String> args) async {
  final directory = new Directory(Directory.current.path);
  final rhifPath = '${directory.path}/rhif_done.xls';
  final ekattePath = '${directory.path}/ekatte.xls';
  final rhifFile = new File(rhifPath);
  final ekatteFile = new File(ekattePath);
  final sb = new StringBuffer();

  final ekatteContent = await ekatteFile.readAsBytes();
  await (new cl_base.XLS.fromXLSBytes(ekatteContent).toMap()).toList();

  final rhifContent = await rhifFile.readAsBytes();
  final List<Map> rhifBuffer =
      await (new cl_base.XLS.fromXLSBytes(rhifContent).toMap()).toList();
  const count = 0;

  /*for(int i = 0;i < ekatteBuffer.length;i++) {
    var placeName = ekatteBuffer[i]['name'];

    if(!isFound) count++;

    isFound = false;
    for(Map r in rhifBuffer) {
      if(r['region_code'].trim() == ekatteBuffer[i]['obstina'].trim()) {
        sb.write('(\'${ ekatteBuffer[i]['name']}\', \'${r['rhif'].toString().padLeft(2, '0')}\', \'${r['region_code']}\'), \n');
        isFound = true;
        break;
      }
    }

    if(!isFound) {
      print(placeName);
    }
  }*/

  for (final o in rhifBuffer) {
    sb.write(
        '(\'${o['region_code']}\', \'${o['rhif'].toString().padLeft(2, '0')}\','
        ' \'${o['region_id'].toString().padLeft(2, '0')}\','
        ' \'${o['region_name']}\'), \n');
  }
// ignore: avoid_print
  print(count);

  final f = await new File('output.sql').create(recursive: true);
  await f.writeAsString(sb.toString(), mode: FileMode.append);

  /*var f = await new File('rhif_done.xls').create(recursive: true);
  var stream = new cl_base.XLS.fromMapData(rhifBuffer).toXls();
  List<int> data = new List();
  await for(var r in stream)
    data.addAll(r);
  await f.writeAsBytes(data);*/
}
