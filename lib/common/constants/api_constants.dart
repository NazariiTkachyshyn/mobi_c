import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:mobi_c/common/models/config.dart';

// class ApiConstants {
//   static const odataHost = '192.168.2.198';
//   static const odataPath = '/virok_kup/odata/standard.odata';
//   static const odataUser = 'dt.odata';
//   static const odataPass = 'DT20group';
//   static final basicAuth =
//       'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';
// }
final dbConfigJson = GlobalConfiguration().getValue('dbConn');
final imagesDbJson = GlobalConfiguration().getValue('imagesDb');

final dbConnConfig = DbConn.fromJson(dbConfigJson);
final imagesDbConfig = ImagesDb.fromJson(imagesDbJson);
class ApiConstants {
  static final odataHost = dbConnConfig.host;
  static final odataPath = dbConnConfig.path;
  static final odataUser = dbConnConfig.user;
  static final odataPass = dbConnConfig.pass;
  static final basicAuth =
      'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';


}




// class ApiConstants {
//   static const odataHost = '192.168.2.50:81';
//   static const odataPath = '/virok_kup/odata/standard.odata';
//   static const odataUser = 'csd';
//   static const odataPass = '';
//   static final basicAuth =
//       'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';
// }



