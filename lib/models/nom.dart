import 'package:mobi_c/services/object_box/models/ob_nom.dart';

class Nom {
  final String ref;
  final bool isFolder;
  final String description;
  final String article;
  final String parentKey;
  final String unitKey;
  final String imageKey;
  List<Nom> children;

  Nom(
      {required this.ref,
      required this.isFolder,
      required this.description,
      required this.article,
      required this.parentKey,
      required this.unitKey,
      required this.imageKey,
      required this.children});

  void addChild(Nom child) {
    children.add(child);
  }

  factory Nom.fromJson(Map<String, dynamic> json) => Nom(
      ref: json['Ref_Key'] ?? '',
      isFolder: json['IsFolder'] ?? false,
      description: json['Description'] ?? '',
      article: json['Артикул'] ?? '',
      parentKey: json['Parent_Key'] ?? '',
      unitKey: json['ЕдиницаИзмерения'] ?? '',
      imageKey: json['ФайлКартинки_Key'] ?? '',
      children: []);

  factory Nom.fromObNom(ObNom nom) => Nom(
      ref: nom.ref ?? '',
      isFolder: nom.isFolder ?? false,
      description: nom.description ?? '',
      article: nom.article ?? '',
      parentKey: nom.parentKey ?? '',
      unitKey: nom.unitKey ?? '',
      imageKey: nom.imageKey ?? '',
      children: []);

  static final empty = Nom(
      ref: '',
      isFolder: false,
      description: '',
      article: '',
      parentKey: '',
      unitKey: '',
      imageKey: '',
      children: []);
}
