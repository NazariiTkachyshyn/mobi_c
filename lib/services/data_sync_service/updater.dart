import 'package:mobi_c/common/constants/table_named.dart';
import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/services/data_sync_service/clients/db_client.dart';

class Updater {
  final DataSyncDbClient dbService;

  Updater({required this.dbService});

  Future<void> updateNoms(Set<Nom> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableNoms);
  }

  Future<void> updatePrices(Set<Price> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tablePrices);
  }

  // Future<void> updateStoragesOb(Set<Storage> storages) async {
  //   dbService.setNewStorages(storages);
  // }

  // Future<void> updateBarcodesOb(Set<Barcode> barcodes) async {
  //   dbService.setNewBarcodes(barcodes);
  // }

  Future<void> updateCounterparty(Set<Counterparty> data) async {
    dbService.setNewRows(
        data.map((e) => e.toJson()).toList(), tableCounterparty);
  }

  Future<void> updateContract(Set<Contract> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableContract);
  }

  Future<void> updateDiscount(Set<Discount> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableDiscount);
  }

  Future<void> updateUnit(Set<Unit> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableUnit);

  }
    Future<void> updateUnitClassificator(Set<UnitClassificator> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableUnitClassificator);
  }
}
