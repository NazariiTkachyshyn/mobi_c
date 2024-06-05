import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mobi_c/common/constants/table_named.dart';
import 'package:mobi_c/models/models.dart';
import 'package:sqflite/sqflite.dart';

import '../../../common/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CreateOrderClient {
  final sqlite = GetIt.I.get<Database>();

  Future<List<Contract>> getContracts(String ownerKey) async {
    try {
      final contracts = await sqlite
          .rawQuery('select * from contract where Owner_Key = "$ownerKey"');
      return contracts.map((e) => Contract.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Discount> getDiscount(String discountRecipient) async {
    try {
      final discount = await sqlite.rawQuery(
          'select *, count(*) from $tableDiscount where $fieldDiscountRecipient = "$discountRecipient"');
      return Discount.fromJson(discount.first);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<OrderNom>> getNoms(int orderId) async {
    try {
      final noms =
          await sqlite.query('orderProduct', where: 'orderId = $orderId');
      return noms.map((e) => OrderNom.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertNom(OrderNom nom) async {
    try {
      await sqlite.insert('orderProduct', {
        "ref": nom.ref,
        "orderId": nom.orderId,
        "description": nom.description,
        "article": nom.article,
        "imageKey": nom.imageKey,
        "unitKey": nom.unitKey,
        "unitName": nom.unitName,
        "ratio": nom.ratio,
        "price": nom.price,
        "qty": nom.qty
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Unit>> getUnits(String nomKey) async {
    try {
      final res = await sqlite.rawQuery(
          'select u.*, uc.$fieldDescription from $tableUnit u left join $tableUnitClassificator uc on u.$fieldClasificatorkey = uc.$fieldRefKey  where $fieldOwner = "$nomKey"');
      print(1);
      return res.map((e) => Unit.fromJson(e)).toList();
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

  Future<void> updateNom(int id, int qty, Unit unit) async {
    try {
      await sqlite.update(
          'orderProduct',
          {
            "qty": qty,
            "unitKey": unit.refKey,
            "unitName": unit.description,
            "ratio": unit.ratio,
          },
          where: 'id = ?',
          whereArgs: [id]);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createOrder(Map<String, dynamic> order) async {
    final basicAuth = ApiConstants.basicAuth;

    try {
      final body = jsonEncode(order);
      final res = await http.post(
          Uri.http(ApiConstants.odataHost,
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
        print(res.body);
        throw Exception(res.body);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      // client.close();
    }
  }
}
