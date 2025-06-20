import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/ui/home_page.dart';
import 'package:not_whatsapp/src/ui/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print("---  Wrapper  ---");
            print(snapshot.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            else if (snapshot.hasError) {
              return Center(child: Text("Error"));
            }
            else {
              if (snapshot.data == null) {
                return LoginPage();
              }
              else {
                return HomePage();
              }
            }
          }
      ),
    );
  }
}
