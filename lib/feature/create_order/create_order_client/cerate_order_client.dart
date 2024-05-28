import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:get_it/get_it.dart';

class CreateOrderClient {
  final db = GetIt.I.get<Store>();

  Future<List<ObOrderNom>> getNoms(int orderId) async {
    try {
      final query = db
          .box<ObOrderNom>()
          .query(ObOrderNom_.orderId.equals(orderId))
          .build();
      final noms = await query.findAsync();
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertNom(ObOrderNom nom) async {
    try {
      await db.box<ObOrderNom>().putAsync(nom);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteNom(int id) async {
    try {
      await db.box<ObOrderNom>().removeAsync(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateNom(ObOrderNom nom) async {
    try {
      await db.box<ObOrderNom>().putAsync(nom);
    } catch (e) {
      throw Exception(e);
    }
  }
}
