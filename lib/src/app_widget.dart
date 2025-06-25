import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/helpers/app_theme.dart';
import 'package:not_whatsapp/src/helpers/wrapper.dart';
import 'package:not_whatsapp/src/helpers/route_generator.dart';
import 'dart:io';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Not Whatsapp",
      debugShowCheckedModeBanner: false,
      theme: Platform.isIOS ? WhatsappTheme.iosTheme : WhatsappTheme.androidTheme,
      initialRoute: RouteGenerator.initial,
      onGenerateRoute: RouteGenerator.generateRoutes,
      home: Wrapper(),
    );
  }
}
