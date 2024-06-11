import 'package:equatable/equatable.dart';

class ApiNom extends Equatable {
  final int id;
  final String ref;
  final bool isFolder;
  final String description;
  final String article;
  final String parentKey;
  final String unitKey;
  final String imageKey;
  final double price;

  const ApiNom(
      {required this.id,
      required this.ref,
      required this.isFolder,
      required this.description,
      required this.article,
      required this.parentKey,
      required this.unitKey,
      required this.imageKey,
      required this.price});

  factory ApiNom.fromJson(Map<String, dynamic> json) => ApiNom(
      id: json['id'] ?? 0,
      ref: json['Ref_Key'] ?? '',
      isFolder: json['IsFolder'] ?? true,
      description: (json['Description'] ?? ''),
      article: json['Артикул'] ?? '',
      parentKey: json['Parent_Key'] ?? '',
      unitKey: json['БазоваяЕдиницаИзмерения_Key'] ?? '',
      imageKey: json['ФайлКартинки_Key'] ?? '',
      price: 0);

  factory ApiNom.fromSql(Map<String, dynamic> json) => ApiNom(
      id: json['id'] ?? 0,
      ref: json['Ref_Key'] ?? '',
      isFolder: ((json['IsFolder'] ?? 0) == 0 ? false : true),
      description: (json['Description'] ?? ''),
      article: json['Артикул'] ?? '',
      parentKey: json['Parent_Key'] ?? '',
      unitKey: json['БазоваяЕдиницаИзмерения_Key'] ?? '',
      imageKey: json['ФайлКартинки_Key'] ?? '',
      price: json['Цена'] ?? 0);

  Map<String, dynamic> toJson() => {
        'Ref_Key': ref,
        'IsFolder': isFolder ? 1 : 0,
        'Description': description,
        'Артикул': article,
        'Parent_Key': parentKey,
        'БазоваяЕдиницаИзмерения_Key': unitKey,
      };


ApiNom copyWith({
    int? id,
    String? ref,
    bool? isFolder,
    String? description,
    String? article,
    String? parentKey,
    String? unitKey,
    String? imageKey,
    double? price,
  }) {
    return ApiNom(
      id: id ?? this.id,
      ref: ref ?? this.ref,
      isFolder: isFolder ?? this.isFolder,
      description: description ?? this.description,
      article: article ?? this.article,
      parentKey: parentKey ?? this.parentKey,
      unitKey: unitKey ?? this.unitKey,
      imageKey: imageKey ?? this.imageKey,
      price: price ?? this.price,
    );
  }



  double calcDiscount(double discount) {
    return price * (1 - discount / 100);
  }

  static const empty = ApiNom(
      id: 0,
      ref: '',
      isFolder: false,
      description: '',
      article: '',
      parentKey: '',
      unitKey: '',
      imageKey: '',
      price: 0);

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
