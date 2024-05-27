import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/services/data_sync_service/clients/db_client.dart';

class Updater {
  final DataSyncDbClient dbService;

  Updater({required this.dbService});

  Future<void> updateNomsOb(Set<Nom> noms) async {
    dbService.setNewNoms(noms);
  }

  Future<void> updatePricesOb(Set<Price> prices) async {
    dbService.setNewPrices(prices);
  }

  Future<void> updateStoragesOb(Set<Storage> storages) async {
    dbService.setNewStorages(storages);
  }

  Future<void> updateBarcodesOb(Set<Barcode> barcodes) async {
    dbService.setNewBarcodes(barcodes);
  }

  Future<void> updateCounterpartyOb(Set<Counterparty> counterparty) async {
    dbService.setNewCounterparty(counterparty);
  }
}
