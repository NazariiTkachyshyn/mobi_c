import 'dart:convert';

import 'package:mobi_c/common/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../services/data_sync_service/models/models.dart';

class OdataNomApiClient {
  Future<List<SyncNom>> getAllNom() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_Номенклатура', {
      "\$format": 'json',
      "\$select": 'Ref_Key,Description,Артикул,БазоваяЕдиницаИзмерения_Key,Parent_Key',
      '\$top': '7953'
    });

    try {
      final nomRes = await http.get(
        uri,
        headers: {
          'Authorization': ApiConstants.basicAuth,
          "Accept": "application/json",
          "Accept-Charset": "UTF-8",
          "Content-Type": "application/json",
        },
      );

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List).map((e) => SyncNom.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
