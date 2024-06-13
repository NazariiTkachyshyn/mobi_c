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
    this.folders = const [],
    this.images = const [],
    this.errorMassage = '',
  });

  final SelectNomStatus status;
  final List<Nom> searchNoms;
  final List<Nom> folders;
  final List<ImageOb> images;

  final String errorMassage;

  SelectNomState copyWith({
    SelectNomStatus? status,
    List<Nom>? searchNoms,
    List<Nom>? folders,
    String? errorMassage,
    List<ImageOb>? images
  }) {
    return SelectNomState(
      status: status ?? this.status,
      searchNoms: searchNoms ?? this.searchNoms,
      folders: folders ?? this.folders,
      errorMassage: errorMassage ?? this.errorMassage,
      images: images ?? this.images
    );
  }

  @override
  List<Object?> get props => [status, errorMassage, searchNoms, folders, images];
}
