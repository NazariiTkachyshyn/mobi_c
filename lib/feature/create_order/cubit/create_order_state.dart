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
   CreateOrderState({
    this.status = CreateOrderStatus.initial,
    this.orderId = 0,
    this.errorMessage = '',
    this.noms = const [],
    this.contracts = const [],
    this.units = const [],
    this.selectedUnit = ApiUnit.empty,
    ApiDiscount? discount,
    ApiOrder? order,
    Counterparty? counterparty,
  })  : counterparty = counterparty ?? Counterparty.empty,
        order = order ?? ApiOrder.empty,
        discount = discount ?? ApiDiscount.empty;

  final CreateOrderStatus status;
  final int orderId;
  final Counterparty counterparty;
  final ApiOrder order;
  final String errorMessage;
  final List<ApiOrderNom> noms;
  final List<ApiContract> contracts;
  final ApiDiscount discount;
  final List<ApiUnit> units;
  final ApiUnit selectedUnit;

  double get discountedSumm =>
      noms.fold(0, (a, b) => a + b.calcDiscount(discount.percentDiscounts));

  double get summ => noms.fold(0, (a, b) => a + b.price);
  int get totalQty => noms.fold(0, (a, b) => a + b.qty);

  double get discountInHrn => summ - discountedSumm;

  CreateOrderState copyWith({
    CreateOrderStatus? status,
    int? orderId,
    ApiOrder? order,
    String? errorMessage,
    Counterparty? counterparty,
    List<ApiOrderNom>? noms,
    List<ApiContract>? contracts,
    ApiDiscount? discount,
    List<ApiUnit>? units,
    ApiUnit? selectedUnit
  }) {
    return CreateOrderState(
      status: status ?? this.status,
      order: order ?? this.order,
      orderId: orderId ?? this.orderId,
      errorMessage: errorMessage ?? this.errorMessage,
      counterparty: counterparty ?? this.counterparty,
      noms: noms ?? this.noms,
      contracts: contracts ?? this.contracts,
      discount: discount ?? this.discount,
      units: units ?? this.units,
      selectedUnit: selectedUnit ?? this.selectedUnit
    );
  }

  @override
  List<Object?> get props => [
        status,
        orderId,
        errorMessage,
        counterparty,
        noms,
        order,
        contracts,
        discount,
        units,
        selectedUnit
      ];
}