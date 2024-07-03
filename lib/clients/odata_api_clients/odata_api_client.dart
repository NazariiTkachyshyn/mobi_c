import 'dart:convert';

import 'package:mobi_c/common/config/config_repo/config_repo.dart';
import 'package:http/http.dart' as http;

class OdataApiClient {
  Future<void> createOrder(Map<String, dynamic> order) async {
    final basicAuth = Config.basicAuth;

    try {
      final body = jsonEncode(order);
      final res = await http.post(
          Uri.http(Config.odataHost,
              "${Config.odataPath}/Document_ЗаказПокупателя?\$format=json"),
          headers: {
            'Authorization': basicAuth,
            "Accept": "application/json",
            "Accept-Charset": "UTF-8",
            "Content-Type": "application/json",
          },
          body: body);

      if (res.statusCode == 201) {
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
