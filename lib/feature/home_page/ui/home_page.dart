import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/common/config/cubit/config_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ConfigCubit>().getConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SalesMaster'),
        actions: [Text('User')],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                
                children: [
                  InkWell(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: Image.asset('assets/icons/order.png'),
                          ),
                          const Text('Замовлення')
                        ],
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, 'createOrderPage'))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 90,
                          height: 90,
                          child: Image.asset('assets/icons/settings2.png'),
                        ),
                        const Text('Налаштування')
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(context, 'settings'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
