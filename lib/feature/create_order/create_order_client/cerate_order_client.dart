import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mobi_c/common/config/config_repo/config_repo.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

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

  Future<List<OrderNom>> getNoms(int orderId) async {
    try {
      return await _store
          .box<OrderNom>()
          .query(OrderNom_.orderId.equals(orderId))
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertNom(OrderNom nom) async {
    try {
      await _store.box<OrderNom>().putAsync(nom);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Unit>> getUnits(String nomKey) async {
    try {
      return await _store
          .box<Unit>()
          .query(Unit_.owner.equals(nomKey))
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteNom(int id) async {
    try {
      final res = await _store.box<OrderNom>().removeAsync(id);
      print(res);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateNom(OrderNom nom) async {
    try {
      await _store.box<OrderNom>().putAsync(nom);
    } catch (e) {
      throw Exception(e);
    }
  }

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
        print(res.statusCode);
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
