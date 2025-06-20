import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/helpers/wrapper.dart';
import 'package:not_whatsapp/src/ui/route_generator.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Not Whatsapp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(07, 94, 84, 1),
          secondary: Color.fromRGBO(18, 140, 126, 1),
          tertiary: Color.fromRGBO(37, 211, 102, 1),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(07, 94, 84, 1),
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black,
        ),
        tabBarTheme: TabBarThemeData(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white38,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: RouteGenerator.initial,
      onGenerateRoute: RouteGenerator.generateRoutes,
      home: Wrapper(),
    );
  }
}
