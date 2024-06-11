import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/objectbox.g.dart';

class DataSyncDbClient {
  final Store _store;

  DataSyncDbClient({required Store store}) : _store = store;

  //^----------NOMENKLATURA----------------
  List<Nom> getAllNoms() {
    try {
      return _store.box<Nom>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNom(List<Nom> noms, Box box) async {
    try {
      _store.box<Nom>().putMany(noms);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------PRICES----------------
  List<Price> getAllPrices() {
    try {
      return _store.box<Price>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setPrice(List<Price> prices, Box box) async {
    try {
      _store.box<Price>().putMany(prices);
    } catch (e) {
      throw Exception(e);
    }
  }

  // //^----------STORAGES----------------
  List<Storage> getAllStorages() {
    try {
      return _store.box<Storage>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setStorage(List<Storage> storages, Box box) async {
    try {
      _store.box<Storage>().putMany(storages);
    } catch (e) {
      throw Exception(e);
    }
  }

  // //^----------BARCODES----------------
  List<Barcode> getAllBarcodes() {
    try {
      return _store.box<Barcode>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setBarcode(List<Barcode> barcodes, Box box) async {
    try {
      _store.box<Barcode>().putMany(barcodes);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------CONTRACT----------------
  List<Contract> getAllContract() {
    try {
      return _store.box<Contract>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setContract(List<Contract> contracts, Box box) async {
    try {
      _store.box<Contract>().putMany(contracts);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------Counterparty----------------
  List<Counterparty> getAllCounterparty() {
    try {
      return _store.box<Counterparty>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setCounterparty(List<Counterparty> counterpartys, Box box) async {
    try {
      _store.box<Counterparty>().putMany(counterpartys);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------DISCOUNT----------------
  List<Discount> getAllDiscount() {
    try {
      return _store.box<Discount>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setDiscount(List<Discount> discounts, Box box) async {
    try {
      _store.box<Discount>().putMany(discounts);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------Unit----------------
  List<Unit> getAllUnit() {
    try {
      return _store.box<Unit>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setUnit(List<Unit> units, Box box) async {
    try {
      _store.box<Unit>().putMany(units);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------UnitClassificator----------------
  List<UnitClassificator> getAllUnitClassificator() {
    try {
      return _store.box<UnitClassificator>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setUnitClassificator(List<UnitClassificator> unitClassificators, Box box) async {
    try {
      _store.box<UnitClassificator>().putMany(unitClassificators);
    } catch (e) {
      throw Exception(e);
    }
  }
}
