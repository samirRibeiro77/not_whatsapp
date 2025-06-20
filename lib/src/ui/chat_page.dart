import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';

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
        title: Text(widget.contact.name!),
      ),
      body: Container(),
    );
  }
}
