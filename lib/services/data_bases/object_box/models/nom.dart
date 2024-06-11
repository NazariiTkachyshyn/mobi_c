import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Nom {
  @Id()
  int id;
  String? ref;
  bool? isFolder;
  String? description;
  String? descriptionLower;
  String? article;
  String? articleLower;
  String? parentKey;
  String? imageKey;
  String? unitKey;

  Nom(
      {required this.ref,
      required this.isFolder,
      required this.article,
      required this.articleLower,
      required this.description,
      required this.descriptionLower,
      required this.parentKey,
      required this.unitKey,
      this.id = 0});

  factory Nom.fromApi(ApiNom nom) => Nom(
      ref: nom.ref,
      isFolder: nom.isFolder,
      article: nom.article,
      articleLower: nom.article.toLowerCase(),
      descriptionLower: nom.description.toLowerCase(),
      description: nom.description,
      parentKey: nom.parentKey,
      unitKey: nom.unitKey);
}
