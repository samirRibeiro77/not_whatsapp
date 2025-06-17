import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:not_whatsapp/firebase_options.dart';
import 'package:not_whatsapp/src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppWidget());
}