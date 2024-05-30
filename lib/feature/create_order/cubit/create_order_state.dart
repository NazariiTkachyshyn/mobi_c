part of 'create_order_cubit.dart';

enum CreateOrderStatus {
  initial,
  loading,
  success,
  failure,
}

extension CreateStorageStatusX on CreateOrderStatus {
  bool get isInitial => this == CreateOrderStatus.initial;
  bool get isLoading => this == CreateOrderStatus.loading;
  bool get isSuccess => this == CreateOrderStatus.success;
  bool get isFailure => this == CreateOrderStatus.failure;
}

final class CreateOrderState extends Equatable {
  const CreateOrderState(
      {this.status = CreateOrderStatus.initial,
      this.orderId = 0,
      this.errorMassage = '',
      this.noms = const [],
      this.coment = '',
      Order? order,
      Counterparty? counterparty})
      : counterparty = counterparty ?? Counterparty.empty,
        order = order ?? Order.empty;

  final CreateOrderStatus status;
  final int orderId;
  final Counterparty counterparty;
  final Order order;
  final String errorMassage;
  final List<OrderNom> noms;
  final String coment;

  double get summ => noms.fold(0, (a, b) => a + b.price);
  int get totalSumm => noms.fold(0, (a, b) => a + b.qty);

  CreateOrderState copyWith(
      {CreateOrderStatus? status,
      int? orderId,
      Order? order,
      String? errorMassage,
      Counterparty? counterparty,
      List<OrderNom>? noms}) {
    return CreateOrderState(
        status: status ?? this.status,
        order: order ?? this.order,
        orderId: orderId ?? this.orderId,
        errorMassage: errorMassage ?? this.errorMassage,
        counterparty: counterparty ?? this.counterparty,
        noms: noms ?? this.noms);
  }

  @override
  List<Object?> get props =>
      [status, orderId, errorMassage, counterparty, noms, order];
}

