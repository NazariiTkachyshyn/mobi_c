import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            const TextField(
              decoration: InputDecoration(labelText: 'Коментар'),
            ),
            const Padding(padding: EdgeInsets.all(6)),
            Row(
              children: [
                SizedBox(
                    width: 130,
                    child: TextFielButton(
                      text: DateFormat('dd.MM.yy')
                          .format(state.order.date ?? DateTime.now()),
                      lableText: 'Доставка дата',
                      onTap: () async {
                        selectDate = await showDatePicker(
                          initialDate: DateTime.now(),
                          locale: const Locale('uk'),
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (context.mounted) {
                          context
                              .read<CreateOrderCubit>()
                              .selectDatetime(selectDate);
                        }
                      },
                    )),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: 130,
                    child: TextFielButton(
                      text: TimeOfDay.now().format(context),
                      lableText: 'Доставка час',
                      onTap: () async {
                        var a = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (context.mounted) {
                          context
                              .read<CreateOrderCubit>()
                              .selectDatetime(selectDate);
                        }
                      },
                    )),
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 6,
            ),
            Row(children: [
              Text('Самовивіз', style: theme.textTheme.titleMedium),
              Checkbox(value: true, onChanged: (value) {})
            ]),
            Text(
              'Сума ${state.summ} грн',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Знижка 0 грн',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Загальна кількість ${state.totalSumm}',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Кількість позицій ${state.noms.length}',
              style: theme.textTheme.titleMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<CreateOrderCubit>().createOrder();
                },
                child: Text('Створити'))
          ]),
        );
      },
    );
  }
}
