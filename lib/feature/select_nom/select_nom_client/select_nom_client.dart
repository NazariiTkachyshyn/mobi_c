import 'package:get_it/get_it.dart';
import 'package:mobi_c/repository/config_repo/config_repo.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

class SelectNomClient {
  final _store = GetIt.I.get<Store>();

  Future<List<Nom>> getFolders() async {
    try {
      return await _store
          .box<Nom>()
          .query(Nom_.isFolder
              .equals(true)
              .and(Nom_.storageKey.endsWith(Config.storageKey)))
          .order(Nom_.description)
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getByParentKey(String parentKey, int offset) async {
    try {
      final isEqParentKey = parentKey.isNotEmpty
          ? Nom_.parentKey.equals(parentKey)
          : Nom_.parentKey.notEquals('');
      final query = _store
          .box<Nom>()
          .query(isEqParentKey
              .and(Nom_.isFolder.equals(false))
              .and(Nom_.storageKey.equals(Config.storageKey)))
          .order(Nom_.article)
          .build()
        ..limit = 30
        ..offset = offset;

      return await query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> searchNomInFolder(
    String value,
    String parentKey,
  ) async {
    final valueList = value.split(' ');

    final isEqParentKey = parentKey.isNotEmpty
        ? Nom_.parentKey.equals(parentKey)
        : Nom_.parentKey.notEquals('');
    final contains = valueList.length > 1
        ? Nom_.searchField
            .contains(valueList[0].toLowerCase())
            .and(Nom_.searchField.contains(valueList[1].toLowerCase()))
        : Nom_.searchField.contains(valueList[0].toLowerCase());
    try {
      final query = _store
          .box<Nom>()
          .query(contains
              .and(Nom_.isFolder.equals(false))
              .and(Nom_.storageKey.equals(Config.storageKey))
              .and(isEqParentKey))
          .order(Nom_.article)
          .build()
        ..limit = 50;
      return await query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Nom>> getNomRemaining(String ref) async {
    try {
      final query = _store.box<Nom>().query(Nom_.ref.equals(ref)).build();

      return await query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }
}
