import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/feature/select_nom/ui/dialog.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class ListNomView extends StatefulWidget {
  const ListNomView(
      {super.key,
      required this.onSelect,
      required this.parentKey,
      required this.discount});
  final Function(Nom nom, String qty, Unit init) onSelect;
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
                      nom: nom,
                      onSelect: widget.onSelect,
                      child: ListViewItem(
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

class SlidableComponent extends StatelessWidget {
  const SlidableComponent(
      {super.key,
      required this.nom,
      required this.onSelect,
      required this.child});
  final Nom nom;
  final Function(Nom nom, String qty, Unit init) onSelect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ActionPane actionPane(Nom nom) {
      return ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          flex: 2,
          onPressed: (value) => qtyInputDialog(
              context: context,
              nom: nom,
              onSelect: onSelect,
              onPop: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.add,
          label: 'Додати',
        )
      ]);
    }

    return Slidable(
        endActionPane: actionPane(nom),
        startActionPane: actionPane(nom),
        child: child);
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem(
      {super.key,
      required this.nom,
      required this.onSelect,
      required this.discount});
  final Nom nom;
  final Function(Nom nom, String qty, Unit init) onSelect;
  final double discount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8)),
        child: ListTile(
            visualDensity: const VisualDensity(vertical: 3),
            leading: ListTileImage(ref: nom.ref),
            title: Text(
              nom.article,
              style: textTheme.titleMedium,
            ),
            subtitle: Text(nom.description),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    '${calcDiscount(nom.price, discount).toStringAsFixed(2)} грн.',
                    style: textTheme.labelLarge!.copyWith(color: Colors.black)),
                Text('${nom.price.toStringAsFixed(2)} грн.',
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
                  Navigator.pop(context);
                })));
  }
}
