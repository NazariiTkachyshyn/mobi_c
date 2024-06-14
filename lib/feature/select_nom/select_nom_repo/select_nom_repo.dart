import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  Future<List<Nom>> getNomsByParentKey(String parentKey, int offset);

  Future<List<Nom>> getFolders();


  Future<List<Nom>> searchNomsInFolder(String value, String parentKey);

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


}
