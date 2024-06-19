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

class CounterpartyTree {
  final String refKey;
  final String description;
  final String mainCounterpartyKey;
  final String partnerKey;
  final String fullDescription;
  final String searchField;
  final String parentKey;
    final bool isFolder;

  List<CounterpartyTree> children;

  CounterpartyTree(
      {required this.refKey,
      required this.description,
      required this.mainCounterpartyKey,
      required this.partnerKey,
      required this.fullDescription,
      required this.searchField,
      required this.parentKey,
      required this.children,
      required this.isFolder
      });

  void addChild(CounterpartyTree child) {
    children.add(child);
  }

  factory CounterpartyTree.fromCounterparty(Counterparty counterparty) =>
      CounterpartyTree(
          refKey: counterparty.refKey,
          description: counterparty.description,
          mainCounterpartyKey: counterparty.mainCounterpartyKey,
          partnerKey: counterparty.partnerKey,
          fullDescription: counterparty.fullDescription,
          searchField: (counterparty.description + counterparty.fullDescription)
              .toLowerCase(),
          parentKey: counterparty.parentKey,
          isFolder: counterparty.isFolder,
          children: []);
}
