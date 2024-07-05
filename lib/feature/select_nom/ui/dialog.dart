import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/feature/input_qty_unit/ui/count_input_dialog.dart';
import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

qtyInputDialog(
    {required BuildContext context,
    required Nom nom,
    required Function(Nom nom, String qty, Unit init) onSelect,
    required Function onPop}) {
  showModal(
      context: context,
      builder: (_) => BlocProvider.value(
            value: context.read<InputQtyUnitCubit>(),
            child: InputQtyUnitDialog(
              nom: nom,
              onPressedContinue: (qty, unit) {
                onSelect(nom, qty, unit);
                onPop();
              },
            ),
          ));
}

remainingDialog(BuildContext context) {
  showModal(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<SelectNomCubit>(),
      child: Dialog(
        child: BlocBuilder<SelectNomCubit, SelectNomState>(
          builder: (context, state) {
            if (state.remaining.isEmpty) {
              return const SizedBox(
                  height: 160,
                  child: Center(child: CircularProgressIndicator()));
            }
            return SizedBox(
              height: state.remaining.length*60,
              child: ListView.builder(
                itemCount: state.remaining.length,
                itemBuilder: (context, index) {
                  final remaining = state.remaining[index];
                  return ListTile(
                    title: Text(remaining.name),
                    trailing: Text(remaining.remaining.toString()),
                  );
                },
              ),
            );
          },
        ),
      ),
    ),
  );
}
