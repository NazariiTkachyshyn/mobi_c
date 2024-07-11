import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_base/object_box/object_box.dart';
import 'package:mobi_c/services/data_sync_service/data_sync_service.dart';
import 'package:mobi_c/services/data_sync_service/models/full_order.dart';
import 'package:http/http.dart' as http;

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  SyncCubit(this._dataSyncService) : super(const SyncState());
  final DataSyncService _dataSyncService;
  final Box<FullOrder> fullOrderBox =
      GetIt.I<ObjectBox>().store.box<FullOrder>();

  Future<void> syncDbData() async {
    emit(state.copyWith(syncStatuses: []));
    _syncData('Номенклатура', _dataSyncService.syncNomData());
    _syncData('Угоди', _dataSyncService.syncContractData());
    _syncData('Контрагенти', _dataSyncService.syncCounterpartyData());
    _syncData('Од. виміру', _dataSyncService.syncUnitData());
    _syncData('Знижки', _dataSyncService.syncDiscountData());
  }

  Future<void> syncAll() async {
    emit(state.copyWith(syncStatuses: []));
    _syncData('Номенклатура', _dataSyncService.syncNomData());
    _syncData('Угоди', _dataSyncService.syncContractData());
    _syncData('Контрагенти', _dataSyncService.syncCounterpartyData());
    _syncData('Од. виміру', _dataSyncService.syncUnitData());
    _syncData('Знижки', _dataSyncService.syncDiscountData());

    await _dataSyncService.downloadImage();
  }

  Future<void> syncOrders() async {
    try {
      emit(state.copyWith(syncStatuses: []));
      final orders = fullOrderBox.getAll();
      for (final order in orders) {
        final response = await _sendOrderToServer(order);
        if (response.statusCode == 200) {
          fullOrderBox.remove(order.id); // Remove order after successful sync
          _updateSyncStatus(order.id, 200); // Update sync status
        } else {
          print('Failed to send order: ${response.body}');
          _updateSyncStatus(
              order.id, response.statusCode); // Update sync status
        }
      }
    } catch (e) {
      print('Error syncing orders: $e');
      throw Exception('Failed to sync orders');
    }
  }

  Future<http.Response> _sendOrderToServer(FullOrder order) async {
    const String username = 'dt';
    const String pass = 'DT20Group';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$pass'))}';
    final headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(order.toJson());

    final url = Uri.http('192.168.2.50:81',
        '/virok_test/odata/standard.odata/Document_ПриходныйКассовыйОрдер?\$format=json');
    return await http.post(url, headers: headers, body: body);
  }

  Future<void> downloadImage() async {
    try {
      await _dataSyncService.downloadImage();
    } catch (e) {
      return;
    }
  }

  void deleteAll() async {
    _dataSyncService.deleteAll();
  }

  Future<void> _syncData(String dataType, Future<int> func) async {
    try {
      List<SyncStatus> syncStatuses = state.syncStatuses;
      syncStatuses.add(SyncStatus(dataType, 3));
      emit(state.copyWith(syncStatuses: syncStatuses));

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

      emit(state.copyWith(syncStatuses: updatedSyncStatuses));
    } catch (e) {
      return;
    }
  }

  void _updateSyncStatus(int orderId, int resultCode) {
    final syncStatuses = List<SyncStatus>.from(state.syncStatuses)
      ..add(SyncStatus('Order $orderId', resultCode));
    emit(state.copyWith(syncStatuses: syncStatuses));
  }
}
