import '../../../models/models.dart';
import '../select_counterparty_client/select_counterparty_client.dart';

abstract interface class SelectCounterpartyRepo {
  Future<List<Counterparty>> getCounterpartys(String value);
  Future<List<Counterparty>> getCounterpartysByParentKey(String parentKey);

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
      final obCounterpartys = await _selectCounterpartyClient.getAll();
      return obCounterpartys
          .map((e) => Counterparty.fromObCounterparty(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Counterparty>> getCounterpartys(String value) async {
    try {
      final obCounterpartys =
          await _selectCounterpartyClient.getCounterpartys(value);
      return obCounterpartys
          .map((e) => Counterparty.fromObCounterparty(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Counterparty>> getCounterpartysByParentKey(
      String parentKey) async {
    try {
      final obCounterpartys =
          await _selectCounterpartyClient.getByParendKey(parentKey);
      return obCounterpartys
          .map((e) => Counterparty.fromObCounterparty(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
