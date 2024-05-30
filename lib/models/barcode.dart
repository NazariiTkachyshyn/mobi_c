import 'package:equatable/equatable.dart';

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


  @override
  List<Object?> get props => [barcode, nomKey, packKey];
}
