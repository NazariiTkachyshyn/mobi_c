part of 'select_counterparty_cubit.dart';

enum SelectCounterpartyStatus {
  initial,
  loading,
  success,
  failure,
}

extension SelectCounterpartyStatusX on SelectCounterpartyStatus {
  bool get isInitial => this == SelectCounterpartyStatus.initial;
  bool get isLoading => this == SelectCounterpartyStatus.loading;
  bool get isSuccess => this == SelectCounterpartyStatus.success;
  bool get isFailure => this == SelectCounterpartyStatus.failure;
}

final class SelectCounterpartyState extends Equatable {
  const SelectCounterpartyState({
    this.status = SelectCounterpartyStatus.initial,
    this.allCounterparty = const [],
    this.counterparty = const [],
    this.errorMassage = '',
  });

  final SelectCounterpartyStatus status;
  final List<Counterparty> allCounterparty;
  final List<Counterparty> counterparty;

  final String errorMassage;

  SelectCounterpartyState copyWith({
    SelectCounterpartyStatus? status,
    List<Counterparty>? allCounterparty,
    List<Counterparty>? counterparty,
    String? errorMassage,
  }) {
    return SelectCounterpartyState(
      status: status ?? this.status,
      allCounterparty: allCounterparty ?? this.allCounterparty,
      counterparty: counterparty ?? this.counterparty,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }

  @override
  List<Object?> get props =>
      [status, errorMassage, allCounterparty, counterparty];
}
