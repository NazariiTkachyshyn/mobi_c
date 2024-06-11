import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObBarcode {
  @Id()
  int id;
  final String barcode;
  final String nomKey;
  final String packKey;

  ObBarcode(
      {required this.barcode,
        required this.nomKey,
        required this.packKey,
        this.id = 0});

  factory ObBarcode.fromApi(ApiBarcode barcode) => ObBarcode(
      barcode: barcode.barcode,
      nomKey: barcode.nomKey,
      packKey: barcode.packKey);
}
