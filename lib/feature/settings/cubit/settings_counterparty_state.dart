part of 'settings_counterparty_cubit.dart';

enum SettingsCounterpartyStatus {
  initial,
  loading,
  success,
  failure,
}

extension SettingsCounterpartyStatusX on SettingsCounterpartyStatus {
  bool get isInitial => this == SettingsCounterpartyStatus.initial;
  bool get isLoading => this == SettingsCounterpartyStatus.loading;
  bool get isSuccess => this == SettingsCounterpartyStatus.success;
  bool get isFailure => this == SettingsCounterpartyStatus.failure;
}

final class SettingsCounterpartyState extends Equatable {
  const SettingsCounterpartyState({
    this.status = SettingsCounterpartyStatus.initial,
    this.counterpartyTree = const [],
    this.routes = const[],
    this.isTreeView = false,
    this.errorMassage = '',
  });

  final SettingsCounterpartyStatus status;
  final List<CounterpartyTree> counterpartyTree;
  final List<ClientRoute> routes;
  final String errorMassage;
  final bool isTreeView;

  SettingsCounterpartyState copyWith({
    SettingsCounterpartyStatus? status,
    List<CounterpartyTree>? counterpartyTree,
    List<ClientRoute>? routes,
    bool? isTreeView,
    String? errorMassage,
  }) {
    return SettingsCounterpartyState(
        status: status ?? this.status,
        isTreeView: isTreeView ?? this.isTreeView,
        errorMassage: errorMassage ?? this.errorMassage,
        routes: routes ?? this.routes,
        counterpartyTree: counterpartyTree ?? this.counterpartyTree);
  }

  @override
  List<Object?> get props => [status, errorMassage, counterpartyTree, isTreeView, routes];
}

