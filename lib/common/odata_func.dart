import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobi_c/common/constants/api_constants.dart';

class OdataClient {
  final client = http.Client();

  Future<String> getOferta(String counterpartyKey) async {
    try {
      final res = await client.get(
        Uri.http(ApiConstants.odataHost,
            "${ApiConstants.odataPath}/Catalog_СоглашенияСКлиентами?\$format=json&\$top=10&\$filter=Контрагент_Key eq guid'$counterpartyKey'and Статус eq 'Действует'&\$select=Ref_Key"),
        headers: {
          'Authorization': ApiConstants.basicAuth,
          "Accept": "application/json",
          "Accept-Charset": "UTF-8",
          "Content-Type": "application/json",
        },
      );

      if (res.statusCode == 200) {
        Map json = jsonDecode(res.body);
        return (json['value'] as List).isEmpty
            ? '00000000-0000-0000-0000-000000000000'
            : json['value'][0]['Ref_Key'];
      } else {
        throw Exception('Помилка HTTP-запиту зі статусом ${res.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      client.close();
    }
  }
}
