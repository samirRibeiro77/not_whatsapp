import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/ui/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Not Whatsapp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(07, 94, 84, 1)),
      ),
      home: LoginPage(),
    );
  }
}