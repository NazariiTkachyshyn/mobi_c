part of 'sync_cubit.dart';

enum SyncStateStatus {
  initialized,
  downloading,
  downloaded,
  failure,
  noConnection,
  empty
}

extension SyncStatusX on SyncStateStatus {
  bool get isInitialized => this == SyncStateStatus.initialized;
  bool get isDownloading => this == SyncStateStatus.downloading;
  bool get isDownloaded => this == SyncStateStatus.downloaded;
  bool get isFailure => this == SyncStateStatus.failure;
  bool get isNoConnection => this == SyncStateStatus.noConnection;
  bool get isEmpty => this == SyncStateStatus.empty;
}

class SyncState extends Equatable {
  final List<SyncStatus> syncStatuses;
  final int number;
  final SyncStateStatus pkoSyncStatus;
  final SyncStateStatus orderSyncStatus;

  const SyncState({
    this.syncStatuses = const [],
    this.number = 0,
    this.pkoSyncStatus = SyncStateStatus.initialized, // Default value
    this.orderSyncStatus = SyncStateStatus.initialized, // Default value
  });

  SyncState copyWith({
    List<SyncStatus>? syncStatuses,
    int? number,
    SyncStateStatus? pkoSyncStatus,
    SyncStateStatus? orderSyncStatus,
  }) {
    return SyncState(
      syncStatuses: syncStatuses ?? this.syncStatuses,
      number: number ?? this.number,
      pkoSyncStatus: pkoSyncStatus ?? this.pkoSyncStatus,
      orderSyncStatus: orderSyncStatus ?? this.orderSyncStatus,
    );
  }

  @override
  List<Object> get props =>
      [syncStatuses, number, pkoSyncStatus, orderSyncStatus];
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
