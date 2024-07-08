import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SalesMaster'),
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
                        Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue, // Ваш колір круга
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.print,
                              size: 50, // Розмір іконки
                              color:
                                  Colors.white, // Колір іконки всередині круга
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 8), // Проміжок між іконкою і текстом
                        const Text('Пко', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(context, 'createPKO'),
                  )
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
