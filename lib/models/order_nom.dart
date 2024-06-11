import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/models/models.dart';

class ApiOrderNom extends Equatable {
  final int id;
  final int orderId;
  final String ref;
  final String description;
  final String article;
  final String imageKey;
  final String unitKey;
  final int qty;
  final double price;
  final int ratio;
  final String unitName;

  const ApiOrderNom(
      {required this.id,
      required this.orderId,
      required this.ref,
      required this.description,
      required this.article,
      required this.imageKey,
      required this.unitKey,
      required this.qty,
      required this.price,
      required this.ratio,
      required this.unitName});

  factory ApiOrderNom.fromJson(Map<String, dynamic> json) {
    return ApiOrderNom(
      id: json['id'] ?? 0,
      orderId: json['orderId'] ?? 0,
      ref: json['ref'] ?? '',
      description: json['description'] ?? '',
      article: json['article'] ?? '',
      imageKey: json['imageKey'] ?? '',
      unitKey: json['unitKey'] ?? '',
      qty: json['qty'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      ratio: (json['ratio'] ?? 0),
      unitName: json['unitName'] ?? '',
    );
  }
  factory ApiOrderNom.fromNom(ApiNom nom, int orderId) => ApiOrderNom(
      id: 0,
      orderId: orderId,
      ref: nom.ref,
      description: nom.description,
      article: nom.article,
      imageKey: nom.imageKey,
      unitKey: nom.unitKey,
      qty: 0,
      price: nom.price,
      ratio: 0,
      unitName: '');

  ApiOrderNom copyWith({int? qty, String? unitKey}) => ApiOrderNom(
      id: id,
      orderId: orderId,
      ref: ref,
      description: description,
      article: article,
      imageKey: imageKey,
      unitKey: unitKey ?? this.unitKey,
      qty: qty ?? this.qty,
      price: price,
      ratio: ratio,
      unitName: unitName);

  Map<String, dynamic> toJson(int number, String storageKey, double discount) {
    return {
      'LineNumber': number,
      "ЕдиницаИзмерения_Key": unitKey,
      'Количество': qty,
      "Коэффициент": 1,
      'Номенклатура_Key': ref,
      'СтавкаНДС': 'НДС20',
      'Цена': price,
      "ПроцентАвтоматическихСкидок": discount,
      "УсловиеАвтоматическойСкидки": "ПоКоличествуТовара",
      "ЗначениеУсловияАвтоматическойСкидки": "0",
      "ЗначениеУсловияАвтоматическойСкидки_Type": "Edm.Double",
      'ТипЦен_Key': KeyConst.priceType,
    };
  }

  double calcDiscount(double discount) {
    return price * (1 - discount / 100);
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        qty,
        price,
        ref,
        article,
        description,
        unitKey,
        ratio,
        unitName
      ];
}
