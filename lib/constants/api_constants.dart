import 'dart:convert';

class ApiConstants {
  static const odataHost = '194.44.253.130:8888';
  static const odataPath = '/virok_kup/odata/standard.odata';
  static const odataUser = 'csd';
  static const odataPass = '';
  static final basicAuth =
      'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';
}
