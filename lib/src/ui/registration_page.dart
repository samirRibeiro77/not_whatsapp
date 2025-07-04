import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';
import 'package:not_whatsapp/src/helpers/validator.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';
import 'package:not_whatsapp/src/helpers/route_generator.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _errorMessage = "";
  bool _passwordObscure = true;

  _createUser() {
    _errorMessage = "";

    var user = WhatsappUser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _errorMessage = Validator.validateUser(user);
    });

    if (_errorMessage.isNotEmpty) {
      return;
    }

    _auth
        .createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        )
        .then((firebaseUser) {
          _saveUserData(firebaseUser: firebaseUser.user!, whatsappUser: user);

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteGenerator.home,
            (_) => false,
          );
        })
        .catchError((e) {
          setState(() {
            _errorMessage = "Error creating user: ${e.toString()}";
          });
        });
  }

  _saveUserData({
    required User firebaseUser,
    required WhatsappUser whatsappUser,
  }) {
    _db
        .collection(FirebaseHelpers.collections.user)
        .doc(firebaseUser.uid)
        .set(whatsappUser.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/images/usuario.png",
                  width: 200,
                  height: 150,
                ),
                SizedBox(child: Container(height: 32)),
                TextField(
                  autofocus: true,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                SizedBox(child: Container(height: 8)),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "E-mail",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                SizedBox(child: Container(height: 8)),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _passwordObscure,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordObscure = !_passwordObscure;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(child: Container(height: 16)),
                ElevatedButton(
                  onPressed: _createUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(child: Container(height: 32)),
                Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
