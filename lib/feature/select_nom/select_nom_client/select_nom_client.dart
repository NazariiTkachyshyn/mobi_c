import 'package:mobi_c/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/services/object_box/models/ob_nom.dart';

class SelectNomClient {
  final db = GetIt.I.get<Store>();

  List<ObNom> getAll() {
    try {
      final noms = db.box<ObNom>().getAll();

      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ObNom>> getByParendKey(String parentKey) async {
    try {
      final query =
          db.box<ObNom>().query(ObNom_.parentKey.equals(parentKey)).build();
      final counterparty = await query.findAsync();
      return counterparty;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ObNom>> getNoms(String value) async {
    try {
      final query = db
          .box<ObNom>()
          .query(ObNom_.descriptionLower
              .contains(value.toLowerCase())
              .or(ObNom_.articleLower.contains(value.toLowerCase())))
          .build();
      final counterparty = await query.findAsync();
      return counterparty;
    } catch (e) {
      throw Exception(e);
    }
  }
}
