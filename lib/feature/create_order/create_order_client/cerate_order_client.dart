import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

import '../../../common/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CreateOrderClient {
  final _store = GetIt.I.get<Store>();

  Future<List<Contract>> getContracts(String ownerKey) async {
    try {
      return await _store
          .box<Contract>()
          .query(Contract_.ownerKey.equals(ownerKey))
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Discount?> getDiscount(String discountRecipient) async {
    try {
      return await _store
          .box<Discount>()
          .query(Discount_.discountRecipientKey.equals(discountRecipient))
          .build()
          .findFirstAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ApiOrderNom>> getNoms(int orderId) async {
    try {
      return [];
      // final noms =
      //     await sqlite.query('orderProduct', where: 'orderId = $orderId');
      // return noms.map((e) => ApiOrderNom.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertNom(ApiOrderNom nom) async {
    try {
      // await sqlite.insert('orderProduct', {
      //   "ref": nom.ref,
      //   "orderId": nom.orderId,
      //   "description": nom.description,
      //   "article": nom.article,
      //   "imageKey": nom.imageKey,
      //   "unitKey": nom.unitKey,
      //   "unitName": nom.unitName,
      //   "ratio": nom.ratio,
      //   "price": nom.price,
      //   "qty": nom.qty
      // });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ApiUnit>> getUnits(String nomKey) async {
    try {
      // final res = await sqlite.rawQuery(
      //     'select u.*, uc.$fieldDescription from $tableUnit u left join $tableUnitClassificator uc on u.$fieldClasificatorkey = uc.$fieldRefKey  where $fieldOwner = "$nomKey"');
      // print(1);
      // return res.map((e) => ApiUnit.fromJson(e)).toList();
            return [];

    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteNom(int id) async {
    try {
      // await sqlite.delete('orderProduct', where: 'id = $id');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateNom(int id, int qty, ApiUnit unit) async {
    try {
      // await sqlite.update(
      //     'orderProduct',
      //     {
      //       "qty": qty,
      //       "unitKey": unit.refKey,
      //       "unitName": unit.description,
      //       "ratio": unit.ratio,
      //     },
      //     where: 'id = ?',
      //     whereArgs: [id]);
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
