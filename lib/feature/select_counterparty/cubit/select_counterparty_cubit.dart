import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_repo/select_counterparty_repo.dart';
import 'package:mobi_c/models/models.dart';

part 'select_counterparty_state.dart';

class SelectCounterpartyCubit extends Cubit<SelectCounterpartyState> {
  SelectCounterpartyCubit(this._selectCounterpartyRepo)
      : super(const SelectCounterpartyState());

  final SelectCounterpartyRepo _selectCounterpartyRepo;

  Future<void> getAll() async {
    try {
      final counterparty = await _selectCounterpartyRepo.getAll();
      emit(state.copyWith(
          counterparty: counterparty,
          status: SelectCounterpartyStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectCounterpartyStatus.failure));
    }
  }

  Future<void> getCounterparty(String value) async {
    try {
      final counterparty =
          await _selectCounterpartyRepo.getCounterpartys(value);
      emit(state.copyWith(
          counterparty: counterparty,
          status: SelectCounterpartyStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectCounterpartyStatus.failure));
    }
  }

  Future<void> getCounterpartysByParentKey(String parentKey) async {
    try {
      final counterparty =
          await _selectCounterpartyRepo.getCounterpartysByParentKey(parentKey);
      emit(state.copyWith(
          counterparty: counterparty,
          status: SelectCounterpartyStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectCounterpartyStatus.failure));
    }
  }
}
