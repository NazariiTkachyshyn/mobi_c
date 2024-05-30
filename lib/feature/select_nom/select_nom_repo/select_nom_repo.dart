import '../../../models/models.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  
  Future<List<Nom>> getAllNoms();

  Future<List<Nom>> getNomsByParentKey(String parentKey);

  Future<List<Nom>> getFolders();
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
  Future<List<Nom>> getAllNoms() async {
    try {
      final noms = await _selecNomClient.getAllNoms();
      return noms;
    } catch (e) {
      throw Exception(e);
    }
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


}
