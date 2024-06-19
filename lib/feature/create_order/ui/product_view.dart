import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/feature/input_qty_unit/client/client.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/feature/input_qty_unit/ui/count_input_dialog.dart';
import 'package:mobi_c/feature/settings/cubit/settings_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';

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
                _buildSearchField(context, state),
                const SizedBox(height: 5),
                _buildNomsList(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, CreateOrderState state) {
    return TextFielButton(
      prefixIcon: const Icon(Icons.search),
      lableText: 'Пошук',
      suffixIcon: const Icon(Icons.add),
      onTap: () =>
          _navigateToSelectNom(context, state.discount.percentDiscounts),
    );
  }

  Widget _buildNomsList(CreateOrderState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.noms.length,
        itemBuilder: (context, index) {
          final nom = state.noms[index];
          return _ListViewItem(nom: nom);
        },
      ),
    );
  }

  void _navigateToSelectNom(BuildContext context, double discount) {
    Navigator.pushNamed(context, 'selectNom', arguments: {
      "onTap": (nom, qty, unit) {
        context.read<CreateOrderCubit>().insertNom(nom, qty, unit);
      },
      "discount": discount,
    });
  }
}

class _ListViewItem extends StatelessWidget {
  final OrderNom nom;
  const _ListViewItem({required this.nom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8)),
      child: _SlidableComponent(nom: nom, child: _ListTileComponent(nom: nom)),
    );
  }
}

class _SlidableComponent extends StatelessWidget {
  const _SlidableComponent({required this.nom, required this.child});
  final OrderNom nom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ActionPane actionPane(OrderNom nom) {
      return ActionPane(motion: const DrawerMotion(), children: [
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
      ]);
    }

    return Slidable(endActionPane: actionPane(nom), child: child);
  }
}

class _ListTileComponent extends StatelessWidget {
  const _ListTileComponent({required this.nom});
  final OrderNom nom;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.read<CreateOrderCubit>().state;

    return ListTile(
      visualDensity: const VisualDensity(vertical: 3),
      onTap: () {
        qtyInputDialog(
          context,
          nom,
        );
      },
      contentPadding: const EdgeInsets.fromLTRB(0, 8, 15, 8),
      minLeadingWidth: 0,
      leading: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previous, current) => previous.viewType != current.viewType,
        builder: (context, settingsState) {
          return settingsState.viewType.isListWithIcons
              ? ListTileImage(ref: nom.ref)
              : const SizedBox.shrink();
        },
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${numberFormat.format(calcDiscount(nom.price, state.discount.percentDiscounts))}грн.',
                  style: theme.textTheme.labelLarge,
                ),
                Text('${numberFormat.format(nom.price)}грн.',
                    style: theme.textTheme.labelLarge!
                        .copyWith(color: Colors.grey)),
                Text(
                    '${numberFormat.format((calcDiscount(nom.price, state.discount.percentDiscounts) * nom.qty * nom.ratio))}грн.',
                    style: theme.textTheme.labelLarge!
                        .copyWith(color: Colors.green)),
              ],
            )
          ],
        ),
      ),
    );
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
              onPressedContinue: (qty, unit) {
                context.read<CreateOrderCubit>().updateNom(nom, qty, unit);
                Navigator.pop(context);
              },
            ),
          ));
}
