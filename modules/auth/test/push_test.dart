@TestOn('vm')
library test;

import 'dart:async';

import 'package:auth/src/svc/web_push.dart';
import 'package:test/test.dart';

///For test
///https://tests.peter.sh/push-encryption-verifier/

final data = new DataOptions()
  ..p256dh =
      'BPQHSkCw28T1g6pzN5hf6F9c0aA20vd6WTHJyLqs5_rsgxsskxbCB-4ZHEp6Y'
      'cUlQ875k1oIAJjPKn856NDReWo'
  ..auth = 'KL2PkX-TanQMbLDMYJc6bw'
  ..endpoint =
      'https://fcm.googleapis.com/fcm/send/fw3tENSEBOg:APA91bGZtmLp4tRK72L'
      'thxbfjfl-0i4i38tRxYBs2e5m3SwYg7j2568y7mNJDWktEUxlt26uONeB0GgmDw'
      'q5ePyfCinXiEQp8pCUVNp7zwjeOqYmgICmmaOh78oZEImqbW8Z22VRICvF'
  ..vapid_public_key =
      'BPr24F-pXbREl5LKvhVJKPHFjxOQMIgCr9gWRZNVwnbkMuyPoJzyyk7LCYdDWOeR941'
      'qfMC2yOFLDMihrxxqN-8'
  ..vapid_private_key = 'fkZyuSddZC3XLux5w2zDATXcClomo03JnzeR_RqKRKs'
  ..app_server_key = 'AAAAScNcQEo:APA91bFgkwHQlDroikEwViEvsWo1W-2Xh7b3'
      '7APRiiXk6oIEXJkqx8duGGTOQG0BhBoP3Vhkrg0E5SImVDVxUavHaZZ3DLwr33tt60bN'
      'yFHVJufPp-obe5a4jgZeSF1RyfEs16s_EmMB'
  ..app_sender_id = '316810215498';


Future<void> main() async {
  setUp(() {});
  test('Encrypt', encrypt);
}

Future encrypt() async {
  final wp = new WebPush(data);
  final secret = await wp.generateSecret();
  print(secret);
}
