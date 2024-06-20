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
      final dbCount = _dbClient.getNomsCount();
      final apiCount = await _apiClient.getCount(
          'InformationRegister_МобільнийКлієнтЗалишки/\$count?\$select=Ref_Key');
      if (!validator.needsUpdated(apiCount, dbCount)) {
        return 0;
      }

      final dbData = await _dbClient.getAllNoms();
      final apiData = await _apiClient.getAllNoms();

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
      final dbCount = _dbClient.getContractsCount();
      final apiCount = await _apiClient
          .getCount('Catalog_ДоговорыКонтрагентов/\$count?\$select=Ref_Key');
      if (!validator.needsUpdated(apiCount, dbCount)) {
        return 0;
      }

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
      final dbCount = _dbClient.getCounterpartysCount();
      final apiCount = await _apiClient
          .getCount('Catalog_Контрагенты/\$count?\$select=Ref_Key&\$filter=DeletionMark eq false');
      if (!(validator.needsUpdated(apiCount, dbCount))) {
        return 0;
      }

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
      final dbCount = _dbClient.getDiscountsCount();
      final apiCount = await _apiClient.getCount(
          'InformationRegister_СкидкиНаценкиНоменклатуры_RecordType/SliceLast/\$count?\$select=Номенклатура_Key&\$filter=Active eq true');
      if (validator.needsUpdated(apiCount, dbCount) == false) {
        return 0;
      }

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
      final dbCount = _dbClient.getUnitsCount();
      final apiCount = await _apiClient
          .getCount('Catalog_ЕдиницыИзмерения/\$count?\$select=Ref_Key');
      if (!validator.needsUpdated(apiCount, dbCount)) {
        return 0;
      }

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
