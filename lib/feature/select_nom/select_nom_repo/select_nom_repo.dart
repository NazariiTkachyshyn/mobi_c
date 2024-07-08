import 'package:mobi_c/services/data_base/object_box/models/models.dart';
import 'package:mobi_c/repository/authentication_repository/models/storage.dart'
    as config;

import '../../../common/common.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  Future<List<Nom>> getNomsByParentKey(String parentKey, int offset);

  Future<List<Nom>> getFolders();

  Future<List<Nom>> searchNomsInFolder(String value, String parentKey);

  Future<List<Remaining>> getNomRemaining(
      String ref, List<config.Storage> storages);
}

class SelectNomRepoImpl implements SelectNomRepo {
  final SelectNomClient _selecNomClient;

  SelectNomRepoImpl({required SelectNomClient selectNomClient})
      : _selecNomClient = selectNomClient;

  @override
  Future<List<Nom>> getFolders() async {
    try {
      final noms = await _selecNomClient.getFolders();
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Nom>> getNomsByParentKey(String parentKey, int offset) async {
    try {
      final noms = await _selecNomClient.getByParentKey(parentKey, offset);
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Nom>> searchNomsInFolder(String value, String parentKey) async {
    try {
      final noms = await _selecNomClient.searchNomInFolder(value, parentKey);
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Remaining>> getNomRemaining(
      String ref, List<config.Storage> storages) async {
    try {
      final noms = await _selecNomClient.getNomRemaining(ref);

      return storages
          .map((e) => Remaining(
              storageKey: e.refKey,
              remaining: noms
                  .firstWhere(
                    (nom) => nom.storageKey == e.refKey,
                    orElse: () => Nom.empty(),
                  )
                  .remaining,
              name: e.description))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
