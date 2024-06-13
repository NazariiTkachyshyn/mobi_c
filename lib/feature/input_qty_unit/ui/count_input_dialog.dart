import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';

class InputQtyUnitDialog extends StatefulWidget {
  const InputQtyUnitDialog({
    super.key,
    required this.nom,
    required this.onPressedContiniue,
  });
  final dynamic nom;
  final Function(String qty, Unit unit) onPressedContiniue;

  @override
  State<InputQtyUnitDialog> createState() => _InputQtyUnitDialogState();
}

class _InputQtyUnitDialogState extends State<InputQtyUnitDialog> {
  final controller = TextEditingController();
  @override
  void initState() {
    context
        .read<InputQtyUnitCubit>()
        .getUnits(widget.nom.ref, widget.nom.unitKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        
          SizedBox(
            height: 70,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                
                Expanded(
                  child: Text(
                    widget.nom.description,
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
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
                        decoration:
                            const InputDecoration(labelText: 'Кількість'),
                      )),
                      const Padding(padding: EdgeInsets.all(4)),
                      Expanded(
                        child:
                            BlocBuilder<InputQtyUnitCubit, InputQtyUnitState>(
                          builder: (context, state) {
                            return TextFielButton(
                                onTap: () {
                                  selectUnitDialog(
                                      context, state.selectedUnit, state.units);
                                },
                                text: state.selectedUnit == Unit.empty
                                    ? 'Відсутня'
                                    : state.selectedUnit.description,
                                lableText: 'Одиниця');
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<InputQtyUnitCubit, InputQtyUnitState>(
              builder: (context, state) {
                return TextButton(
                    onPressed: () {
                      widget.onPressedContiniue(
                          controller.text, state.selectedUnit);
                    },
                    child: const Text('Продовжити'));
              },
            ),
          )
        ],
      ),
    );
  }
}

selectUnitDialog(BuildContext context, Unit selectedUnit, List<Unit> units) {
  showModal(
      context: context,
      builder: (_) => BlocProvider.value(
            value: context.read<InputQtyUnitCubit>(),
            child: const SelectUnitDialog(),
          ));
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
            itemBuilder: (context, index) => ListTile(
              leading: Radio<String>(
                  value: state.selectedUnit.classifierKey,
                  groupValue: state.units[index].classifierKey,
                  onChanged: (value) {
                    context.read<InputQtyUnitCubit>().selectUnit(
                          state.units[index].classifierKey,
                        );
                    Navigator.pop(context);
                  }),
              title: Text(state.units[index].description),
              trailing: Text(state.units[index].ratio.toString(),style: theme.textTheme.titleSmall,),
            ),
          ),
        );
      },
    ));
  }
}
