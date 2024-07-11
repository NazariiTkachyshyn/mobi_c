import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mobi_c/common/ui/widgets/widget.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/order_repo.dart';
import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/services/data_base/object_box/models/order.dart';
import 'package:mobi_c/services/data_base/object_box/object_box.dart';
import 'package:mobi_c/services/data_sync_service/models/order.dart';
import 'package:mobi_c/services/geo_location/send_location.dart';

class AtherView extends StatefulWidget {
  const AtherView({super.key});

  @override
  State<AtherView> createState() => _AtherViewState();
}

class _AtherViewState extends State<AtherView> {
  DateTime? selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              onChanged: (value) =>
                  context.read<CreateOrderCubit>().writeComment(value),
              decoration: const InputDecoration(labelText: 'Коментар'),
            ),
            const Padding(padding: EdgeInsets.all(6)),
            const SizedBox(
              height: 6,
            ),
            Row(children: [
              Text('Самовивіз', style: theme.textTheme.titleMedium),
              Checkbox(
                  value: state.order.pickup,
                  onChanged: (value) {
                    context.read<CreateOrderCubit>().changePickup();
                  })
            ]),
            Text(
              'Сума ${state.discountedSumm.toStringAsFixed(2)} грн',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Знижка ${state.discountInHrn.toStringAsFixed(2)} грн',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Загальна кількість ${state.totalQty}',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Кількість позицій ${state.noms.length}',
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => showCheckDialog(
                  context,
                  title: 'Створити замовлення',
                  description:
                      'Ви впевнені, що хочете створити нове замовлення?',
                  acceptLable: 'Так, створити',
                  cancelLable: 'Скасувати',
                  onPressedAccept: () async {
                    context.read<CreateOrderCubit>().createOrder();
                    Navigator.pop(context);
                    //var loc = await LocationService.getCurrentLocation();
                    //await LocationService.sendToFirebase(loc);
                  },
                ),
                child: const Text('Створити замовлення'),
              ),
            ),
          ]),
        );
      },
    );
  }
}
