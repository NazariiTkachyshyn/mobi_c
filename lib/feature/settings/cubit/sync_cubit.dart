import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_base/object_box/object_box.dart';
import 'package:mobi_c/services/data_sync_service/data_sync_service.dart';
import 'package:mobi_c/services/data_sync_service/models/full_order.dart';
import 'package:http/http.dart' as http;

import '../../../services/data_base/object_box/models/PKO.dart';

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  SyncCubit(this._dataSyncService) : super(const SyncState());
  final DataSyncService _dataSyncService;

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

  Future<bool> syncOrders() async {
    try {
      final Box<FullOrder> fullOrderBox =
          GetIt.I<ObjectBox>().store.box<FullOrder>();
      final orders = fullOrderBox.getAll();

      if (orders.isEmpty) {
        emit(state.copyWith(orderSyncStatus: SyncStateStatus.empty));
        return false;
      }
      emit(state.copyWith(orderSyncStatus: SyncStateStatus.downloading));

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(state.copyWith(orderSyncStatus: SyncStateStatus.noConnection));
        return false;
      }

      for (final order in orders) {
        final response = await _sendOrderToServer(order);
        if (response.statusCode == 201) {
          _updateSyncStatus(order.id, 201);
        } else {
          print('Failed to send order: ${response.body}');
          _updateSyncStatus(order.id, response.statusCode);
          emit(state.copyWith(orderSyncStatus: SyncStateStatus.failure));
          return false;
        }
      }
      fullOrderBox.removeAll();

      emit(state.copyWith(orderSyncStatus: SyncStateStatus.downloaded));
      return true;
    } catch (e) {
      print('Error syncing orders: $e');
      emit(state.copyWith(orderSyncStatus: SyncStateStatus.failure));
      throw Exception('Failed to sync orders');
    }
  }

  Future<bool> syncPKO() async {
    try {
      final pkoBox = GetIt.I<ObjectBox>().store.box<PKO>();
      final pkos = pkoBox.getAll();

      if (pkos.isEmpty) {
        emit(state
            .copyWith(syncStatuses: [], pkoSyncStatus: SyncStateStatus.empty));
        return false;
      }
      emit(state.copyWith(
          syncStatuses: [], pkoSyncStatus: SyncStateStatus.downloading));

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(state.copyWith(pkoSyncStatus: SyncStateStatus.noConnection));
        return false;
      }

      for (final pko in pkos) {
        final response = await _sendPKOToServer(pko);

        if (response.statusCode == 201) {
        } else {
          print('Failed to send PKO: ${response.body}');
          emit(state.copyWith(pkoSyncStatus: SyncStateStatus.failure));
          return false;
        }
      }
      pkoBox.removeAll();
      emit(state.copyWith(pkoSyncStatus: SyncStateStatus.downloaded));
      return true;
    } catch (e) {
      print('Error syncing PKO: $e');
      emit(state.copyWith(pkoSyncStatus: SyncStateStatus.failure));
      throw Exception('Failed to sync PKO');
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

  Future<http.Response> _sendPKOToServer(PKO pko) async {
    const String username = 'dt';
    const String pass = 'DT20Group';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$pass'))}';
    final headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(pko.toJson());

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
