import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';

import '../../../models/models.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CreateOrderCubit, CreateOrderState>(
          builder: (context, state) {
        return Column(
          children: [
            TextFielButton(
              prefixIcon: const Icon(Icons.search),
              text: '',
              lableText: 'Пошук',
              onTap: () {
                Navigator.pushNamed(context, 'selectNom', arguments: {
                  "onTap": (nom) {
                    context.read<CreateOrderCubit>().insertNom(nom);
                    Navigator.pop(context);
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
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8)),
                  child: Slidable(
                    endActionPane:
                        ActionPane(motion: const DrawerMotion(), children: [
                      SlidableAction(
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(8)),
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
                      onTap: () {
                        changeQtydialog(context, nom);
                      },
                      title: Text(nom.description),
                      subtitle: Text(nom.article),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(nom.qty.toString() + " шт."),
                            Text(nom.price.toStringAsFixed(2) + 'грн.')
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        );
      }),
    );
  }
}

changeQtydialog(BuildContext context, OrderNom nom) {
  final controller = TextEditingController();
  showModal(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<CreateOrderCubit>(),
      child: Dialog(
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
                      nom.description,
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
                        const Expanded(
                            child: TextFielButton(
                                text: 'шт', lableText: 'Одиниця'))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    context
                        .read<CreateOrderCubit>()
                        .changeQty(nom, controller.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Оновити')),
            )
          ],
        ),
      ),
    ),
  );
}
