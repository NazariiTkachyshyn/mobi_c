import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/feature/input_qty_unit/ui/count_input_dialog.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

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
              onPressedContiniue: (qty, unit) {
                onSelect(nom, qty, unit);
                onPop();
              },
            ),
          ));
}
