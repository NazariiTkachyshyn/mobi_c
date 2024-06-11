import 'package:equatable/equatable.dart';


class ApiStorage extends Equatable {
  final String refKey;
  final String description;

  const ApiStorage({required this.refKey, required this.description});

  factory ApiStorage.fromJson(Map<String, dynamic> json) => ApiStorage(
      refKey: json['Ref_Key'] ?? '', description: json['Description'] ?? '');


static const empty = ApiStorage(refKey: '', description: '');
  @override
  List<Object?> get props => [refKey, description];
}
