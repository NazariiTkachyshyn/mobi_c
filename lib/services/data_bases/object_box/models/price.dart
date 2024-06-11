import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Price {
  @Id()
  int id;
  final double price;
  final String priceType;
  final String packKey;
  final String currencyKey;
  final String nomKey;

  Price(
      {required this.price,
        required this.priceType,
        required this.packKey,
        required this.currencyKey,
        required this.nomKey,
        this.id = 0});

  factory Price.fromApi(ApiPrice price) => Price(
      price: price.price,
      priceType: price.priceType,
      packKey: price.packKey,
      currencyKey: price.currencyKey,
      nomKey: price.nomKey);
}
