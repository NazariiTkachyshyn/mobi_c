import 'package:mobi_c/feature/create_order/create_order_client/cerate_order_client.dart';

import '../../../models/models.dart';

abstract interface class CreateOrderRepo {
  Future<List<OrderNom>> getNoms(int orderId);

  Future<void> insertNom(OrderNom nom);

  Future<void> updateNom(int id, int qty, Unit unit);

  Future<void> deleteNom(int id);

  Future<void> createOrder(Map<String, dynamic> order);

  Future<List<Contract>> getContracts(String ownerKey);

  Future<Discount> getDiscount(String discountRecipient);

  Future<List<Unit>> getUnits(String nomKey);
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
  Future<void> insertNom(OrderNom nom) async {
    try {
      await _createOrderClient.insertNom(nom);
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
  Future<void> updateNom(int id, int qty, Unit unit) async {
    try {
      await _createOrderClient.updateNom(id, qty, unit);
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

  @override
  Future<List<Contract>> getContracts(String ownerKey) async {
    try {
      return await _createOrderClient.getContracts(ownerKey);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Discount> getDiscount(String discountRecipient) async {
    try {
      return await _createOrderClient.getDiscount(discountRecipient);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Unit>> getUnits(String nomKey) async {
    try {
      return await _createOrderClient.getUnits(nomKey);
    } catch (e) {
      throw Exception(e);
    }
  }
}
