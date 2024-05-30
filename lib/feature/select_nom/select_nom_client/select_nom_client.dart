import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/models/nom.dart';
import 'package:get_it/get_it.dart';

import 'package:sqflite/sqflite.dart';

class SelectNomClient {
  final sqlite = GetIt.I.get<Database>();

  Future<List<Nom>> getFolders() async {
    try {
      final parentNoms =
          await sqlite.rawQuery('SELECT * FROM noms where IsFolder = 1 order by Description');

      return parentNoms.map((e) => Nom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getByParendKey(String parentKey) async {
    try {
      final parentNoms = await sqlite.rawQuery(
          'SELECT * FROM noms n  LEFT JOIN prices p on p.Номенклатура_Key = n.Ref_Key  where Parent_Key = "$parentKey" and ВидЦены_Key = "${KeyConst.priceType}"');

      return parentNoms.map((e) => Nom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getAllNoms() async {
    try {
      final parentNoms = await sqlite.query('noms');

      return parentNoms.map((e) => Nom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
