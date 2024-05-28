import 'package:equatable/equatable.dart';

class Nom extends Equatable {
  final int id;
  final String ref;
  final bool isFolder;
  final String description;
  final String article;
  final String parentKey;
  final String unitKey;
  final String imageKey;
  final double price;

  const Nom({
    required this.id,
    required this.ref,
    required this.isFolder,
    required this.description,
    required this.article,
    required this.parentKey,
    required this.unitKey,
    required this.imageKey,
    required this.price
  });


  factory Nom.fromJson(Map<String, dynamic> json) => Nom(
        id: 0,
        ref: json['Ref_Key'] ?? '',
        isFolder: json['IsFolder'] ?? false,
        description: (json['Description'] ?? ''),
        article: json['Артикул'] ?? '',
        parentKey: json['Parent_Key'] ?? '',
        unitKey: json['ЕдиницаИзмерения'] ?? '',
        imageKey: json['ФайлКартинки_Key'] ?? '',
        price: 0

      );

  factory Nom.fromSql(Map<String, dynamic> json) => Nom(
        id: 0,
        ref: json['ref'] ?? '',
        isFolder: (json['isFolder'] ?? 0) == 0 ? false : true,
        description: json['description'] ?? '',
        article: json['article'] ?? '',
        parentKey: json['parentKey'] ?? '',
        unitKey: json['unitKey'] ?? '',
        imageKey: json['ФайлКартинки_Key'] ?? '',
        price: json['price'] ?? 0
      );

  Map<String, dynamic> toJson() => {
        'ref': ref,
        'isFolder': isFolder,
        'description': description,
        'article': article,
        'parentKey': parentKey,
        'unitKey': unitKey,
      };

  static const empty = Nom(
    id: 0,
    ref: '',
    isFolder: false,
    description: '',
    article: '',
    parentKey: '',
    unitKey: '',
    imageKey: '',
    price: 0
  );

  @override
  List<Object?> get props => [
        id,
        ref,
        isFolder,
        description,
        article,
        parentKey,
        unitKey,
        imageKey,
        price 
      ];
}
