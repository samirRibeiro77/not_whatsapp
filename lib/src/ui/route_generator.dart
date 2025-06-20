import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';
import 'package:not_whatsapp/src/ui/chat_page.dart';
import 'package:not_whatsapp/src/ui/home_page.dart';
import 'package:not_whatsapp/src/ui/login_page.dart';
import 'package:not_whatsapp/src/ui/registration_page.dart';
import 'package:not_whatsapp/src/ui/settings_page.dart';

class RouteGenerator {
  static const String initial = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String settings = "/settings";
  static const String chat = "/chat";

  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case settings:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case chat:
        return MaterialPageRoute(
          builder: (_) =>
              ChatPage(contact: routeSettings.arguments as WhatsappUser),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text("Page not found")),
          body: Center(child: Text("Error: Page not found")),
        );
      },
    );
  }
}
