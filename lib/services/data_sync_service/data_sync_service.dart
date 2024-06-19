import 'dart:io';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_sync_service/clients/api_client.dart';
import 'package:mobi_c/services/data_sync_service/clients/object_box_client.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

import 'validator.dart';
import 'updater.dart';

class DataSyncService {
  final DataSyncApiClient _apiClient = DataSyncApiClient();
  final DataSyncObjectBoxClient _dbClient =
      DataSyncObjectBoxClient(store: GetIt.I.get<Store>());
  final Validator validator = Validator();
  final Updater updater =
      Updater(dbService: DataSyncObjectBoxClient(store: GetIt.I.get<Store>()));

  DataSyncService();

  Future<int> syncNomData() async {
    try {
      final dbData = await _dbClient.getAllNoms();
      final apiData = await _apiClient.getAllNom();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater.updateNoms(validationResult.updatedData);
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> syncContractData() async {
    try {
      final dbData = await _dbClient.getAllContract();
      final apiData = await _apiClient.getAllContract();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater.updateContract(validationResult.updatedData);
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> syncCounterpartyData() async {
    try {
      final dbData = await _dbClient.getAllCounterparty();
      final apiData = await _apiClient.getAllCounterparty();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater.updateCounterparty(validationResult.updatedData);
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> syncDiscountData() async {
    try {
      final dbData = await _dbClient.getAllDiscount();
      final apiData = await _apiClient.getAllDiscount();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater.updateDiscount(validationResult.updatedData);
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> syncUnitData() async {
    try {
      final dbData = await _dbClient.getAllUnit();
      final apiData = await _apiClient.getAllUnit();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater.updateUnit(validationResult.updatedData);
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 2;
    }
  }

  deleteAll() async => _dbClient.deleteAll();

  Future<void> downloadImage() async {
    final directory = GetIt.I.get<Directory>();
    final noms = await _dbClient.getAllNomsByStorage();

    for (var nom in noms) {
      final jpg = await _apiClient.getAllImage(nom.ref);
      if (jpg.isEmpty) continue;
      final path = '${directory.path}/${nom.ref}.jpg';
      final file = File(path);
      await file.writeAsBytes(jpg);
    }
  }
}
