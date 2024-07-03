import 'package:get_it/get_it.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

class InputQtyUnitClient {
  final _store = GetIt.I.get<Store>();

  Future<List<Unit>> getUnits(String nomKey) async {
    try {
      return await _store
          .box<Unit>()
          .query(Unit_.owner.equals(nomKey))
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }
}
