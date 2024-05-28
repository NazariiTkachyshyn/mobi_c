import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_bases/object_box/models/ob.price.dart';

class Price extends Equatable {
  final double price;
  final String priceType;
  final String packKey;
  final String currencyKey;
  final String nomKey;

  const Price(
      {required this.price,
      required this.priceType,
      required this.packKey,
      required this.currencyKey,
      required this.nomKey});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
      price: ((json['Цена'] ?? 0) as num).toDouble(),
      priceType: json['ВидЦены_Key'] ?? '',
      packKey: json['Упаковка_Key'] ?? '',
      currencyKey: json['Валюта_Key'] ?? '',
      nomKey: json['Номенклатура_Key'] ?? '');

  factory Price.fromObPrice(ObPrice price) => Price(
      price: price.price ?? 0,
      priceType: price.priceType ?? '',
      packKey: price.packKey ?? '',
      currencyKey: price.currencyKey ?? '',
      nomKey: price.nomKey ?? '');

  factory Price.fromSql(Map<String, dynamic> json) => Price(
      price: json['price'] ?? 0,
      priceType: json['priceType'] ?? '',
      packKey: json['packKey'] ?? '',
      currencyKey: json['currencyKey'] ?? '',
      nomKey: json['nomKey'] ?? '');

        Map<String, dynamic> toJson() => {
        'price': price,
        'priceType': priceType,
        'packKey': packKey,
        'currencyKey': currencyKey,
        'nomKey': nomKey,
      };

  @override
  List<Object?> get props => [price, priceType, packKey, currencyKey, nomKey];
}
