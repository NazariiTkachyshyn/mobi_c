import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/common/constants/const.dart';
import 'package:mobi_c/common/widgets/slidable_component.dart';
import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/feature/select_nom/ui/dialog.dart';
import 'package:mobi_c/feature/settings/cubit/settings_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class ListNomView extends StatefulWidget {
  const ListNomView(
      {super.key,
      required this.onSelect,
      required this.parentKey,
      required this.discount});
  final Function(Nom nom, String qty, Unit unit) onSelect;
  final String parentKey;
  final double discount;

  @override
  State<ListNomView> createState() => _ListNomViewState();
}

class _ListNomViewState extends State<ListNomView> {
  final scrollController = ScrollController();
  final textController = TextEditingController();
  @override
  void initState() {
    context.read<SelectNomCubit>().getNomsByParentKey(widget.parentKey);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<SelectNomCubit>().getNomsByParentKey(widget.parentKey);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SelectNomCubit, SelectNomState>(
          builder: (context, state) {
            final noms = state.searchNoms;
            return Column(
              children: [
                TextField(
                  controller: textController,
                  onChanged: (value) => context
                      .read<SelectNomCubit>()
                      .searchNomsInFolder(value, widget.parentKey),
                  decoration:
                      const InputDecoration(labelText: 'Назва або артикул'),
                ),
                const Padding(padding: EdgeInsets.all(4)),
                Expanded(
                    child: ListView.builder(
                  controller: scrollController,
                  itemCount: noms.length,
                  itemBuilder: (context, index) {
                    final nom = noms[index];
                    return SlidableComponent(
                      lable: 'Залишок на складах',
                      color: Colors.green,
                      icon: Icons.storage_rounded,
                      onPressed: (_) {
                        context.read<SelectNomCubit>().getNomRemaining(nom.ref);
                        remainingDialog(context);
                      },
                      child: _ListViewItem(
                          nom: nom,
                          onSelect: widget.onSelect,
                          discount: widget.discount),
                    );
                  },
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem(
      {required this.nom, required this.onSelect, required this.discount});
  final Nom nom;
  final Function(Nom nom, String qty, Unit unit) onSelect;
  final double discount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewType = context.read<SettingsCubit>().state.viewType;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8)),
        child: ListTile(
            visualDensity: const VisualDensity(vertical: 3),
            leading:
                viewType.isListWithIcons ? ListTileImage(ref: nom.ref) : null,
            title: Text(
              nom.article,
              style: textTheme.titleMedium,
            ),
            subtitle: Text(nom.description),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    '${numberFormat.format(calcDiscount(nom.price, discount))} грн.',
                    style: textTheme.labelLarge!.copyWith(color: Colors.black)),
                Text('${numberFormat.format(nom.price)} грн.',
                    style: textTheme.labelLarge!.copyWith(color: Colors.grey)),
                Text(
                  nom.remaining.toString(),
                  style: textTheme.labelLarge!.copyWith(color: Colors.blue),
                ),
              ],
            ),
            onTap: () => qtyInputDialog(
                context: context,
                nom: nom,
                onSelect: onSelect,
                onPop: () {
                  Navigator.pop(context);
                })));
  }
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
              height: 160,
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
