import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class Barcode extends Equatable {
  final String barcode;
  final String nomKey;
  final String packKey;

  const Barcode(
      {required this.barcode, required this.nomKey, required this.packKey});

  factory Barcode.fromJson(Map<String, dynamic> json) => Barcode(
      barcode: json['Штрихкод'] ?? '',
      packKey: json['Упаковка_Key'] ?? '',
      nomKey: json['Номенклатура_Key'] ?? '');

  factory Barcode.fromObPrice(ObBarocde price) => Barcode(
      barcode: price.barcode ?? '',
      packKey: price.packKey ?? '',
      nomKey: price.nomKey ?? '');

  @override
  List<Object?> get props => [barcode, nomKey, packKey];
}
