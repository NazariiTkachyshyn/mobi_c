import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  Future<List<Nom>> getNomsByParentKey(String parentKey, int offset);

  Future<List<Nom>> getFolders();

  Future<List<Nom>> searchNomsInFolder(String value, String parentKey);

  Future<List<Remaining>> getNomRemaining(String ref);
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
  Future<List<Remaining>> getNomRemaining(String ref) async {
    try {
      final noms = await _selecNomClient.getNomRemaining(ref);
      return noms
          .map((e) => Remaining(
              storageKey: e.storageKey,
              remaining: e.remaining,
              name: storages.firstWhere((s) => s['ref'] == e.storageKey)['name']))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
