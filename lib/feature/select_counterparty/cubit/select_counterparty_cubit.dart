import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_repo/select_counterparty_repo.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

part 'select_counterparty_state.dart';

class SelectCounterpartyCubit extends Cubit<SelectCounterpartyState> {
  SelectCounterpartyCubit(this._selectCounterpartyRepo)
      : super(const SelectCounterpartyState());

  final SelectCounterpartyRepo _selectCounterpartyRepo;



  searchCounterparty(String value) async{
  final counterpartys = await _selectCounterpartyRepo.getCounterpartys(value);
    emit(state.copyWith(
        counterpartys: counterpartys, status: SelectCounterpartyStatus.success));
  }
}
