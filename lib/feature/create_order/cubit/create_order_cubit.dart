import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/config/config_repo/config_repo.dart';
import 'package:mobi_c/common/func.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/services/data_sync_service/models/order.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this._createOrderRepo) : super(CreateOrderState());

  final CreateOrderRepo _createOrderRepo;

  void createOrderId() {
    emit(state.copyWith(orderId: DateTime.now().millisecondsSinceEpoch));
  }

  Future<void> selectCounterparty(Counterparty counterparty) async {
    emit(state.copyWith(order: state.order.copyWith(contractKey: '')));

    emit(state.copyWith(
        counterparty: counterparty,
        order: state.order.copyWith(
            counterpartyKey: counterparty.refKey,
            partnerKey: counterparty.refKey)));
    await getContracts(counterparty.refKey);
    await getDiscount(state.contracts.first.refKey);
  }

  void selectDatetime(DateTime? date) {
    final order = state.order.copyWith(date: date);
    emit(state.copyWith(order: order));
  }

  Future<void> getContracts(String ownerKey) async {
    try {
      final contracts = await _createOrderRepo.getContracts(ownerKey);
      emit(state.copyWith(
          order: state.order.copyWith(
            contractKey: contracts.first.refKey,),
          contracts: contracts,
          status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> getDiscount(String discountRecipient) async {
    try {
      final discount = await _createOrderRepo.getDiscount(discountRecipient);
      emit(state.copyWith(
          discount: discount, status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  void changeContract(String contractKey) {
    emit(state.copyWith(order: state.order.copyWith(contractKey: contractKey)));
  }

  Future<void> getNoms() async {
    try {
      final noms = await _createOrderRepo.getNoms(state.orderId);
      emit(state.copyWith(noms: noms, status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> insertNom(Nom nom, String qty, Unit unit) async {
    try {
      await _createOrderRepo.insertNom(OrderNom(
          orderId: state.orderId,
          ref: nom.ref,
          description: nom.description,
          article: nom.article,
          imageKey: nom.imageKey,
          unitKey: unit.refKey,
          qty: int.parse(qty),
          price: nom.price,
          ratio: unit.ratio,
          unitName: unit.description));
      await getNoms();
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> deleteNom(int id) async {
    try {
      await _createOrderRepo.deleteNom(id);
      await getNoms();
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> updateNom(OrderNom nom, String qty, Unit unit) async {
    try {
      await _createOrderRepo.updateNom(OrderNom(
          id: nom.id,
          orderId: state.orderId,
          ref: nom.ref,
          description: nom.description,
          article: nom.article,
          imageKey: nom.imageKey,
          unitKey: nom.unitKey,
          qty: int.parse(qty),
          price: nom.price,
          ratio: unit.ratio,
          unitName: unit.description));
      await getNoms();
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> createOrder() async {
    try {
      emit(state.copyWith(status: CreateOrderStatus.loading));
      List<Map<String, dynamic>> products = [];
      int number = 1;
      for (final nom in state.noms) {
        products.add(nom.toJson(
            number, Config.storageKey, state.discount.percentDiscounts));
        number++;
      }
      await _createOrderRepo.createOrder(state.order.toJson(products));
      emit(state.copyWith(status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  void writeComment(String comment) {
    emit(state.copyWith(order: state.order.copyWith(comment: comment)));
  }

  Future<void> getUnits(String nomKey, String nomUnit) async {
    try {
      emit(state.copyWith(status: CreateOrderStatus.loading));
      final units = await _createOrderRepo.getUnits(nomKey);
      final selectedUnit = units.firstWhere((e) => e.classifierKey == nomUnit);
      emit(state.copyWith(
          units: units,
          selectedUnit: selectedUnit,
          status: CreateOrderStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreateOrderStatus.failure, errorMessage: e.toString()));
    }
  }

  selectUnit(String unitClassificatorKey) {
    final selectedUnit =
        state.units.firstWhere((e) => e.classifierKey == unitClassificatorKey);
    emit(state.copyWith(selectedUnit: selectedUnit));
  }

  changePickup() {
    emit(state.copyWith(
        order: state.order.copyWith(pickup: !state.order.pickup)));
  }
}
