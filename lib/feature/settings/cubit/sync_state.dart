part of 'sync_cubit.dart';

class SyncState extends Equatable {
  final List<SyncStatus> syncStatuses;
  final int number;

  const SyncState({this.syncStatuses = const [], this.number = 0});

  SyncState copyWith({List<SyncStatus>? syncStatuses, int? number}) {
    return SyncState(
        syncStatuses: syncStatuses ?? this.syncStatuses,
        number: number ?? this.number);
  }

  @override
  List<Object> get props => [syncStatuses, number];
}

enum SyncStateStatus { downloading, downloaded, failure }

extension SyncStatusX on SyncStateStatus {
  bool get isDownloading => this == SyncStateStatus.downloading;
  bool get isDownloaded => this == SyncStateStatus.downloaded;
  bool get isFailure => this == SyncStateStatus.failure;
}

class SyncStatus {
  final String dataType;
  final int resultCode;

  SyncStatus(this.dataType, this.resultCode);
  SyncStatus copyWith({
    String? dataType,
    int? resultCode,
  }) =>
      SyncStatus(
        dataType ?? this.dataType,
        resultCode ?? this.resultCode,
      );
}
