import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/order_repo.dart';
import 'package:mobi_c/repository/config_repo/config_repo.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

import 'package:http/http.dart' as http;
import 'package:mobi_c/services/data_base/object_box/object_box.dart';
import 'package:mobi_c/services/data_sync_service/models/full_order.dart';
import 'package:mobi_c/services/data_sync_service/models/order.dart';
import 'package:mobi_c/services/data_base/object_box/models/order.dart'
    as Model;

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
      await _store.box<OrderNom>().removeAsync(id);
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
        body: body,
      );

      if (res.statusCode == 201) {
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createOrderWithOfflineFallback(
      Map<String, dynamic> order) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Connected to the internet');
        await createOrder(order);
      } else {
        print('No internet connection');
        final objectBox = GetIt.I<ObjectBox>();
        final orderRepository =
            OrderRepository(objectBox.store.box<FullOrder>());
        await orderRepository.saveOrderOffline(FullOrder.fromJson(order));
      }
    } on SocketException catch (_) {
      print('Not connected to the internet');
// Create order locally
      final objectBox = GetIt.I<ObjectBox>();
      final orderRepository = OrderRepository(objectBox.store.box<FullOrder>());
      final fullOrder = FullOrder.fromJson(
          order); // Assuming order is of type Map<String, dynamic>
      await orderRepository.saveOrderOffline(fullOrder);
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to create order: $e');
    }
  }
}
