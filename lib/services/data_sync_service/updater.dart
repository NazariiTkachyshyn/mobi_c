import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:mobi_c/services/data_bases/object_box/models/contract.dart';
import 'package:mobi_c/services/data_bases/object_box/models/counterparty.dart';
import 'package:mobi_c/services/data_bases/object_box/models/discount.dart';
import 'package:mobi_c/services/data_bases/object_box/models/nom.dart';
import 'package:mobi_c/services/data_bases/object_box/models/unit.dart';
import 'package:mobi_c/services/data_sync_service/clients/object_box_client.dart';

class Updater {
  final DataSyncObjectBoxClient dbService;

  Updater({required this.dbService});

  Future<void> updateNoms(Set<SyncNom> data) async {
    dbService.setNom(
      data.map((e) => Nom.fromApi(e)).toList(),
    );
  }



  // Future<void> updateStoragesOb(Set<Storage> storages) async {
  //   dbService.setNewStorages(storages);
  // }

  // Future<void> updateBarcodesOb(Set<Barcode> barcodes) async {
  //   dbService.setNewBarcodes(barcodes);
  // }

  Future<void> updateCounterparty(Set<SyncCounterparty> data) async {
    dbService.setCounterparty(
      data.map((e) => Counterparty.fromApi(e)).toList(),
    );
  }

  Future<void> updateContract(Set<SyncContract> data) async {
    dbService.setContract(
      data.map((e) => Contract.fromApi(e)).toList(),
    );
  }

  Future<void> updateDiscount(Set<SyncDiscount> data) async {
    dbService.setDiscount(
      data.map((e) => Discount.fromApi(e)).toList(),
    );
  }

  Future<void> updateUnit(Set<SyncUnit> data) async {
    dbService.setUnit(
      data.map((e) => Unit.fromApi(e)).toList(),
    );
  }

}
