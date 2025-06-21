import 'package:flutter/material.dart';

class MessagesListview extends StatefulWidget {
  const MessagesListview({super.key});

  @override
  State<MessagesListview> createState() => _MessagesListviewState();
}

class _MessagesListviewState extends State<MessagesListview> {
  final _messagesTest = [
    "Mensagem 1",
    "Mensagem 2",
    "Mensagem 3",
    "Mensagem 4",
    "Mensagem 5",
    "Mensagem 6",
    "Mensagem 7",
    "Mensagem 8",
    "Mensagem 9",
    "Mensagem 10",
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _messagesTest.length,
        itemBuilder: (context, index) {
          var maxWidth = MediaQuery.of(context).size.width * 0.8;

          return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Container(
                width: maxWidth,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xffd2ffa5),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                  _messagesTest[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
