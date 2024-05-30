import 'package:mobi_c/feature/create_order/create_order_client/cerate_order_client.dart';

import '../../../models/models.dart';

abstract interface class CreateOrderRepo {
  Future<List<OrderNom>> getNoms(int orderId);

  Future<void> insertNom(OrderNom nom, int orderId);

  Future<void> updateNom(int id, int qty);

  Future<void> deleteNom(int id);

  Future<void> createOrder(Map<String, dynamic> order);
}

class CreateOrderRepoImpl implements CreateOrderRepo {
  final CreateOrderClient _createOrderClient;

  CreateOrderRepoImpl({required CreateOrderClient createOrderClient})
      : _createOrderClient = createOrderClient;

  @override
  Future<List<OrderNom>> getNoms(int orderId) async {
    try {
      return await _createOrderClient.getNoms(orderId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> insertNom(OrderNom nom, int orderId) async {
    try {
      await _createOrderClient.insertNom(nom, orderId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteNom(int id) async {
    try {
      await _createOrderClient.deleteNom(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateNom(int id, int qty) async {
    try {
      await _createOrderClient.updateNom(id, qty);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> createOrder(Map<String, dynamic> order) async {
    try {
      await _createOrderClient.createOrder(order);
    } catch (e) {
      throw Exception(e);
    }
  }
}
