import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';
import 'package:not_whatsapp/src/ui/route_generator.dart';

class ContactsTab extends StatefulWidget {
  const ContactsTab({super.key});

  @override
  State<ContactsTab> createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<List<WhatsappUser>> _getContacts() async {
    var currentEmail = _auth.currentUser?.email;

    var querySnapshot = await _db
        .collection(FirebaseHelpers.collections.user)
        .get();
    List<WhatsappUser> contacts = [];

    for (var snapshot in querySnapshot.docs) {
      var contact = WhatsappUser.fromJson(snapshot.data(), uid: snapshot.id);
      if (contact.email == currentEmail) continue;

      contacts.add(contact);
    }

    return contacts;
  }

  _openChat(WhatsappUser contact) {
    Navigator.pushNamed(context, RouteGenerator.chat, arguments: contact);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getContacts(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var contactList = snapshot.data;
                var contact = contactList?[index];

                return ListTile(
                  onTap: () => _openChat(contact!),
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: contact?.profilePicture != null
                        ? NetworkImage(contact?.profilePicture ?? "")
                        : null,
                  ),
                  title: Text(
                    contact?.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
