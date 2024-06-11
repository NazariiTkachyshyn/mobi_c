import '../../../models/models.dart';
import '../select_counterparty_client/select_counterparty_client.dart';

abstract interface class SelectCounterpartyRepo {
  Future<List<ApiCounterparty>> getCounterpartys(String value);

  Future<List<ApiCounterparty>> getAll();
}

class SelectCounterpartyRepoImpl implements SelectCounterpartyRepo {
  final SelectCounterpartyClient _selectCounterpartyClient;

  SelectCounterpartyRepoImpl(
      {required SelectCounterpartyClient selectCounterpartyClient})
      : _selectCounterpartyClient = selectCounterpartyClient;

  @override
  Future<List<ApiCounterparty>> getAll() async {
    try {
      return await _selectCounterpartyClient.getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ApiCounterparty>> getCounterpartys(String value) async {
    try {
      return await _selectCounterpartyClient.getCounterpartys(value);
    } catch (e) {
      throw Exception(e);
    }
  }
}
