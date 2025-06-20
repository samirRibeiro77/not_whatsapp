import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';
import 'package:not_whatsapp/src/ui/chat/message_box.dart';

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
      appBar: AppBar(title: Text(widget.contact.name!)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover
          ),
        ),
        child: SafeArea(
          child: Container(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Text("Mensagens..."),
                MessageBox()
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
