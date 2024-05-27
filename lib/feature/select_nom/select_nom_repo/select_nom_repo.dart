import '../../../models/models.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  Future<List<Nom>> getNoms(String value);
  Future<List<Nom>> getNomsByParentKey(String parentKey);
  List<Nom> getAllNoms();
}

class SelectNomRepoImpl implements SelectNomRepo {
  final SelectNomClient _selecNomClient;

  SelectNomRepoImpl({required SelectNomClient selectNomClient})
      : _selecNomClient = selectNomClient;

  @override
  List<Nom> getAllNoms() {
    try {
      final obCounterpartys = _selecNomClient.getAll();
      return obCounterpartys.map((e) => Nom.fromObNom(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Nom>> getNoms(String value) async {
    try {
      final obCounterpartys = await _selecNomClient.getNoms(value);
      return obCounterpartys.map((e) => Nom.fromObNom(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Nom>> getNomsByParentKey(String parentKey) async {
    try {
      final obCounterpartys = await _selecNomClient.getByParendKey(parentKey);
      return obCounterpartys.map((e) => Nom.fromObNom(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
