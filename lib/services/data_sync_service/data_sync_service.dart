import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ftpconnect/ftpconnect.dart';
import 'package:mobi_c/services/data_bases/object_box/models/image.dart';
import 'package:mobi_c/services/data_sync_service/clients/api_client.dart';
import 'package:mobi_c/services/data_sync_service/clients/object_box_client.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/services/data_sync_service/image_formater/image_formater.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

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
        await updater
            .updateNoms(validationResult.updatedData)
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

//   Future<int> syncStoragesData() async {
//     try {
//       final dbData = _dbClient.getAllStorages();
//       final apiData = await _apiClient.getAllStorages();

//       final validationResult = validator.validate(apiData, dbData);

//       if (validationResult.needsUpdate) {
//         await updater
//             .updateStoragesOb(validationResult.updatedData)
//             .whenComplete(() => print('Storages updated'));
//         return 1;
//       } else {
//         print('Storages is already up to date.');
//         return 0;
//       }
//     } catch (e) {
//       print('Error during data sync: $e');
//       return 2;
//     }
//   }

//   Future<int> syncBarcodesData() async {
//     try {
//       final dbData = _dbClient.getAllBarcodes();
//       final apiData = await _apiClient.getAllBarcodes();

//       final validationResult = validator.validate(apiData, dbData);

//       if (validationResult.needsUpdate) {
//         await updater
//             .updateBarcodesOb(validationResult.updatedData)
//             .whenComplete(() => print('Barcodes updated'));
//         return 1;
//       } else {
//         print('Barcodes is already up to date.');
//         return 0;
//       }
//     } catch (e) {
//       print('Error during data sync: $e');
//       return 2;
//     }
//   }

  Future<int> syncContractData() async {
    try {
      final dbData = await _dbClient.getAllContract();
      final apiData = await _apiClient.getAllContract();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateContract(validationResult.updatedData)
            .whenComplete(() => print('Contract updated'));
        return 1;
      } else {
        print('Contract is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }

  Future<int> syncCounterpartyData() async {
    try {
      final dbData = await _dbClient.getAllCounterparty();
      final apiData = await _apiClient.getAllCounterparty();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateCounterparty(validationResult.updatedData)
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

  Future<int> syncDiscountData() async {
    try {
      final dbData = await _dbClient.getAllDiscount();
      final apiData = await _apiClient.getAllDiscount();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateDiscount(validationResult.updatedData)
            .whenComplete(() => print('Discount updated'));
        return 1;
      } else {
        print('Discount is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }

  Future<int> syncUnitData() async {
    try {
      final dbData = await _dbClient.getAllUnit();
      final apiData = await _apiClient.getAllUnit();

      final validationResult = validator.validate(apiData, dbData);

      if (validationResult.needsUpdate) {
        await updater
            .updateUnit(validationResult.updatedData)
            .whenComplete(() => print('Unit updated'));
        return 1;
      } else {
        print('Unit is already up to date.');
        return 0;
      }
    } catch (e) {
      print('Error during data sync: $e');
      return 2;
    }
  }

  Future<void> downloadImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageDir = Directory("${directory.path}/images");

      final files = imageDir.listSync(recursive: true, followLinks: false);
      final imageCount = files.length;

      final ftpConn = FTPConnect('virftpap.ftp.tools',
          user: 'virftpap_test', pass: 'TEST2024TEST',);
      final a = await ftpConn.connect();
     final d = await ftpConn.downloadDirectory('images', imageDir);
      print(d);

      // final imagesRes = await _apiClient.getAllImage();

      // for (var i in imagesRes) {
      //   c(i['image'], i['ref']);
      // }
    } catch (e) {
      print('Error during data sync: $e');
    }
  }
}

Future<void> c(String base64Data, String fileName) async {
  final bytes = await ImageFormater()
      .compressBites(ImageFormater().base64ToBites(base64Data));
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/images/$fileName';
  final file = File(path);
  await file.writeAsBytes(bytes);
  print('File saved at $path');
}
