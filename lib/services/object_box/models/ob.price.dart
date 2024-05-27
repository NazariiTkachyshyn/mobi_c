import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObPrice {
  @Id()
  int id;
  double? price;
  String? priceType;
  String? packKey;
  String? currencyKey;
  String? nomKey;

  ObPrice(
      {required this.price,
      required this.priceType,
      required this.packKey,
      required this.currencyKey,
      required this.nomKey,
      this.id = 0});

  factory ObPrice.fromApi(Price price) => ObPrice(
      price: price.price.toDouble(),
      priceType: price.priceType,
      packKey: price.packKey,
      currencyKey: price.currencyKey,
      nomKey: price.nomKey);
}
