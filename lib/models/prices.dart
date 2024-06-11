import 'package:equatable/equatable.dart';

class ApiPrice extends Equatable {
  final double price;
  final String priceType;
  final String packKey;
  final String currencyKey;
  final String nomKey;

  const ApiPrice(
      {required this.price,
      required this.priceType,
      required this.packKey,
      required this.currencyKey,
      required this.nomKey});

  factory ApiPrice.fromJson(Map<String, dynamic> json) => ApiPrice(
      price: ((json['Цена'] ?? 0) as num).toDouble(),
      priceType: json['ТипЦен_Key'] ?? '',
      packKey: json['Упаковка_Key'] ?? '',
      currencyKey: json['Валюта_Key'] ?? '',
      nomKey: json['Номенклатура_Key'] ?? '');




        Map<String, dynamic> toJson() => {
        'Цена': price,
        'ТипЦен_Key': priceType,
        'Упаковка_Key': packKey,
        'Валюта_Key': currencyKey,
        'Номенклатура_Key': nomKey,
      };

  @override
  List<Object?> get props => [price, priceType, packKey, currencyKey, nomKey];
}
