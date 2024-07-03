import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mobi_c/common/config/config_repo/config_repo.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class DataSyncApiClient {
  final headers = {
    'Authorization': Config.basicAuth,
    "Accept": "application/json",
    "Accept-Charset": "UTF-8",
    "Content-Type": "application/json",
  };

  //^----------NOMENKLATURA----------------
  Future<List<SyncNom>> getAllNoms() async {
    final uri = Uri.http(Config.odataHost,
        "${Config.odataPath}/InformationRegister_МобільнийКлієнтЗалишки?\$format=json");

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
        Config.odataHost, '${Config.odataPath}/Catalog_Склады', {
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
    final uri = Uri.http(Config.odataHost,
        '${Config.odataPath}/InformationRegister_ШтрихкодыНоменклатуры', {
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
    final uri = Uri.http(Config.odataHost,
        '${Config.odataPath}/Catalog_ДоговорыКонтрагентов', {
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
    final uri = Uri.http(
      Config.odataHost,
      '${Config.odataPath}/Catalog_Контрагенты?\$format=json&\$select=Ref_Key,Description,ГоловнойКонтрагент_Key,НаименованиеПолное,Parent_Key,IsFolder&\$filter=DeletionMark eq false',
    );

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
        Config.odataHost,
        '${Config.odataPath}/InformationRegister_СкидкиНаценкиНоменклатуры_RecordType/SliceLast',
        {
          "\$format": 'json',
          "\$select": "ПолучательСкидки,ПроцентСкидкиНаценки",
          "\$filter": 'Active eq true'
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
    final uri = Uri.http(Config.odataHost,
        '${Config.odataPath}/Catalog_ЕдиницыИзмерения', {
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

  Future<Uint8List> getAllImage(String ref) async {
    final uri = Uri.parse('http://192.168.2.187/$ref.jpg');

    final nomRes = await http.get(uri, headers: headers);

    if (nomRes.statusCode == 200) {
      return nomRes.bodyBytes;
    } else {
      return Uint8List(0);
    }
  }

  Future<int> getCount(String catalog) async {
    final uri = Uri.http(
      Config.odataHost,
      '${Config.odataPath}/$catalog',
    );
    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        return int.parse(nomRes.body);
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
