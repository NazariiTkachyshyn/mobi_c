import 'package:objectbox/objectbox.dart';

import '../../../../models/models.dart';

@Entity()
class ObOrderNom {
  @Id()
  int id;
  int? orderId;
  String? ref;
  String? description;
  String? article;
  String? imageKey;
  String? unitKey;
  int? qty;
  double? price;

  ObOrderNom(
      {required this.ref,
      required this.article,
      required this.description,
      required this.unitKey,
      required this.orderId,
      required this.qty,
      required this.price,
      this.id = 0});

  factory ObOrderNom.fromOrderNom(OrderNom nom) => ObOrderNom(
      id: nom.id,
      orderId: nom.orderId,
      qty: nom.qty,
      price: nom.price,
      ref: nom.ref,
      article: nom.article,
      description: nom.description,
      unitKey: nom.unitKey);
}
