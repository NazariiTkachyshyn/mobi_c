import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mobi_c/common/func.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/repository/config_repo/config_repo.dart';
import 'package:mobi_c/services/data_sync_service/models/order.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';
import 'package:http/http.dart' as http;
part 'create_pko_state.dart';

class CreatePKOCubit extends Cubit<CreatePKOState> {
  CreatePKOCubit(this._createOrderRepo)
      : super(CreatePKOState(selectedDate: DateTime(1), contractKey: ''));

  final CreateOrderRepo _createOrderRepo;

  void selectDatetime(DateTime? date) {
    emit(state.copyWith(selectedDate: date));
  }

  // Methods to update the state
  void updateDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> selectCounterparty(Counterparty counterparty) async {
    emit(state.copyWith(contractKey: ''));

    emit(state.copyWith(
        counterparty: counterparty,
        order: state.order.copyWith(
            counterpartyKey: counterparty.refKey,
            partnerKey: counterparty.refKey)));
    await getContracts(counterparty.refKey);
    print(state.contracts);
    await getDiscount(state.contracts.first.refKey);
  }

  Future<void> getContracts(String ownerKey) async {
    try {
      final contracts = await _createOrderRepo.getContracts(ownerKey);
      emit(state.copyWith(
          order: state.order.copyWith(
            contractKey: contracts.first.refKey,
          ),
          contracts: contracts,
          status: CreatePKOStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreatePKOStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> getDiscount(String discountRecipient) async {
    try {
      final discount = await _createOrderRepo.getDiscount(discountRecipient);
      emit(state.copyWith(discount: discount, status: CreatePKOStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreatePKOStatus.failure, errorMessage: e.toString()));
    }
  }

  void changeContract(String contractKey) {
    emit(state.copyWith(order: state.order.copyWith(contractKey: contractKey)));
  }

  void setSum(double value) {
    emit(state.copyWith(sum: value));
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return formatter.format(dateTime);
  }

  Map<String, dynamic> toJson() {
    return {
      "Date": state.selectedDate!.toIso8601String(),
      "Организация_Key": Config.organizationKey,
      "СуммаДокумента": state.sum.toString(),
      "Касса_Key": "c5f03dd7-224c-11ee-b91b-3ca82a229d6f",
      "Комментарий": state.comment,
    };
  }

  Future<void> sendPostRequest() async {
    final url = Uri.parse(
        'http://192.168.2.50:81/virok_kup/odata/standard.odata/Document_ПриходныйКассовыйОрдер?\$top=2&\$format=json');
    final headers = {
      'Authorization': Config.basicAuth,
    };
    final body = jsonEncode(toJson());

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      print('Запит успішний!');
      print(response.body);
    } else {
      print('Запит не вдався: ${response.statusCode}');
      print(response.body);
    }
  }
}
