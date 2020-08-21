import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart' as cr;

make(String clientPublicKey, String clientAuthSecret) async {
  final algorithm = cr.ecdhP256;
  final localKeyPair = await algorithm.newKeyPair();
  final sharedSecretKey = await algorithm.sharedSecret(
    localPrivateKey: localKeyPair.privateKey,
    remotePublicKey: new cr.PublicKey(utf8.encode(clientPublicKey)),
  );
  final prk = await const cr.Hkdf(cr.Hmac(cr.sha256)).deriveKey(sharedSecretKey,
      nonce: new cr.Nonce(utf8.encode(clientAuthSecret)),
      info: utf8.encode('Content-Encoding: auth\0'),
      outputLength: 32);
}

main() {
  final d = new ByteData(10);
  d.setUint8(2, 100);
  final d2 = new ByteData(10);
  d2.setUint8(2, 120);
  final n = new Uint8List(d2.lengthInBytes + d.lengthInBytes);
  n.setAll(0, d.buffer.asUint8List());
  n.setAll(10, d2.buffer.asUint8List());
  print(n);
//  final n = d.buffer.asUint8List();
//  n.addAll(d2.buffer.asUint8List());
//  print(n);
}

//createInfo(
//    String type, cr.PublicKey clientPublicKey, cr.PublicKey serverPublicKey) {
//  final len = type.length;
//
//  // The start index for each element within the buffer is:
//  // value               | length | start    |
//  // -----------------------------------------
//  // 'Content-Encoding: '| 18     | 0        |
//  // type                | len    | 18       |
//  // nul byte            | 1      | 18 + len |
//  // 'P-256'             | 5      | 19 + len |
//  // nul byte            | 1      | 24 + len |
//  // client key length   | 2      | 25 + len |
//  // client key          | 65     | 27 + len |
//  // server key length   | 2      | 92 + len |
//  // server key          | 65     | 94 + len |
//  // For the purposes of push encryption the length of the keys will
//  // always be 65 bytes.
//  final info = new Uint8List(18 + len + 1 + 5 + 1 + 2 + 65 + 2 + 65);
//
//  var blob = ByteData.sublistView(info);
//  blob.setInt8(0, value)
//
//  // The string 'Content-Encoding: ', as utf-8
//  info..se('Content-Encoding: ');
//  // The 'type' of the record, a utf-8 string
//  info.write(type, 18);
//  // A single null-byte
//  info.write('\0', 18 + len);
//  // The string 'P-256', declaring the elliptic curve being used
//  info.write('P-256', 19 + len);
//  // A single null-byte
//  info.write('\0', 24 + len);
//  // The length of the client's public key as a 16-bit integer
//  info.writeUInt16BE(clientPublicKey.length, 25 + len);
//  // Now the actual client public key
//  clientPublicKey.copy(info, 27 + len);
//  // Length of our public key
//  info.writeUInt16BE(serverPublicKey.length, 92 + len);
//  // The key itself
//  serverPublicKey.copy(info, 94 + len);
//
//  return info;
//}
