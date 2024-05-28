import 'dart:convert';

class ApiConstants {
  static const odataHost = '192.168.2.198';
  static const odataPath = '/virok_kup/odata/standard.odata';
  static const odataUser = 'dt.odata';
  static const odataPass = 'DT20group';
  static final basicAuth =
      'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';
}
