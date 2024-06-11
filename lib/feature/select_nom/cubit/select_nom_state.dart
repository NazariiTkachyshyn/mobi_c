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
    this.noms = const [],
    this.searchNoms = const [],
    this.folders = const [],
    this.errorMassage = '',
  });

  final SelectNomStatus status;
  final List<ApiNom> noms;
  final List<ApiNom> searchNoms;
  final List<ApiNom> folders;

  final String errorMassage;

  SelectNomState copyWith({
    SelectNomStatus? status,
    List<ApiNom>? noms,
    List<ApiNom>? searchNoms,
    List<ApiNom>? folders,
    String? errorMassage,
  }) {
    return SelectNomState(
      status: status ?? this.status,
      noms: noms ?? this.noms,
      searchNoms: searchNoms ?? this.searchNoms,
      folders: folders ?? this.folders,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }

  @override
  List<Object?> get props => [status, errorMassage, noms, searchNoms, folders];
}
