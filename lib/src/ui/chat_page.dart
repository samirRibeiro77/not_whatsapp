import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';
import 'package:not_whatsapp/src/ui/chat/message_box.dart';
import 'package:not_whatsapp/src/ui/chat/messages_listview.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.contact});

  final WhatsappUser contact;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget.contact.profilePicture != null
                  ? NetworkImage(widget.contact.profilePicture ?? "")
                  : null,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(widget.contact.name!),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                MessagesListview(contact: widget.contact),
                MessageBox(contact: widget.contact),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
