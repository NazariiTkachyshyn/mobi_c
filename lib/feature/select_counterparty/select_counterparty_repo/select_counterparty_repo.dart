import '../../../models/models.dart';
import '../select_counterparty_client/select_counterparty_client.dart';

abstract interface class SelectCounterpartyRepo {
  Future<List<Counterparty>> getCounterpartys(String value);

  Future<List<Counterparty>> getAll();
}

class SelectCounterpartyRepoImpl implements SelectCounterpartyRepo {
  final SelectCounterpartyClient _selectCounterpartyClient;

  SelectCounterpartyRepoImpl(
      {required SelectCounterpartyClient selectCounterpartyClient})
      : _selectCounterpartyClient = selectCounterpartyClient;

  @override
  Future<List<Counterparty>> getAll() async {
    try {
      return await _selectCounterpartyClient.getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Counterparty>> getCounterpartys(String value) async {
    try {
      return await _selectCounterpartyClient.getCounterpartys(value);
    } catch (e) {
      throw Exception(e);
    }
  }
}
