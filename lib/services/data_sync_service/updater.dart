import 'package:mobi_c/common/constants/table_named.dart';
import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/services/data_sync_service/clients/sql_client.dart';

class Updater {
  final DataSyncDbClient dbService;

  Updater({required this.dbService});

  Future<void> updateNoms(Set<ApiNom> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableNoms);
  }

  Future<void> updatePrices(Set<ApiPrice> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tablePrices);
  }

  // Future<void> updateStoragesOb(Set<Storage> storages) async {
  //   dbService.setNewStorages(storages);
  // }

  // Future<void> updateBarcodesOb(Set<Barcode> barcodes) async {
  //   dbService.setNewBarcodes(barcodes);
  // }

  Future<void> updateCounterparty(Set<ApiCounterparty> data) async {
    dbService.setNewRows(
        data.map((e) => e.toJson()).toList(), tableCounterparty);
  }

  Future<void> updateContract(Set<ApiContract> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableContract);
  }

  Future<void> updateDiscount(Set<ApiDiscount> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableDiscount);
  }

  Future<void> updateUnit(Set<ApiUnit> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableUnit);

  }
    Future<void> updateUnitClassificator(Set<ApiUnitClassifier> data) async {
    dbService.setNewRows(data.map((e) => e.toJson()).toList(), tableUnitClassificator);
  }
}
