import 'dart:convert';

import 'package:mobi_c/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/models.dart';

class DataSyncApiClient {
  //^----------NOMENKLATURA----------------
  Future<List<Nom>> getAllNom() async {
    final uri = Uri.http(
      ApiConstants.odataHost,
      '${ApiConstants.odataPath}/Catalog_Номенклатура?\$format=json&\$select=Ref_Key,Description,Артикул,ЕдиницаИзмерения,Parent_Key,IsFolder&\$filter=DeletionMark eq false',
      //     {
      //   "\$filter": "DeletionMark eq false",

      //   "\$format": 'json',
      //   "\$select": 'Ref_Key,Description,Артикул,ЕдиницаИзмерения,Parent_Key,',
      // }
    );

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
        print((json['value'] as List).length);
        return (json['value'] as List).map((e) => Nom.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------PRICES----------------

  Future<List<Price>> getAllPrices() async {
    final uri = Uri.http(
        ApiConstants.odataHost,
        '${ApiConstants.odataPath}/InformationRegister_ЦеныНоменклатуры_RecordType/SliceLast',
        {"\$format": 'json'});

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
        return (json['value'] as List).map((e) => Price.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------STORAGES----------------

  Future<List<Storage>> getAllStorages() async {
    final uri = Uri.http(
        ApiConstants.odataHost, '${ApiConstants.odataPath}/Catalog_Склады', {
      "\$format": 'json',
      "\$select": "Ref_Key,Description",
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
        return (json['value'] as List).map((e) => Storage.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------BARCODES----------------

  Future<List<Barcode>> getAllBarcodes() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/InformationRegister_ШтрихкодыНоменклатуры', {
      "\$format": 'json',
      "\$select": "Штрихкод,Номенклатура_Key,Упаковка_Key",
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
        return (json['value'] as List).map((e) => Barcode.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------KONTRAGENT----------------

  Future<List<Counterparty>> getAllCounterparty() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_Контрагенты', {
      "\$format": 'json',
      "\$select":
          "Ref_Key,Description,ГоловнойКонтрагент_Key,НаименованиеПолное",
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
        return (json['value'] as List)
            .map((e) => Counterparty.fromJson(e))
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
