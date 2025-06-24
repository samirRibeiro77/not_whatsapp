import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';
import 'package:not_whatsapp/src/model/message.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';

class MessagesListview extends StatefulWidget {
  const MessagesListview({super.key, required this.contact});

  final WhatsappUser contact;

  @override
  State<MessagesListview> createState() => _MessagesListviewState();
}

class _MessagesListviewState extends State<MessagesListview> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String _userId = "";

  _getUserData() {
    _userId = _auth.currentUser!.uid;
  }

  @override
  void initState() {
    super.initState();

    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _db
            .collection(FirebaseHelpers.collections.messages)
            .doc(_auth.currentUser?.uid)
            .collection(widget.contact.uid!)
            .orderBy("timestamp")
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error loading data: ${snapshot.error.toString()}",
                  ),
                );
              }

              var querySnapshot = snapshot.data!;
              var messageDocs = querySnapshot.docs.toList();

              return ListView.builder(
                itemCount: querySnapshot.docs.length,
                itemBuilder: (context, index) {
                  var maxWidth = MediaQuery.of(context).size.width * 0.8;
                  var message = Message.fromJson(messageDocs[index].data());

                  var color = _userId == message.from
                      ? Color(0xffd2ffa5)
                      : Colors.white;

                  var align = _userId == message.from
                      ? Alignment.centerRight
                      : Alignment.centerLeft;

                  return Align(
                    alignment: align,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Container(
                        width: maxWidth,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          message.message,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
