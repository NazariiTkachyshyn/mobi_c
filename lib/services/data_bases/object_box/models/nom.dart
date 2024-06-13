import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Nom {
  @Id()
  int id;
  final String ref;
  final bool isFolder;
  final String description;
  final String article;
  final String parentKey;
  final String unitKey;
  final String imageKey;
  final double price;
  final int remaining;
  final String priceTypeKey;
  final String currencyKey;
  final String searchField;
  final String storageKey;

  Nom(
      {required this.ref,
      required this.isFolder,
      required this.description,
      required this.article,
      required this.parentKey,
      required this.unitKey,
      required this.imageKey,
      required this.price,
      required this.remaining,
      required this.priceTypeKey,
      required this.currencyKey,
      required this.searchField,
      required this.storageKey,
      this.id = 0});

  factory Nom.fromApi(SyncNom nom) => Nom(
      ref: nom.ref,
      isFolder: nom.isFolder,
      article: nom.article,
      searchField: (nom.article + nom.description).toLowerCase(),
      price: nom.price,
      remaining: nom.remaining,
      priceTypeKey: nom.priceTypeKey,
      currencyKey: nom.currencyKey,
      description: nom.description,
      parentKey: nom.parentKey,
      imageKey: nom.imageKey,
      unitKey: nom.unitKey,
      storageKey: nom.storageKey);
}
