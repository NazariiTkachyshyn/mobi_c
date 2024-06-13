import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobi_c/common/func.dart';
import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/feature/input_qty_unit/client/client.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';

import '../../input_qty_unit/ui/count_input_dialog.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InputQtyUnitCubit(InputQtyUnitClient()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CreateOrderCubit, CreateOrderState>(
            builder: (context, state) {
          return Column(
            children: [
              TextFielButton(
                prefixIcon: const Icon(Icons.search),
                text: '',
                lableText: 'Пошук',
                suffixIcon: const Icon(Icons.add),
                onTap: () {
                  Navigator.pushNamed(context, 'selectNom', arguments: {
                    "onTap": (nom, qty, unit) {
                      context
                          .read<CreateOrderCubit>()
                          .insertNom(nom, qty, unit);
                    },
                    "discount": state.discount.percentDiscounts
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: state.noms.length,
                itemBuilder: (context, index) {
                  final nom = state.noms[index];
                  return _ListTile(nom: nom);
                },
              ))
            ],
          );
        }),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final OrderNom nom;
  const _ListTile({required this.nom});

  @override
  Widget build(BuildContext context) {
    final state = context.read<CreateOrderCubit>().state;
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8)),
      child: Slidable(
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            flex: 2,
            onPressed: (value) {
              context.read<CreateOrderCubit>().deleteNom(nom.id);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Видалити',
          )
        ]),
        child: ListTile(
          visualDensity: const VisualDensity(vertical: 3),
          onTap: () {
            qtyInputDialog(
              context,
              nom,
            );
          },
          leading: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 64,
              maxHeight: 64,
            ),
            child: Image.asset('assets/38110080166432.jpeg', fit: BoxFit.cover),
          ),
          title: Text(
            nom.article,
            style: theme.textTheme.titleMedium,
          ),
          subtitle: Text(nom.description),
          trailing: SizedBox(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${nom.qty}",
                      style: theme.textTheme.labelLarge,
                    ),
                    Text(
                      nom.unitName,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${calcDiscount(nom.price, state.discount.percentDiscounts).toStringAsFixed(2)}грн.',
                      style: theme.textTheme.labelLarge,
                    ),
                    Text('${nom.price.toStringAsFixed(2)}грн.',
                        style: theme.textTheme.labelLarge!
                            .copyWith(color: Colors.grey)),
                    Text(
                        '${(calcDiscount(nom.price, state.discount.percentDiscounts) * nom.qty * nom.ratio).toStringAsFixed(2)}грн.',
                        style: theme.textTheme.labelLarge!
                            .copyWith(color: Colors.green)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

qtyInputDialog(
  BuildContext context,
  OrderNom nom,
) {
  showModal(
      context: context,
      builder: (_) => BlocProvider.value(
            value: context.read<InputQtyUnitCubit>(),
            child: InputQtyUnitDialog(
              nom: nom,
              onPressedContiniue: (qty, unit) {
                context.read<CreateOrderCubit>().updateNom(nom, qty, unit);
                Navigator.pop(context);
              },
            ),
          ));
}
