import 'package:animations/animations.dart';
import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
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
  DateTime? _selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
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
                      onTap: _onSelectDate)),
              const Padding(padding: EdgeInsets.all(6)),
              TextFielButton(
                text: state.counterparty.description,
                lableText: 'Клієнт',
                onTap: _onSelectCounterparty,
              ),
              const Padding(padding: EdgeInsets.all(4)),
              TextFielButton(
                text: state.contracts.isEmpty
                    ? "Відсутня"
                    : state.order.contractKey.isEmpty
                        ? state.contracts.first.description
                        : state.contracts
                            .firstWhere(
                                (e) => e.refKey == state.order.contractKey)
                            .description,
                lableText: 'Угода',
                onTap: () {
                  _selectContractDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _onSelectDate() async {
    _selectDate = await showDatePicker(
      initialDate: DateTime.now(),
      locale: const Locale('uk'),
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (mounted) {
      context.read<CreateOrderCubit>().selectDatetime(_selectDate);
    }
  }

  _onSelectCounterparty() {
    Navigator.pushNamed(context, 'selectCounterparty',
        arguments: ((Counterparty counterparty) {
          context.read<CreateOrderCubit>().selectCounterparty(counterparty);
          Navigator.pop(context);
        } as Function));
  }
}

_selectContractDialog(BuildContext context) {
  final theme = Theme.of(context);
  showModal(
      context: context,
      builder: (_) => BlocProvider.value(
            value: context.read<CreateOrderCubit>(),
            child: AlertDialog(
              content: BlocBuilder<CreateOrderCubit, CreateOrderState>(
                builder: (context, state) {
                  return state.contracts.isNotEmpty
                      ? SizedBox(
                          height: state.contracts.length * 50,
                          width: 400,
                          child: ListView.builder(
                            itemCount: state.contracts.length,
                            itemBuilder: (context, index) {
                              final contract = state.contracts[index];
                              return ListTile(
                                leading: Radio<String>(
                                    value: state.order.contractKey,
                                    groupValue: state.contracts[index].refKey,
                                    onChanged: (_) => _onSelectContract(
                                        context, contract.refKey)),
                                title: Text(state.contracts[index].description),
                              );
                            },
                          ),
                        )
                      : Text(
                          'Угода відсутня',
                          style: theme.textTheme.titleMedium,
                        );
                },
              ),
            ),
          ));
}

void _onSelectContract(BuildContext context, String refKey) {
  context.read<CreateOrderCubit>().changeContract(refKey);
  Navigator.pop(context);
}
