import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObDiscount {
  @Id()
  int id;
  final String discountRecipientKey;
  final double percentDiscounts;

  ObDiscount(
      {required this.discountRecipientKey,
        required this.percentDiscounts,
        this.id = 0});

  factory ObDiscount.fromApi(ApiDiscount discount) => ObDiscount(
      discountRecipientKey: discount.discountRecipientKey,
      percentDiscounts: discount.percentDiscounts);
}
