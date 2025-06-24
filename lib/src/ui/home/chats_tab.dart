import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/model/chat.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({super.key});

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  final List<Chat> _chats = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        var chat = _chats[index];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(chat.userPicture),
          ),
          title: Text(
            chat.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          subtitle: Text(
            chat.lastMessage,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 14
            ),
          ),
        );
      },
    );
  }
}
