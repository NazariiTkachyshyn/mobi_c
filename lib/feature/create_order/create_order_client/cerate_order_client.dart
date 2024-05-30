import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mobi_c/models/models.dart';
import 'package:sqflite/sqflite.dart';

import '../../../common/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CreateOrderClient {
  final sqlite = GetIt.I.get<Database>();

  Future<List<OrderNom>> getNoms(int orderId) async {
    try {
      final noms =
          await sqlite.query('orderProduct', where: 'orderId = $orderId');
      return noms.map((e) => OrderNom.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertNom(OrderNom nom, int orderId) async {
    try {
      await sqlite.insert('orderProduct', {
        "ref": nom.ref,
        "orderId": orderId,
        "description": nom.description,
        "article": nom.article,
        "imageKey": nom.imageKey,
        "unitKey": nom.unitKey,
        "priceType": '',
        "price": nom.price,
        "qty": 1
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteNom(int id) async {
    try {
      await sqlite.delete('orderProduct', where: 'id = $id');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateNom(int id, int qty) async {
    try {
      await sqlite.update('orderProduct', {"qty":qty}, where: 'id = ?', whereArgs: [id]);
      

    } catch (e) {
      throw Exception(e);
    }
  }


    Future<void> createOrder(Map<String, dynamic> order) async {

    final basicAuth = ApiConstants.basicAuth;

    try {
      final body = jsonEncode(order);
      final res = await http.post(
          Uri.http(
          ApiConstants.odataHost,
            "${ApiConstants.odataPath}/Document_ЗаказПокупателя?\$format=json"),

          // Uri.parse("${baseUrl}Document_ЗаказКлиента?\$format=json"),
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
    } finally {
      // client.close();
    
  }
}
}