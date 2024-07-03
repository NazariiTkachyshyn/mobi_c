import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/input_qty_unit/client/client.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

part 'input_qty_unit_state.dart';

class InputQtyUnitCubit extends Cubit<InputQtyUnitState> {
  InputQtyUnitCubit(this._inputQtyUnitClient) : super(InputQtyUnitState());

  final InputQtyUnitClient _inputQtyUnitClient;

  Future<void> getUnits(String nomKey, String nomUnit) async {
    try {
      final units = await _inputQtyUnitClient.getUnits(nomKey);
      final selectedUnit = units.firstWhere(
        (e) => e.classifierKey == nomUnit,
        orElse: () {
          return units.firstWhere((e) => e.refKey == nomUnit);
        },
      );
      emit(state.copyWith(
        units: units,
        selectedUnit: selectedUnit,
      ));
    } catch (e) {
      throw Exception(e);
    }
  }

  selectUnit(String unitClassificatorKey) {
    final selectedUnit =
        state.units.firstWhere((e) => e.classifierKey == unitClassificatorKey);
    emit(state.copyWith(selectedUnit: selectedUnit));
  }
}
