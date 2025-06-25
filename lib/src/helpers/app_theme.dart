import 'package:flutter/material.dart';

class WhatsappTheme {
  static ThemeData get androidTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromRGBO(07, 94, 84, 1),
      secondary: Color.fromRGBO(18, 140, 126, 1),
      tertiary: Color.fromRGBO(37, 211, 102, 1),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(07, 94, 84, 1),
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: Colors.black,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white38,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(18, 140, 126, 1),
        foregroundColor: Colors.white
    ),
  );

  static ThemeData get iosTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromRGBO(07, 94, 84, 1),
      secondary: Color.fromRGBO(18, 140, 126, 1),
      tertiary: Color.fromRGBO(37, 211, 102, 1),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[200],
      foregroundColor: Colors.black,
      elevation: 0,
      shadowColor: Colors.black,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: Colors.grey[400],
      labelColor: Colors.grey[400],
      unselectedLabelColor: Colors.white38,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromRGBO(18, 140, 126, 1),
        foregroundColor: Colors.white
    ),
  );
}