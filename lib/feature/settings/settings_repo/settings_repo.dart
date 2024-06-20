import 'package:mobi_c/feature/settings/settings_client/settings_client.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

abstract interface class SettingsRepo {
  Future<List<Counterparty>> getFolders();

  Future<List<ClientRoute>> getRoutes();

  Future<void> insertRoute(ClientRoute route);

  Future<void> deleteRoute(int id);
}

class SettingsRepoImpl implements SettingsRepo {
  final SettingsClient _settingsClient;

  SettingsRepoImpl({required SettingsClient settingsClient})
      : _settingsClient = settingsClient;

  @override
  Future<List<Counterparty>> getFolders() async {
    try {
      return await _settingsClient.getFolders();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteRoute(int id) async {
    try {
      await _settingsClient.deleteRoute(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ClientRoute>> getRoutes() async {
    try {
      return await _settingsClient.getRoutes();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> insertRoute(ClientRoute route) async {
    try {
      await _settingsClient.insertRoute(route);
    } catch (e) {
      throw Exception(e);
    }
  }
}
