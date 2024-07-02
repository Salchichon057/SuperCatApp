import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/presentation/pages/breeds/breeds_view.dart';
import 'package:my_super_cat_app/presentation/pages/breeds/cat_breed_detail_view.dart';
import 'package:my_super_cat_app/presentation/pages/favorites/favorites_view.dart';
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
    (context) => const BreedsView(),
    (context) => const FavoritesView(),
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
    final isThemeDark = Theme.of(context).brightness == Brightness.dark;
    final provider = Provider.of<AppNotifier>(context);
    final index = provider.currentIndex;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text(
          'Super Cat App',
          style: TextStyle(
            color: isThemeDark ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          Widget page;
          if (settings.name == SettingsView.routeName) {
            page = const SettingsView();
          } else if (settings.name == CatBreedDetailView.routeName) {
            page = CatBreedDetailView(
              breed: settings.arguments as CatBreed,
            );
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
              index == 0 ? BreedsView.routeName : FavoritesView.routeName);
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'Breeds',
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