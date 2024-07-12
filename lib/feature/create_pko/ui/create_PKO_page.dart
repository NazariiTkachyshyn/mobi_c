import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobi_c/feature/create_order/create_order_client/cerate_order_client.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/feature/create_pko/cubit/create_pko_cubit.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/services/data_base/object_box/models/counterparty.dart';

class CreatePKOPage extends StatelessWidget {
  const CreatePKOPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePKOCubit(CreateOrderRepoImpl(
        createOrderClient: CreateOrderClient(),
      )),
      child: const _CreatePKOPage(),
    );
  }
}

class _CreatePKOPage extends StatefulWidget {
  const _CreatePKOPage();

  @override
  State<_CreatePKOPage> createState() => _CreatePKOPageState();
}

class _CreatePKOPageState extends State<_CreatePKOPage> {
  DateTime? _selectDate = DateTime.now();
  void initState() {
    context.read<CreatePKOCubit>().selectDatetime(DateTime.now());
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return await showCheckDialog(
          context,
          onPressedAccept: () {
            Navigator.pop(context, true);
          },
          title: 'Закрити замовлення',
          description: 'Ви впевнені, що хочете закрити замовлення?',
        ) ??
        false;
  }

  String currentValue = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            onPressed: () => showCheckDialog(
              context,
              onPressedAccept: () => Navigator.pop(context),
              title: 'Закрити замовлення',
              description: 'Ви впевнені, що хочете закрити замовлення?',
            ),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('ПКО'),
        ),
        body: BlocBuilder<CreatePKOCubit, CreatePKOState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(4)),
                  SizedBox(
                      width: 130,
                      child: TextFielButton(
                          text: DateFormat('dd.MM.yy')
                              .format(state.selectedDate ?? DateTime.now()),
                          lableText: 'Дата',
                          onTap: _onSelectDate)),
                  const Padding(padding: EdgeInsets.all(6)),
                  TextFielButton(
                    text: state.counterparty.description,
                    lableText: 'Клієнт',
                    onTap: _onSelectCounterparty,
                  ),
                  SizedBox(
                    height: 30,
                    child:
                        Text(context.read<CreatePKOCubit>().getDescription()),
                  ),
                  const Padding(padding: EdgeInsets.all(6)),
                  TextFielButton(
                    text: state.contracts.isEmpty
                        ? "Відсутній"
                        : state.order.contractKey.isEmpty
                            ? state.contracts.first.description
                            : state.contracts
                                .firstWhere(
                                    (e) => e.refKey == state.order.contractKey)
                                .description,
                    lableText: 'Договір', //Угода
                    onTap: () {
                      _selectContractDialog(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(6)),
                  SizedBox(
                      width: 200,
                      child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('Сума'),
                            hintText: '0,00',
                          ),
                          onChanged: (value) {
                            currentValue = value;
                            context
                                .read<CreatePKOCubit>()
                                .setSum(double.parse(currentValue));
                          },
                          onEditingComplete: () {
                            context
                                .read<CreatePKOCubit>()
                                .setSum(double.parse(currentValue));
                          })),
                  const Padding(padding: EdgeInsets.all(6)),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Коментар'),
                    ),
                    onTap: () {},
                  ),
                  const Padding(padding: EdgeInsets.all(6)),
                  const Spacer(), // Додаємо Spacer для заповнення простору
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: FilledButton(
                        onPressed: () async {
                          // Ваш код для кнопки
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.ios_share),
                            Padding(padding: EdgeInsets.all(6)),
                            Text('Вивантажити'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
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
      context.read<CreatePKOCubit>().selectDatetime(_selectDate);
    }
  }

  _onSelectCounterparty() {
    Navigator.pushNamed(context, 'selectCounterparty',
        arguments: ((Counterparty counterparty) {
          context.read<CreatePKOCubit>().selectCounterparty(counterparty);
          Navigator.pop(context);
        } as Function));
  }

  _selectContractDialog(BuildContext context) {
    final theme = Theme.of(context);
    showModal(
        context: context,
        builder: (_) => BlocProvider.value(
              value: context.read<CreatePKOCubit>(),
              child: AlertDialog(
                content: BlocBuilder<CreatePKOCubit, CreatePKOState>(
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
                                  title:
                                      Text(state.contracts[index].description),
                                );
                              },
                            ),
                          )
                        : Text(
                            'Договір відсутній',
                            style: theme.textTheme.titleMedium,
                          );
                  },
                ),
              ),
            ));
  }

  void _onSelectContract(BuildContext context, String refKey) {
    context.read<CreatePKOCubit>().changeContract(refKey);
    Navigator.pop(context);
  }
}
