import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_bases/object_box/models/discount.dart';

class SyncDiscount extends Equatable {
  final String discountRecipientKey;
  final double percentDiscounts;

  const SyncDiscount({
    required this.discountRecipientKey,
    required this.percentDiscounts,
  });

  factory SyncDiscount.fromJson(Map<String, dynamic> json) => SyncDiscount(
        discountRecipientKey: json['ПолучательСкидки'] ?? '',
        percentDiscounts:
            ((json['ПроцентСкидкиНаценки'] ?? 0) as num).toDouble(),
      );

      factory SyncDiscount.fromOb(Discount discount) => SyncDiscount(
        discountRecipientKey: discount.discountRecipientKey,
        percentDiscounts: discount.percentDiscounts,
      );


  static const empty = SyncDiscount(
    discountRecipientKey: '',
    percentDiscounts: 0,
  );

  @override
  List<Object?> get props => [discountRecipientKey, percentDiscounts];
}
