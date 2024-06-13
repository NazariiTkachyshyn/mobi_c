import 'dart:convert';

import 'package:mobi_c/common/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:mobi_c/common/constants/key_const.dart';

import '../models/models.dart';

class DataSyncApiClient {
  final headers = {
    'Authorization': ApiConstants.basicAuth,
    "Accept": "application/json",
    "Accept-Charset": "UTF-8",
    "Content-Type": "application/json",
  };

  //^----------NOMENKLATURA----------------
  Future<List<SyncNom>> getAllNom() async {
    final uri = Uri.http(ApiConstants.odataHost,
        "${ApiConstants.odataPath}/InformationRegister_МобільнийКлієнтЗалишки?\$format=json&\$filter=Storage_Key eq '${KeyConst.storageKey}'");

    try {
      final nomRes = await http.get(uri, headers: headers);

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

  //^----------STORAGES----------------

  Future<List<SyncStorage>> getAllStorages() async {
    final uri = Uri.http(
        ApiConstants.odataHost, '${ApiConstants.odataPath}/Catalog_Склады', {
      "\$format": 'json',
      "\$select": "Ref_Key,Description",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map((e) => SyncStorage.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------BARCODES----------------

  Future<List<SyncBarcode>> getAllBarcodes() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/InformationRegister_ШтрихкодыНоменклатуры', {
      "\$format": 'json',
      "\$select": "Штрихкод,Номенклатура_Key,Упаковка_Key",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map((e) => SyncBarcode.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------CONTRAKT----------------

  Future<List<SyncContract>> getAllContract() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_ДоговорыКонтрагентов', {
      "\$format": 'json',
      "\$select": "Ref_Key,Owner_Key,Description,Организация_Key",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map((e) => SyncContract.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------KONTRAGENT----------------

  Future<List<SyncCounterparty>> getAllCounterparty() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_Контрагенты', {
      "\$format": 'json',
      "\$select":
          "Ref_Key,Description,ГоловнойКонтрагент_Key,НаименованиеПолное",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map((e) => SyncCounterparty.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------DISCOUNT----------------

  Future<List<SyncDiscount>> getAllDiscount() async {
    final uri = Uri.http(
        ApiConstants.odataHost,
        '${ApiConstants.odataPath}/InformationRegister_СкидкиНаценкиНоменклатуры_RecordType',
        {
          "\$format": 'json',
          "\$select": "ПолучательСкидки,ПроцентСкидкиНаценки",
        });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map((e) => SyncDiscount.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------Unit----------------

  Future<List<SyncUnit>> getAllUnit() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_ЕдиницыИзмерения', {
      "\$format": 'json',
      "\$select":
          "Ref_Key,Owner,Коэффициент,ЕдиницаПоКлассификатору_Key,Description",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map((e) => SyncUnit.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------Images----------------

  Future<List<Map>> getAllImage(int skip, int count) async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_ХранилищеДополнительнойИнформации?\$format=json&\$select=Хранилище_Base64Data,Объект&\$top=$count&\$skip=$skip');

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map(
                (e) => {'ref': e['Объект'], "image": e['Хранилище_Base64Data']})
            .toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
