import 'package:mobi_c/objectbox.g.dart';

@Entity()
class ApiOrderNom {
  @Id()
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

  const ApiOrderNom({this.id = 0,
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
}