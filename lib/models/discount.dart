import 'package:equatable/equatable.dart';

class Discount extends Equatable {
  final String discountRecipientKey;
  final double percentDiscounts;

  const Discount({
    required this.discountRecipientKey,
    required this.percentDiscounts,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        discountRecipientKey: json['ПолучательСкидки'] ?? '',
        percentDiscounts:
            ((json['ПроцентСкидкиНаценки'] ?? 0) as num).toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'ПолучательСкидки': discountRecipientKey,
      'ПроцентСкидкиНаценки': percentDiscounts,
    };
  }

  static const empty = Discount(
    discountRecipientKey: '',
    percentDiscounts: 0,
  );

  @override
  List<Object?> get props => [discountRecipientKey, percentDiscounts];
}
