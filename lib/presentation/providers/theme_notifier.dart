import 'package:flutter/material.dart';
import 'package:my_super_cat_app/utils/theme/app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  AppTheme _appTheme = AppTheme();

  AppTheme get appTheme => _appTheme;

  void toggleDarkMode() {
    _appTheme = _appTheme.copyWith(isDarkMode: !_appTheme.isDarkMode);
    notifyListeners();
  }
}