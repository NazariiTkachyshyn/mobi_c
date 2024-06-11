import 'package:equatable/equatable.dart';

class ApiDiscount extends Equatable {
  final String discountRecipientKey;
  final double percentDiscounts;

  const ApiDiscount({
    required this.discountRecipientKey,
    required this.percentDiscounts,
  });

  factory ApiDiscount.fromJson(Map<String, dynamic> json) => ApiDiscount(
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

  static const empty = ApiDiscount(
    discountRecipientKey: '',
    percentDiscounts: 0,
  );

  @override
  List<Object?> get props => [discountRecipientKey, percentDiscounts];
}
