import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';

class InputQtyUnitDialog extends StatefulWidget {
  const InputQtyUnitDialog({
    super.key,
    required this.nom,
    required this.onPressedContinue,
  });

  final dynamic nom;
  final Function(String qty, Unit unit) onPressedContinue;

  @override
  State<InputQtyUnitDialog> createState() => _InputQtyUnitDialogState();
}

class _InputQtyUnitDialogState extends State<InputQtyUnitDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<InputQtyUnitCubit>()
        .getUnits(widget.nom.ref, widget.nom.unitKey);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          _buildInputFields(context),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Text(
              widget.nom.description,
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTileImage(ref: widget.nom.ref)
        ],
      ),
    );
  }

  Widget _buildInputFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Кількість'),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: BlocBuilder<InputQtyUnitCubit, InputQtyUnitState>(
                    builder: (context, state) {
                      return TextFielButton(
                        onTap: () => _selectUnitDialog(
                            context, state.selectedUnit, state.units),
                        text: state.selectedUnit == Unit.empty
                            ? 'Відсутня'
                            : state.selectedUnit.description,
                        lableText: 'Одиниця',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<InputQtyUnitCubit, InputQtyUnitState>(
        builder: (context, state) {
          return TextButton(
            onPressed: () =>
                widget.onPressedContinue(controller.text, state.selectedUnit),
            child: const Text('Продовжити'),
          );
        },
      ),
    );
  }
}

class SelectUnitDialog extends StatelessWidget {
  const SelectUnitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      content: BlocBuilder<InputQtyUnitCubit, InputQtyUnitState>(
        builder: (context, state) {
          return SizedBox(
            height: state.units.length * 50,
            width: 400,
            child: ListView.builder(
              itemCount: state.units.length,
              itemBuilder: (context, index) {
                final unit = state.units[index];
                return ListTile(
                  leading: Radio<String>(
                      value: unit.classifierKey,
                      groupValue: state.selectedUnit.classifierKey,
                      onChanged: (value) =>
                          _onUnitSelect(context, unit.classifierKey)),
                  title: Text(unit.description),
                  trailing: Text(
                    unit.ratio.toString(),
                    style: theme.textTheme.titleSmall,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

void _selectUnitDialog(
    BuildContext context, Unit selectedUnit, List<Unit> units) {
  showModal(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<InputQtyUnitCubit>(),
      child: const SelectUnitDialog(),
    ),
  );
}

void _onUnitSelect(BuildContext context, String classifierKey) {
  context.read<InputQtyUnitCubit>().selectUnit(classifierKey);
  Navigator.pop(context);
}
