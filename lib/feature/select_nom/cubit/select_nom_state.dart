part of 'select_nom_cubit.dart';

enum SelectNomStatus {
  initial,
  loading,
  success,
  failure,
}

extension SelectNomStatusX on SelectNomStatus {
  bool get isInitial => this == SelectNomStatus.initial;
  bool get isLoading => this == SelectNomStatus.loading;
  bool get isSuccess => this == SelectNomStatus.success;
  bool get isFailure => this == SelectNomStatus.failure;
}

final class SelectNomState extends Equatable {
  const SelectNomState({
    this.status = SelectNomStatus.initial,
    this.searchNoms = const [],
    this.treeNom = const [],
    this.remaining = const [],
    this.errorMassage = '',
  });

  final SelectNomStatus status;
  final List<Nom> searchNoms;
  final List<TreeNom> treeNom;
  final List<Remaining> remaining;
  final String errorMassage;

  int get offset => searchNoms.length;

  SelectNomState copyWith(
      {SelectNomStatus? status,
      List<Nom>? searchNoms,
      String? errorMassage,
      List<Remaining>? remaining,
      List<TreeNom>? treeNom}) {
    return SelectNomState(
        status: status ?? this.status,
        searchNoms: searchNoms ?? this.searchNoms,
        errorMassage: errorMassage ?? this.errorMassage,
        remaining: remaining ?? this.remaining,
        treeNom: treeNom ?? this.treeNom);
  }

  @override
  List<Object?> get props =>
      [status, errorMassage, searchNoms, treeNom, remaining];
}



