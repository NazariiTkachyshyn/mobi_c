import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Barcode {
  @Id()
  int id;
  final String barcode;
  final String nomKey;
  final String packKey;

  Barcode(
      {required this.barcode,
        required this.nomKey,
        required this.packKey,
        this.id = 0});

  factory Barcode.fromApi(ApiBarcode barcode) => Barcode(
      barcode: barcode.barcode,
      nomKey: barcode.nomKey,
      packKey: barcode.packKey);
}
