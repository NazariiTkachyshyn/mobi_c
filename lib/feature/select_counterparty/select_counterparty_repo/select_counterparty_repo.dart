import 'package:mobi_c/feature/select_counterparty/select_counterparty_client/select_counterparty_client.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

abstract interface class SelectCounterpartyRepo {
  Future<List<Counterparty>> getCounterpartys(String value);

}

class SelectCounterpartyRepoImpl implements SelectCounterpartyRepo {
  final SelectCounterpartyClient _selectCounterpartyClient;

  SelectCounterpartyRepoImpl(
      {required SelectCounterpartyClient selectCounterpartyClient})
      : _selectCounterpartyClient = selectCounterpartyClient;



  @override
  Future<List<Counterparty>> getCounterpartys(String value) async {
    try {
      return await _selectCounterpartyClient.getCounterpartys(value);
    } catch (e) {
      throw Exception(e);
    }
  }
}
