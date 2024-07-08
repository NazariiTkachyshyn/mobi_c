part of 'create_pko_cubit.dart';

enum CreatePKOStatus {
  initial,
  loading,
  success,
  failure,
}

extension CreateStorageStatusX on CreatePKOStatus {
  bool get isInitial => this == CreatePKOStatus.initial;
  bool get isLoading => this == CreatePKOStatus.loading;
  bool get isSuccess => this == CreatePKOStatus.success;
  bool get isFailure => this == CreatePKOStatus.failure;
}

final class CreatePKOState extends Equatable {
  CreatePKOState({
    this.sum = 0.0,
    this.status = CreatePKOStatus.initial,
    this.orderId = 0,
    this.errorMessage = '',
    this.comment = '',
    required this.selectedDate,
    required this.contractKey,
    this.noms = const [],
    this.contracts = const [],
    Discount? discount,
    ApiOrder? order,
    Counterparty? counterparty,
  })  : counterparty = counterparty ?? Counterparty.empty,
        discount = discount ?? Discount.empty,
        order = order ?? ApiOrder.empty;

  final CreatePKOStatus status;
  final String errorMessage;
  final String comment;
  final DateTime? selectedDate;
  final List<OrderNom> noms;
  final Discount discount;
  final String? contractKey;
  final int orderId;
  final double sum;
  final List<Contract> contracts;
  final ApiOrder order;
  final Counterparty counterparty;

  double get discountedSumm => noms.fold(0,
      (a, b) => a + (calcDiscount(b.price, discount.percentDiscounts) * b.qty));

  double get summ => noms.fold(0, (a, b) => a + b.price * b.qty * b.ratio);
  int get totalQty => noms.fold(0, (a, b) => a + b.qty);

  double get discountInHrn => summ - discountedSumm;
  CreatePKOState copyWith({
    CreatePKOStatus? status,
    DateTime? selectedDate,
    String? errorMessage,
    String? comment,
    double? sum,
    int? orderId,
    ApiOrder? order,
    List<OrderNom>? noms,
    Discount? discount,
    String? contractKey,
    Counterparty? counterparty,
    List<Contract>? contracts,
  }) {
    return CreatePKOState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      contractKey: contractKey ?? this.contractKey,
      sum: sum ?? this.sum,
      errorMessage: errorMessage ?? this.errorMessage,
      comment: comment ?? this.comment,
      counterparty: counterparty ?? this.counterparty,
      noms: noms ?? this.noms,
      orderId: orderId ?? this.orderId,
      discount: discount ?? this.discount,
      order: order ?? this.order,
      contracts: contracts ?? this.contracts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        comment,
        orderId,
        contractKey,
        counterparty,
        sum,
        noms,
        discount,
        order,
        contracts,
        selectedDate,
      ];
}
