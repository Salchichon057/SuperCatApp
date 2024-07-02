import 'package:flutter/material.dart';
import 'package:my_super_cat_app/presentation/shared/settings_view.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home_view';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Home View'),
      ),
    );
  }
}