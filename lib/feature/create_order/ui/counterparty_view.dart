import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/models/counterparty.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CounterpartyView extends StatefulWidget {
  const CounterpartyView({super.key});

  @override
  State<CounterpartyView> createState() => _CounterpartyViewState();
}

class _CounterpartyViewState extends State<CounterpartyView> {
  DateTime? selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(4)),
              SizedBox(
                  width: 130,
                  child: TextFielButton(
                    text: DateFormat('dd.MM.yy')
                        .format(state.order.date ?? DateTime.now()),
                    lableText: 'Дата',
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
              const Padding(padding: EdgeInsets.all(6)),
              TextFielButton(
                text: state.counterparty.description,
                lableText: 'Клієнт',
                onTap: () {
                  Navigator.pushNamed(context, 'selectCounterparty',
                      arguments: ((Counterparty counterparty) {
                        context
                            .read<CreateOrderCubit>()
                            .selectCounterparty(counterparty);
                        Navigator.pop(context);
                      } as Function));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
