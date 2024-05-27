import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_sync_service/clients/api_client.dart';
import 'package:mobi_c/services/data_sync_service/clients/db_client.dart';
import 'package:get_it/get_it.dart';

import 'validator.dart';
import 'updater.dart';

class DataSyncService {
  final DataSyncApiClient _apiClient = DataSyncApiClient();
  final DataSyncDbClient _dbClient =
      DataSyncDbClient(store: GetIt.I.get<Store>());
  final Validator validator = Validator();
  final Updater updater =
      Updater(dbService: DataSyncDbClient(store: GetIt.I.get<Store>()));

  DataSyncService();

  Future<int> syncNomData() async {
    try {
      final dbData = _dbClient.getAllNoms();
      final apiData = await _apiClient.getAllNom();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateNomsOb(validationResult.updatedData)
            .whenComplete(() => print('Nom updated'));
        return 1;
      } else {
        print('Nom is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }

  Future<int> syncPriceData() async {
    try {
      final dbData = _dbClient.getAllPrices();
      final apiData = await _apiClient.getAllPrices();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updatePricesOb(validationResult.updatedData)
            .whenComplete(() => print('Price updated'));
        return 1;
      } else {
        print('Price is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }

  Future<int> syncStoragesData() async {
    try {
      final dbData = _dbClient.getAllStorages();
      final apiData = await _apiClient.getAllStorages();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateStoragesOb(validationResult.updatedData)
            .whenComplete(() => print('Storages updated'));
        return 1;
      } else {
        print('Storages is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }

  Future<int> syncBarcodesData() async {
    try {
      final dbData = _dbClient.getAllBarcodes();
      final apiData = await _apiClient.getAllBarcodes();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateBarcodesOb(validationResult.updatedData)
            .whenComplete(() => print('Barcodes updated'));
        return 1;
      } else {
        print('Barcodes is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }

  Future<int> syncCounterpartyData() async {
    try {
      final dbData = _dbClient.getAllCounterparty();
      final apiData = await _apiClient.getAllCounterparty();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateCounterpartyOb(validationResult.updatedData)
            .whenComplete(() => print('Counterparty updated'));
        return 1;
      } else {
        print('Counterparty is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }
}
