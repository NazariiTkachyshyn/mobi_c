part of 'input_qty_unit_cubit.dart';

final class InputQtyUnitState extends Equatable {
   InputQtyUnitState({
    this.units = const [],
    Unit? selectedUnit,
  }) : selectedUnit = selectedUnit ?? Unit.empty;

  final List<Unit> units;
  final Unit selectedUnit;

  InputQtyUnitState copyWith({List<Unit>? units, Unit? selectedUnit}) {
    return InputQtyUnitState(
        units: units ?? this.units,
        selectedUnit: selectedUnit ?? this.selectedUnit);
  }

  @override
  List<Object?> get props => [units, selectedUnit];
}
