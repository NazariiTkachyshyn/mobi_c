import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/models/order.dart';

import '../../../models/models.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this._createOrderRepo) : super(const CreateOrderState());

  final CreateOrderRepo _createOrderRepo;

  createOrderId() {
    emit(state.copyWith(orderId: DateTime.now().millisecondsSinceEpoch));
  }

  selectCounterparty(Counterparty counterparty) async {
    await getContracts(counterparty.refKey);
    await getDiscount(state.contracts.first.refKey);
    emit(state.copyWith(
        counterparty: counterparty,
        order: state.order.copyWith(
          contractKey: state.contracts.first.refKey,
            counterpartyKey: counterparty.refKey,
            partnerKey: counterparty.refKey)));
  }

  selectDatetime(DateTime? date) {
    final order = state.order.copyWith(date: date);
    emit(state.copyWith(order: order));
    state;
  }

  Future<void> getContracts(String ownerKey) async {
    try {
      final contracts = await _createOrderRepo.getContracts(ownerKey);
      emit(state.copyWith(
          contracts: contracts, status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateOrderStatus.failure));
    }
  }

  Future<void> getDiscount(String discountRecipient) async {
    try {
      final discount = await _createOrderRepo.getDiscount(discountRecipient);
      emit(state.copyWith(
          discount: discount, status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateOrderStatus.failure));
    }
  }

  Future<void> getNoms() async {
    try {
      final noms = await _createOrderRepo.getNoms(state.orderId);
      emit(state.copyWith(noms: noms, status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateOrderStatus.failure));
    }
  }

  Future<void> insertNom(Nom nom) async {
    try {
      await _createOrderRepo.insertNom(
          OrderNom.fromNom(nom, state.orderId), state.orderId);
      await getNoms();
    } catch (e) {
      emit(state.copyWith(status: CreateOrderStatus.failure));
    }
  }

  Future<void> deleteNom(int id) async {
    try {
      await _createOrderRepo.deleteNom(id);
      await getNoms();
    } catch (e) {
      emit(state.copyWith(status: CreateOrderStatus.failure));
    }
  }

  Future<void> changeQty(OrderNom nom, String qty) async {
    try {
      await _createOrderRepo.updateNom(nom.id, int.parse(qty));
      await getNoms();
    } catch (e) {
      emit(state.copyWith(status: CreateOrderStatus.failure));
    }
  }

  Future<void> createOrder() async {
    try {
      List<Map<String, dynamic>> products = [];
      int number = 1;
      for (final nom in state.noms) {
        products.add(nom.toJson(number, KeyConst.storageKey));
        number++;
      }
      await _createOrderRepo.createOrder(state.order.toJson(products));
    } catch (e) {}
  }
}
