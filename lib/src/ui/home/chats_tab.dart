import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';
import 'package:not_whatsapp/src/model/chat.dart';
import 'package:not_whatsapp/src/ui/route_generator.dart';

import '../../model/whatsapp_user.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({super.key});

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final _streamController = StreamController<QuerySnapshot>.broadcast();
  WhatsappUser _currentUser = WhatsappUser();

  _chatsListener() {
    final stream = _db
        .collection(FirebaseHelpers.collections.chats)
        .doc(_currentUser.uid)
        .collection(FirebaseHelpers.collections.lastChat)
        .snapshots();

    stream.listen((data) {
      _streamController.add(data);
    });
  }

  _initData() async {
    var userId = _auth.currentUser!.uid;
    var userJson = await _db
        .collection(FirebaseHelpers.collections.user)
        .doc(userId)
        .get();

    _currentUser = WhatsappUser.fromJson(userJson.data()!, uid: userId);

    _chatsListener();
  }

  @override
  void initState() {
    super.initState();

    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text("Error loading chats"));
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No chats yet :(",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            var chats = snapshot.data!.docs;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                var chat = Chat.fromDocument(chats[index]);

                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouteGenerator.chat,
                    arguments: WhatsappUser(
                      uid: chat.to,
                      name: chat.name,
                      profilePicture: chat.userPicture,
                    ),
                  ),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(chat.userPicture),
                  ),
                  title: Text(
                    chat.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    chat.type == "text" ? chat.lastMessage : "Image...",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                );
              },
            );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }
}
