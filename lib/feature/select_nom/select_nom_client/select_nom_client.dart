import 'package:get_it/get_it.dart';
import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class SelectNomClient {
  final _store = GetIt.I.get<Store>();

  Future<List<Nom>> getFolders() async {
    try {
      return await _store
          .box<Nom>()
          .query(Nom_.isFolder.equals(true))
          .order(Nom_.description)
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getByParendKey(String parentKey) async {
    try {
      return await _store
          .box<Nom>()
          .query(Nom_.parentKey
              .equals(parentKey)
              .and(Nom_.isFolder.equals(false))
              .and(Nom_.storageKey.equals(KeyConst.storageKey)))
          .order(Nom_.description)
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getByDescription(String description) async {
    try {
      final query = _store
          .box<Nom>()
          .query(Nom_.searchField
              .contains(description.toLowerCase())
              .and(Nom_.isFolder.equals(false))
              .and(Nom_.storageKey.equals(KeyConst.storageKey)))
          .build()
        ..limit = 50;
      return await query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> searchNomInFolder(String value, String parentKey) async {
    try {
      final query = _store
          .box<Nom>()
          .query(Nom_.searchField
              .contains(value.toLowerCase())
              .and(Nom_.isFolder.equals(false))
              .and(Nom_.storageKey.equals(KeyConst.storageKey))
              .and(Nom_.parentKey.equals(parentKey)))
          .build()
        ..limit = 50;
      return await query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }
}
