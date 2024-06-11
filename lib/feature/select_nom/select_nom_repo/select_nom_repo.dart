import '../../../models/models.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  
  Future<List<ApiNom>> getAllNoms();

  Future<List<ApiNom>> getNomsByParentKey(String parentKey);

  Future<List<ApiNom>> getFolders();
}

class SelectNomRepoImpl implements SelectNomRepo {
  final SelectNomClient _selecNomClient;

  SelectNomRepoImpl({required SelectNomClient selectNomClient})
      : _selecNomClient = selectNomClient;

  @override
  Future<List<ApiNom>> getFolders() async {
    try {
      final noms = await _selecNomClient.getFolders();
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ApiNom>> getAllNoms() async {
    try {
      final noms = await _selecNomClient.getAllNoms();
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ApiNom>> getNomsByParentKey(String parentKey) async {
    try {
      final noms = await _selecNomClient.getByParendKey(parentKey);
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }


}
