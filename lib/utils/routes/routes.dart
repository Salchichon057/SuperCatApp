import 'package:my_super_cat_app/presentation/pages/home_view.dart';
import 'package:my_super_cat_app/presentation/pages/screen_view_02.dart';
import 'package:my_super_cat_app/presentation/shared/custom_navbar.dart';
import 'package:my_super_cat_app/presentation/shared/settings_view.dart';

final routes = {
  CustomNavbar.routeName: (context) => const CustomNavbar(),
  SettingsView.routeName: (context) => const SettingsView(),
  HomeView.routeName: (context) => const HomeView(),
  ScreenView02.routeName: (context) => const ScreenView02(),
};
