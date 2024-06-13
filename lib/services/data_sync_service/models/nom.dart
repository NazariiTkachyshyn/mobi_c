import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class SyncNom extends Equatable {
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
  final String storageKey;

  const SyncNom(
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
      required this.storageKey});

  factory SyncNom.fromJson(Map<String, dynamic> json) {
    return SyncNom(
        ref: json['Ref_Key'] ?? '',
        isFolder: json['IsFolder'] == 'true',
        description: json['Description'] ?? '',
        article: json['Артикул'] ?? '',
        parentKey: json['Parent_Key'] ?? '',
        unitKey: json['БазоваяЕдиницаИзмерения_Key'] ?? '',
        imageKey: json['ФайлКартинки_Key'] ?? '',
        price: (json['Цена'] ?? 0).toDouble(),
        remaining: json['Залишок'] ?? 0,
        priceTypeKey: json['ТипЦен_Key'] ?? '',
        currencyKey: json['Валюта_Key'] ?? '',
        storageKey: json['Storage_Key'] ?? '');
  }
  factory SyncNom.fromOb(Nom nom) {
    return SyncNom(
        ref: nom.ref,
        isFolder: nom.isFolder,
        description: nom.description,
        article: nom.article,
        parentKey: nom.parentKey,
        unitKey: nom.unitKey,
        imageKey: nom.imageKey,
        price: nom.price,
        remaining: nom.remaining,
        priceTypeKey: nom.priceTypeKey,
        currencyKey: nom.currencyKey,
        storageKey: nom.storageKey);
  }

  @override
  List<Object?> get props => [
        ref,
        isFolder,
        description,
        article,
        parentKey,
        unitKey,
        imageKey,
        price,
        remaining,
        priceTypeKey,
        currencyKey,
        storageKey
      ];
}
