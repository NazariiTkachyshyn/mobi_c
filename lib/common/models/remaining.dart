import 'package:equatable/equatable.dart';

class Remaining extends Equatable {
  final String storageKey;
  final String name;
  final int remaining;

  const Remaining(
      {required this.storageKey, required this.remaining, required this.name});
  static const empty = Remaining(storageKey: '', remaining: 0, name: '');

  @override
  List<Object?> get props => [storageKey, name, remaining];
}
