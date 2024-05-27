import 'package:mobi_c/feature/create_order/create_order_client/cerate_order_client.dart';
import 'package:mobi_c/services/object_box/models/models.dart';

import '../../../models/models.dart';

abstract interface class CreateOrderRepo {
  Future<List<OrderNom>> getNoms(int orderId);

  Future<void> insertNom(OrderNom nom);

  Future<void> updateNom(OrderNom nom);

  Future<void> deleteNom(int id);
}

class CreateOrderRepoImpl implements CreateOrderRepo {
  final CreateOrderClient _createOrderClient;

  CreateOrderRepoImpl({required CreateOrderClient createOrderClient})
      : _createOrderClient = createOrderClient;

  @override
  Future<List<OrderNom>> getNoms(int orderId) async {
    try {
      final obNoms = await _createOrderClient.getNoms(orderId);
      return obNoms.map((e) => OrderNom.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> insertNom(OrderNom nom) async {
    try {
      await _createOrderClient.insertNom(ObOrderNom.fromOrderNom(nom));
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
  Future<void> updateNom(OrderNom nom) async {
    try {
      await _createOrderClient.updateNom(ObOrderNom.fromOrderNom(nom));
    } catch (e) {
      throw Exception(e);
    }
  }
}
