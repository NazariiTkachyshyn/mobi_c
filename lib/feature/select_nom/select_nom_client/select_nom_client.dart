import 'package:mobi_c/models/nom.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/services/data_bases/object_box/models/ob.price.dart';
import 'package:mobi_c/services/data_bases/object_box/models/ob_nom.dart';
import 'package:sqflite/sqflite.dart';

class SelectNomClient {
  final db = GetIt.I.get<Store>();
  final sqlite = GetIt.I.get<Database>();

  Future<List<Nom>> getAll() async {
    try {
      final parentNoms =
          await sqlite.rawQuery('SELECT * FROM noms where isFolder = 1');

      print(parentNoms.length);

      return parentNoms.map((e) => Nom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  ObPrice getPriceByRef(String ref) {
    try {
      final price = db
          .box<ObPrice>()
          .query(ObPrice_.nomKey.equals(ref))
          .build()
          .findFirst();

      return price ??
          ObPrice(
              price: 0,
              priceType: '',
              packKey: '',
              currencyKey: '',
              nomKey: '');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getByParendKey(String parentKey) async {
    try {
      final parentNoms = await sqlite
          .rawQuery('SELECT * FROM noms where parentKey = "$parentKey"');

      print(parentNoms.length);

      return parentNoms.map((e) => Nom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getNomsInFolder(String value, String parentKey) async {
    try {
      final parentNoms = await sqlite.rawQuery(
          'SELECT * FROM noms where parentKey = "$parentKey" and description like "%$value%" or article like "%$value%"');


      return parentNoms.map((e) => Nom.fromSql(e)).toList();
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
