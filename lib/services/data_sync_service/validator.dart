import 'package:mobi_c/services/data_sync_service/utils.dart';

class Validator {
  bool needsUpdated(int apiCount, int dbCount) {
    return apiCount > dbCount ? true : false;
  }

  ValidationResult validate(dynamic apiData, dynamic dbData) {


    final difference = differenceData(apiData, dbData);

    if (difference.isNotEmpty) {
      return ValidationResult(needsUpdate: true, updatedData: difference);
    } else {
      return ValidationResult(needsUpdate: false);
    }
  }
}

class ValidationResult {
  final bool needsUpdate;
  final dynamic updatedData;

  ValidationResult({required this.needsUpdate, this.updatedData});
}
