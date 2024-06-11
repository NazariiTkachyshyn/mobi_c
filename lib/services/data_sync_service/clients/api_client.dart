import 'dart:convert';

import 'package:mobi_c/common/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../../models/models.dart';

class DataSyncApiClient {
  final headers = {
    'Authorization': ApiConstants.basicAuth,
    "Accept": "application/json",
    "Accept-Charset": "UTF-8",
    "Content-Type": "application/json",
  };

  //^----------NOMENKLATURA----------------
  Future<List<ApiNom>> getAllNom() async {
    final uri = Uri.http(
      ApiConstants.odataHost,
      '${ApiConstants.odataPath}/Catalog_Номенклатура?\$format=json&\$select=Ref_Key,Description,Артикул,БазоваяЕдиницаИзмерения_Key,Parent_Key,IsFolder&\$filter=DeletionMark eq false',
    );

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List).map((e) => ApiNom.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------PRICES----------------

  Future<List<ApiPrice>> getAllPrices() async {
    final uri = Uri.http(
        ApiConstants.odataHost,
        "${ApiConstants.odataPath}/InformationRegister_ЦеныНоменклатуры_RecordType/SliceLast?\$filter=ТипЦен_Key eq guid'940e4d76-9712-11e4-249e-8e887ee7bcbd'",
        {"\$format": 'json'});

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List).map((e) => ApiPrice.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------STORAGES----------------

  Future<List<ApiStorage>> getAllStorages() async {
    final uri = Uri.http(
        ApiConstants.odataHost, '${ApiConstants.odataPath}/Catalog_Склады', {
      "\$format": 'json',
      "\$select": "Ref_Key,Description",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List).map((e) => ApiStorage.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------BARCODES----------------

  Future<List<ApiBarcode>> getAllBarcodes() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/InformationRegister_ШтрихкодыНоменклатуры', {
      "\$format": 'json',
      "\$select": "Штрихкод,Номенклатура_Key,Упаковка_Key",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List).map((e) => ApiBarcode.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------CONTRAKT----------------

  Future<List<ApiContract>> getAllContract() async {
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
            .map((e) => ApiContract.fromJson(e))
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

  Future<List<ApiCounterparty>> getAllCounterparty() async {
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
            .map((e) => ApiCounterparty.fromJson(e))
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

  Future<List<ApiDiscount>> getAllDiscount() async {
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
            .map((e) => ApiDiscount.fromJson(e))
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

  Future<List<ApiUnit>> getAllUnit() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_ЕдиницыИзмерения', {
      "\$format": 'json',
      "\$select": "Ref_Key,Owner,Коэффициент,ЕдиницаПоКлассификатору_Key",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List).map((e) => ApiUnit.fromJson(e)).toList();
      } else {
        throw Exception(
            "${nomRes.reasonPhrase ?? ''} ${nomRes.statusCode} ${utf8.decode(nomRes.bodyBytes)}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  //^----------UnitClassificator----------------

  Future<List<UnitClassifier>> getAllUnitClassificator() async {
    final uri = Uri.http(ApiConstants.odataHost,
        '${ApiConstants.odataPath}/Catalog_КлассификаторЕдиницИзмерения', {
      "\$format": 'json',
      "\$select": "Ref_Key,Description,НаименованиеПолное",
    });

    try {
      final nomRes = await http.get(uri, headers: headers);

      if (nomRes.statusCode == 200) {
        final json = jsonDecode(nomRes.body);
        return (json['value'] as List)
            .map((e) => UnitClassifier.fromJson(e))
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
