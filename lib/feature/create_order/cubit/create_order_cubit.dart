import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';

import '../../../models/models.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this._createOrderRepo) : super(const CreateOrderState());

  final CreateOrderRepo _createOrderRepo;

  createOrderId() {
    emit(state.copyWith(orderId: DateTime.now().millisecondsSinceEpoch));
  }

  selectCounterparty(Counterparty counterparty) {
    emit(state.copyWith(counterparty: counterparty));
  }

  selectDatetime(DateTime? date) {
    emit(state.copyWith(date: date));
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
      await _createOrderRepo.insertNom(OrderNom(
          id: 0,
          orderId: state.orderId,
          ref: nom.ref,
          description: nom.description,
          article: nom.article,
          imageKey: nom.imageKey,
          unitKey: nom.unitKey,
          qty: 1,
          price: (Random().nextInt(900) + 100).toDouble()));
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
      await _createOrderRepo.updateNom(nom.copyWith(qty: int.parse(qty)));
      await getNoms();
    } catch (e) {
      emit(state.copyWith(status: CreateOrderStatus.failure));
    }
  }
}
