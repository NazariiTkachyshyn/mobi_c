import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/common/constants/table_named.dart';
import 'package:mobi_c/models/nom.dart';
import 'package:get_it/get_it.dart';

import 'package:sqflite/sqflite.dart';

class SelectNomClient {
  final sqlite = GetIt.I.get<Database>();

  Future<List<ApiNom>> getFolders() async {
    try {
      final parentNoms =
          await sqlite.rawQuery('SELECT * FROM noms where IsFolder = 1 order by Description');

      return parentNoms.map((e) => ApiNom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ApiNom>> getByParendKey(String parentKey) async {
    try {
      final parentNoms = await sqlite.rawQuery(
          'SELECT n.*, p.Цена FROM noms n  LEFT JOIN prices p on p.Номенклатура_Key = n.Ref_Key  where Parent_Key = "$parentKey" and ТипЦен_Key = "${KeyConst.priceType}" and $fieldIsFolder != 1');

      return parentNoms.map((e) => ApiNom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ApiNom>> getAllNoms() async {
    try {
      final parentNoms = await sqlite.rawQuery('select n.*, p.Цена from $tableNoms n LEFT JOIN prices p on p.Номенклатура_Key = n.Ref_Key where $fieldIsFolder != 1');

      return parentNoms.map((e) => ApiNom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
