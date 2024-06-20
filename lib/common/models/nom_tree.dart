import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

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
      price: nom.price);
}