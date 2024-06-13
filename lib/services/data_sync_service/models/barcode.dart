import 'package:equatable/equatable.dart';

class SyncBarcode extends Equatable {
  final String barcode;
  final String nomKey;
  final String packKey;

  const SyncBarcode(
      {required this.barcode, required this.nomKey, required this.packKey});

  factory SyncBarcode.fromJson(Map<String, dynamic> json) => SyncBarcode(
      barcode: json['Штрихкод'] ?? '',
      packKey: json['Упаковка_Key'] ?? '',
      nomKey: json['Номенклатура_Key'] ?? '');


  @override
  List<Object?> get props => [barcode, nomKey, packKey];
}
