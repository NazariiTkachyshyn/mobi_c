import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/constants/api_constants.dart';
import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/models/models.dart';

class OrderNom extends Equatable {
  final int id;
  final int orderId;
  final String ref;
  final String description;
  final String article;
  final String imageKey;
  final String unitKey;
  final int qty;
  final double price;

  const OrderNom(
      {required this.id,
      required this.orderId,
      required this.ref,
      required this.description,
      required this.article,
      required this.imageKey,
      required this.unitKey,
      required this.qty,
      required this.price});

  factory OrderNom.fromJson(Map<String, dynamic> json) {
    return OrderNom(
      id: json['id'] ?? 0,
      orderId: json['orderId'] ?? 0,
      ref: json['ref'] ?? '',
      description: json['description'] ?? '',
      article: json['article'] ?? '',
      imageKey: json['imageKey'] ?? '',
      unitKey: json['unitKey'] ?? '',
      qty: json['qty'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }
  factory OrderNom.fromNom(Nom nom, int orderId) => OrderNom(
      id: 0,
      orderId: orderId,
      ref: nom.ref,
      description: nom.description,
      article: nom.article,
      imageKey: nom.imageKey,
      unitKey: nom.unitKey,
      qty: 0,
      price: nom.price);

  OrderNom copyWith({int? qty, String? unitKey}) => OrderNom(
      id: id,
      orderId: orderId,
      ref: ref,
      description: description,
      article: article,
      imageKey: imageKey,
      unitKey: unitKey ?? this.unitKey,
      qty: qty ?? this.qty,
      price: price);

  Map<String, dynamic> toJson(int number, String storageKey) {
    return {
      'LineNumber': number,
      'Номенклатура_Key': ref,
      'Склад_Key': KeyConst.storageKey,
      'КоличествоУпаковок': qty,
      'Количество': qty,
      'Цена': price,
      'СтавкаНДС': 'НДС20',
      'ВидЦены_Key': KeyConst.priceType,
      'ВариантОбеспечения': 'Отгрузить',
    };
  }

  @override
  List<Object?> get props =>
      [id, orderId, qty, price, ref, article, description, unitKey];
}
