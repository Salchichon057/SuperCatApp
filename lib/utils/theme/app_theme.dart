import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = false,
  });

  ThemeData getTheme() => ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.cyan,
        appBarTheme: const AppBarTheme(centerTitle: false),
        filledButtonTheme :  FilledButtonThemeData(
          style: ButtonStyle(
            // Si estás en una versión anterior, usa MaterialStateProperty.all en lugar de WidgetStateProperty.all
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      );

  AppTheme copyWith({
    bool? isDarkMode,
  }) =>
      AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}