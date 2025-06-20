import 'package:flutter/material.dart';
import 'package:not_whatsapp/src/model/chat.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({super.key});

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  final List<Chat> _chats = [
    Chat(
      "Vanessa",
      "Ultima mensagem",
      "https://firebasestorage.googleapis.com/v0/b/flutter-first-app-sjr77.firebasestorage.app/o/whatsapp%2FuserProfile%2Fperfil1.jpg?alt=media&token=f9d44c8c-92d0-4502-aa5f-93bbaeb83034",
    ),
    Chat(
      "João",
      "Ultima mensagem",
      "https://firebasestorage.googleapis.com/v0/b/flutter-first-app-sjr77.firebasestorage.app/o/whatsapp%2FuserProfile%2Fperfil2.jpg?alt=media&token=a1753c35-131a-4036-a56a-1e6c1f7ce2ee",
    ),
    Chat(
      "Beatriz",
      "Ultima mensagem",
      "https://firebasestorage.googleapis.com/v0/b/flutter-first-app-sjr77.firebasestorage.app/o/whatsapp%2FuserProfile%2Fperfil3.jpg?alt=media&token=e68c97da-1945-4b4f-b201-a072282904c8",
    ),
    Chat(
      "Caio",
      "Ultima mensagem",
      "https://firebasestorage.googleapis.com/v0/b/flutter-first-app-sjr77.firebasestorage.app/o/whatsapp%2FuserProfile%2Fperfil4.jpg?alt=media&token=d040390f-af48-46f5-b9c1-79ce19332224",
    ),
    Chat(
      "Jamilton",
      "Ultima mensagem",
      "https://firebasestorage.googleapis.com/v0/b/flutter-first-app-sjr77.firebasestorage.app/o/whatsapp%2FuserProfile%2Fperfil5.jpg?alt=media&token=a51de80c-0055-4af8-ad77-bf232ac4f888",
    ),
  ];

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
