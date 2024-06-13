import 'dart:convert';

// class ApiConstants {
//   static const odataHost = '192.168.2.198';
//   static const odataPath = '/virok_kup/odata/standard.odata';
//   static const odataUser = 'dt.odata';
//   static const odataPass = 'DT20group';
//   static final basicAuth =
//       'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';
// }

class ApiConstants {
  static const odataHost = '192.168.2.50:81';
  static const odataPath = '/virok_test/odata/standard.odata';
  static const odataUser = 'dt';
  static const odataPass = 'DT20Group';
  static final basicAuth =
      'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';

  static const postgresHost = '192.168.2.134';
  static const postgresUser = 'postgres';
  static const postgresPass = 'DT20Group';
  static const postgresDb = 'virok_mob';
}




// class ApiConstants {
//   static const odataHost = '192.168.2.50:81';
//   static const odataPath = '/virok_kup/odata/standard.odata';
//   static const odataUser = 'csd';
//   static const odataPass = '';
//   static final basicAuth =
//       'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';
// }
