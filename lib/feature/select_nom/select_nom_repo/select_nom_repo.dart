import 'package:mobi_c/services/data_bases/object_box/models/image.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import '../select_nom_client/select_nom_client.dart';

abstract interface class SelectNomRepo {
  Future<List<Nom>> getNomsByParentKey(String parentKey);

  Future<List<Nom>> getFolders();

  Future<List<Nom>> getByDescription(String value);

  Future<List<Nom>> searchNomsInFolder(String value, String parentKey);

  Future<List<ImageOb>> getImage(String ref);
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
  Future<List<Nom>> getNomsByParentKey(String parentKey) async {
    try {
      final noms = await _selecNomClient.getByParendKey(parentKey);
      return noms;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Nom>> getByDescription(String value) async {
    try {
      final noms = await _selecNomClient.getByDescription(value);
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
  Future<List<ImageOb>> getImage(String ref) async {
    try {
      final images = await _selecNomClient.getImage(ref);
      return images;
    } catch (e) {
      throw Exception(e);
    }
  }
}
