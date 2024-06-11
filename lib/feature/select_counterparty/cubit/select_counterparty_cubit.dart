import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_repo/select_counterparty_repo.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

part 'select_counterparty_state.dart';

class SelectCounterpartyCubit extends Cubit<SelectCounterpartyState> {
  SelectCounterpartyCubit(this._selectCounterpartyRepo)
      : super(const SelectCounterpartyState());

  final SelectCounterpartyRepo _selectCounterpartyRepo;

  void getAll() {
    try {
      final counterparty = _selectCounterpartyRepo.getAll();
      emit(state.copyWith(
          allCounterparty: counterparty,
          status: SelectCounterpartyStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectCounterpartyStatus.failure));
    }
  }

  searchCounterparty(String value) {
    final counterparty = state.allCounterparty
        .where(
            (e) => (e.description.toLowerCase()).contains(value.toLowerCase()))
        .toList();

    emit(state.copyWith(
        counterparty: counterparty, status: SelectCounterpartyStatus.success));
  }
}
