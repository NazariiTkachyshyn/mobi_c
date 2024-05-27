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
      this.date,
      this.errorMassage = '',
      this.noms = const [],
      Counterparty? counterparty})
      : counterparty = counterparty ?? Counterparty.empty;

  final CreateOrderStatus status;
  final int orderId;
  final Counterparty counterparty;
  final DateTime? date;
  final String errorMassage;
  final List<OrderNom> noms;

  CreateOrderState copyWith(
      {CreateOrderStatus? status,
      int? orderId,
      String? errorMassage,
      DateTime? date,
      Counterparty? counterparty,
      List<OrderNom>? noms}) {
    return CreateOrderState(
        status: status ?? this.status,
        orderId: orderId ?? this.orderId,
        date: date ?? this.date,
        errorMassage: errorMassage ?? this.errorMassage,
        counterparty: counterparty ?? this.counterparty,
        noms: noms ?? this.noms);
  }

  @override
  List<Object?> get props =>
      [status, orderId, errorMassage, counterparty, date, noms];
}
