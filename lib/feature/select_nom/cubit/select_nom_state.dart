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
    this.images = const [],
    this.treeNom = const [],
    this.errorMassage = '',
  });

  final SelectNomStatus status;
  final List<Nom> searchNoms;
  final List<ImageOb> images;
  final List<TreeNom> treeNom;
  final String errorMassage;

  int get offset => searchNoms.length;

  SelectNomState copyWith(
      {SelectNomStatus? status,
      List<Nom>? searchNoms,
      String? errorMassage,
      List<ImageOb>? images,
      List<TreeNom>? treeNom}) {
    return SelectNomState(
        status: status ?? this.status,
        searchNoms: searchNoms ?? this.searchNoms,
        errorMassage: errorMassage ?? this.errorMassage,
        images: images ?? this.images,
        treeNom: treeNom ?? this.treeNom);
  }

  @override
  List<Object?> get props =>
      [status, errorMassage, searchNoms, images, treeNom];
}

class TreeNom {
  final int id;
  final String ref;
  final bool isFolder;
  final String description;
  final String article;
  final String parentKey;
  final String unitKey;
  final String imageKey;
  final double price;
  List<TreeNom> children;

  TreeNom(
      {required this.id,
      required this.ref,
      required this.isFolder,
      required this.description,
      required this.article,
      required this.parentKey,
      required this.unitKey,
      required this.imageKey,
      required this.children,
      required this.price});

  void addChild(TreeNom child) {
    children.add(child);
  }

  factory TreeNom.fromNom(Nom nom) => TreeNom(
      id: 0,
      ref: nom.ref,
      isFolder: nom.isFolder,
      description: nom.description,
      article: nom.article,
      parentKey: nom.parentKey,
      unitKey: nom.unitKey,
      imageKey: nom.imageKey,
      children: [],
      price: 0);
}
