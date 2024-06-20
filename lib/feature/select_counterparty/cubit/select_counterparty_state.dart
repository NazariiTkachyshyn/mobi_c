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
    this.counterparty = const [],
    this.counterpartyTree = const [],
    this.errorMassage = '',
  });

  final SelectCounterpartyStatus status;
  final List<Counterparty> counterparty;
  final List<CounterpartyTree> counterpartyTree;
  final String errorMassage;

    int get offset => counterparty.length;


  SelectCounterpartyState copyWith({
    SelectCounterpartyStatus? status,
    List<Counterparty>? allCounterparty,
    List<Counterparty>? counterparty,
    List<CounterpartyTree>? counterpartyTree,
    String? errorMassage,
  }) {
    return SelectCounterpartyState(
        status: status ?? this.status,
        counterparty: counterparty ?? this.counterparty,
        errorMassage: errorMassage ?? this.errorMassage,
        counterpartyTree: counterpartyTree ?? this.counterpartyTree);
  }

  @override
  List<Object?> get props =>
      [status, errorMassage, counterparty, counterpartyTree];
}

