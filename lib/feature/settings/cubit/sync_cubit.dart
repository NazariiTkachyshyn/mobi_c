import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_sync_service/data_sync_service.dart';

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  SyncCubit(this._dataSyncService) : super(const SyncState());
  final DataSyncService _dataSyncService;

  Future<void> syncDbData() async {
    emit(state.copyWith(syncStatuses: []));
    _syncData('Номенклатура', _dataSyncService.syncNomData());
    _syncData('Угоди', _dataSyncService.syncContractData());
    _syncData('Контрагенти', _dataSyncService.syncCounterpartyData());
    _syncData('Знижки', _dataSyncService.syncDiscountData());
    _syncData('Од. виміру', _dataSyncService.syncUnitData());
  }

  Future<void> syncAll() async {
    emit(state.copyWith(syncStatuses: []));
    _syncData('Номенклатура', _dataSyncService.syncNomData());
    _syncData('Угоди', _dataSyncService.syncContractData());
    _syncData('Контрагенти', _dataSyncService.syncCounterpartyData());
    _syncData('Знижки', _dataSyncService.syncDiscountData());
    _syncData('Од. виміру', _dataSyncService.syncUnitData());
    await _dataSyncService.downloadImage();
  }

  Future<void> downloadImage() async {
    try {
      await _dataSyncService.downloadImage();
    } catch (e) {
      return;
    }
  }

  deleteAll() async {
    _dataSyncService.deleteAll();
  }

  Future<void> _syncData(String dataType, Future<int> func) async {
    try {
      List<SyncStatus> syncStatuses = state.syncStatuses;
      syncStatuses.add(SyncStatus(dataType, 3));
      emit(state.copyWith(
        syncStatuses: syncStatuses,
      ));
      final statusRes = await func;
      final updatedSyncStatuses = state.syncStatuses.map((e) {
        if (e.dataType == dataType) {
          return e.copyWith(resultCode: statusRes);
        }
        return e;
      }).toList();

      final i = updatedSyncStatuses.indexWhere((e) => e.resultCode == 3);
      final index =
          updatedSyncStatuses.indexWhere((e) => e.dataType == dataType);

      if (i >= 0) {
        final removedElement = updatedSyncStatuses.removeAt(index);
        updatedSyncStatuses.insert(i, removedElement);
      } else {
        final removedElement = updatedSyncStatuses.last;
        updatedSyncStatuses.removeLast();
        updatedSyncStatuses.add(removedElement);
      }

      emit(state.copyWith(
        syncStatuses: updatedSyncStatuses,
      ));
    } catch (e) {
      return;
    }
  }
}
