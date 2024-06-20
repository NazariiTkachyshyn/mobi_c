import 'package:get_it/get_it.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class SettingsClient {
  final _store = GetIt.I.get<Store>();

  Future<List<Counterparty>> getFolders() async {
    try {
      final query = _store
          .box<Counterparty>()
          .query(Counterparty_.isFolder.equals(true))
          .build();
      return query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ClientRoute>> getRoutes() async {
    try {
      final query = _store.box<ClientRoute>().query().build();
      return query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertRoute(ClientRoute route) async {
    try {
      await _store.box<ClientRoute>().putAsync(route);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteRoute(int id) async {
    try {
      await _store.box<ClientRoute>().removeAsync(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
