import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Налаштування'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
            child: Text(
              'Основні',
              style: theme.textTheme.titleMedium,
            ),
          ),
          
          ListTile(
              leading: const Icon(Icons.sync),
              title: const Text('Синхронізація'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Navigator.pushNamed(context, 'sync')),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            leading: const Icon(Icons.person_search_outlined),
            title: const Text('Налаштування маршрутів'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () =>
                Navigator.pushNamed(context, 'settings_counterparty_view'),
          ),
        ],
      ),
    );
  }
}
