import 'package:flutter/material.dart';
import 'package:my_super_cat_app/presentation/providers/theme_notifier.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {

  static const routeName = '/settings_view';
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.appTheme.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleDarkMode();
              },
            ),
          ),
        ],
      )
    );
  }
}