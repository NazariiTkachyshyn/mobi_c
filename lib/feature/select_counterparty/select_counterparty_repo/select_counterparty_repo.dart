import 'package:mobi_c/feature/select_counterparty/select_counterparty_client/select_counterparty_client.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

abstract interface class SelectCounterpartyRepo {
  Future<List<Counterparty>> getByParentKey(String parentKey, int offset);

  Future<List<Counterparty>> searchInFolder(String value, String parentKey);

  Future<List<Counterparty>> getFolders();

  Future<List<ClientRoute>> getRoutes();
}

class SelectCounterpartyRepoImpl implements SelectCounterpartyRepo {
  final SelectCounterpartyClient _selectCounterpartyClient;

  SelectCounterpartyRepoImpl(
      {required SelectCounterpartyClient selectCounterpartyClient})
      : _selectCounterpartyClient = selectCounterpartyClient;

  @override
  Future<List<Counterparty>> getFolders() async {
    try {
      return await _selectCounterpartyClient.getFolders();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Counterparty>> getByParentKey(
      String parentKey, int offset) async {
    try {
      return await _selectCounterpartyClient.getByParentKey(parentKey, offset);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Counterparty>> searchInFolder(
      String value, String parentKey) async {
    try {
      return await _selectCounterpartyClient.searchInFolder(value, parentKey);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ClientRoute>> getRoutes() async {
    try {
      return await _selectCounterpartyClient.getRoutes();
    } catch (e) {
      throw Exception(e);
    }
  }
}
