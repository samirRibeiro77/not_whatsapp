import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;

  var _userEmail = "";

  _getUserData() {
    var user = _auth.currentUser;

    setState(() {
      _userEmail = user?.email ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Whatsapp"),
      ),
      body: Container(
        child: Text(_userEmail),
      ),
    );
  }
}
