import 'package:flutter/material.dart';
import 'package:my_super_cat_app/presentation/pages/home_view.dart';
import 'package:my_super_cat_app/presentation/pages/screen_view_02.dart';
import 'package:my_super_cat_app/presentation/providers/app_notifier.dart';
import 'package:my_super_cat_app/presentation/shared/settings_view.dart';
import 'package:provider/provider.dart';

import 'package:animate_do/animate_do.dart';

class CustomNavbar extends StatefulWidget {
  static const routeName = '/custom_navbar';

  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  final List<WidgetBuilder> screens = [
    (context) => const HomeView(),
    (context) => const ScreenView02(),
  ];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic> _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeIn(
          duration: const Duration(milliseconds: 100),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final provider = Provider.of<AppNotifier>(context);
    final index = provider.currentIndex;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const Text('Mi Aplicación', style: TextStyle(color: Colors.white)),
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          Widget page;
          if (settings.name == SettingsView.routeName) {
            page = const SettingsView();
          } else {
            final index = provider.currentIndex;
            page = screens[index](context);
          }
          return _createRoute(page);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (index) {
          provider.changeIndex(index);
          _navigatorKey.currentState!.pushReplacementNamed(
              index == 0 ? HomeView.routeName : ScreenView02.routeName);
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.post_add_outlined),
            activeIcon: const Icon(Icons.post_add_rounded),
            label: 'Post',
            backgroundColor: colors.primary,
          ),
        ],
      ),
    );
  }
}
