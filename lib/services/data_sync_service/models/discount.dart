import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_bases/object_box/models/discount.dart';

class SyncDiscount extends Equatable {
  final String discountRecipientKey;
  final double percentDiscounts;
  final String lineNumber;

  const SyncDiscount(
      {required this.discountRecipientKey,
      required this.percentDiscounts,
      required this.lineNumber});

  factory SyncDiscount.fromJson(Map<String, dynamic> json) => SyncDiscount(
      discountRecipientKey: json['ПолучательСкидки'] ?? '',
      percentDiscounts: ((json['ПроцентСкидкиНаценки'] ?? 0) as num).toDouble(),
      lineNumber: (Random().nextDouble()*2132.5).toString());

  factory SyncDiscount.fromOb(Discount discount) => SyncDiscount(
      discountRecipientKey: discount.discountRecipientKey,
      percentDiscounts: discount.percentDiscounts,
      lineNumber: discount.lineNumber);

  static const empty = SyncDiscount(
      discountRecipientKey: '', percentDiscounts: 0.0, lineNumber: '0');

  @override
  List<Object?> get props =>
      [discountRecipientKey, percentDiscounts, lineNumber];
}
