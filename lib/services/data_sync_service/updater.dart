import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/services/data_sync_service/clients/db_client.dart';

class Updater {
  final DataSyncDbClient dbService;

  Updater({required this.dbService});

  Future<void> updateNoms(Set<Nom> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), 'noms');
  }

  Future<void> updatePricesOb(Set<Price> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), 'prices');
  }

  // Future<void> updateStoragesOb(Set<Storage> storages) async {
  //   dbService.setNewStorages(storages);
  // }

  // Future<void> updateBarcodesOb(Set<Barcode> barcodes) async {
  //   dbService.setNewBarcodes(barcodes);
  // }

  Future<void> updateCounterpartyOb(Set<Counterparty> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), 'counterparty');
  }
}
