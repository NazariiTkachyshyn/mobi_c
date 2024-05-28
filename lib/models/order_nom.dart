import 'package:equatable/equatable.dart';

import '../services/data_bases/object_box/models/models.dart';

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

  factory OrderNom.fromOb(ObOrderNom nom) => OrderNom(
      id: nom.id,
      orderId: nom.orderId ?? 0,
      qty: nom.qty ?? 0,
      price: nom.price ?? 0,
      ref: nom.ref ?? '',
      article: nom.article ?? '',
      description: nom.description ?? '',
      unitKey: nom.unitKey ?? '',
      imageKey: nom.imageKey ?? '');

  @override
  List<Object?> get props =>
      [id, orderId, qty, price, ref, article, description, unitKey];
}
