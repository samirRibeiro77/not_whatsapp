import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/ui/home/chats_tab.dart';
import 'package:not_whatsapp/src/ui/home/contacts_tab.dart';
import 'package:not_whatsapp/src/ui/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  late final TabController _tabController;

  final List<String> _menuItems = ["Settings", "Logout"];

  _getUserData() {
    var user = _auth.currentUser;
  }

  _menuChoice(String menu) {
    switch (menu) {
      case "Settings":
        print("Settings");
        break;
      case "Logout":
        _logout();
        break;
    }
  }

  _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Whatsapp"),
        actions: [
          PopupMenuButton<String>(
            onSelected: _menuChoice,
            itemBuilder: (context) {
              return _menuItems.map((menuItem) {
                return PopupMenuItem(value: menuItem, child: Text(menuItem));
              }).toList();
            },
          ),
        ],
        bottom: TabBar(
          indicatorWeight: 4.0,
          controller: _tabController,
          tabs: [
            Tab(text: "Chats"),
            Tab(text: "Contacts"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [ChatsTab(), ContactsTab()],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
