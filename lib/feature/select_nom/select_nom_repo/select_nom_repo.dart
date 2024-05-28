import '../../../models/models.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  Future<List<Nom>> getNoms(String value);
  Future<List<Nom>> getNomsByParentKey(String parentKey);
  Future<List<Nom>> getNomsInFolder(String value, String parentKey);

  Future<List<Nom>> getAllNoms();
}

class SelectNomRepoImpl implements SelectNomRepo {
  final SelectNomClient _selecNomClient;

  SelectNomRepoImpl({required SelectNomClient selectNomClient})
      : _selecNomClient = selectNomClient;

  @override
  Future<List<Nom>> getAllNoms() async {
    try {
      final noms = await _selecNomClient.getAll();
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Nom>> getNoms(String value) async {
    // try {
    //   final obCounterpartys = await _selecNomClient.getNoms(value);
    //   return obCounterpartys.map((e) => Nom.fromObNom(e)).toList();
    // } catch (e) {
    //   throw Exception(e);
    // }
    return [];
  }

  @override
  Future<List<Nom>> getNomsByParentKey(String parentKey) async {
    try {
      final noms = await _selecNomClient.getByParendKey(parentKey);
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Nom>> getNomsInFolder(String value, String parentKey) async {
    try {
      final noms = await _selecNomClient.getNomsInFolder(value, parentKey);
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }
}
