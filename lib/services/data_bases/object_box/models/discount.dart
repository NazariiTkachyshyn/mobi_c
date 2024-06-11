import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Discount {
  @Id()
  int id;
  final String discountRecipientKey;
  final double percentDiscounts;

  Discount(
      {required this.discountRecipientKey,
        required this.percentDiscounts,
        this.id = 0});

  factory Discount.fromApi(ApiDiscount discount) => Discount(
      discountRecipientKey: discount.discountRecipientKey,
      percentDiscounts: discount.percentDiscounts);
}
