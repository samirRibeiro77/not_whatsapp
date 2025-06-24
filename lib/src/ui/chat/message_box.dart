import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';
import 'package:not_whatsapp/src/model/message.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({super.key, required this.contact});

  final WhatsappUser contact;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance.ref(
    FirebaseHelpers.storage.messagePicture,
  );
  final _picker = ImagePicker();

  final _messageController = TextEditingController();

  String _userId = "";
  bool _uploadingFile = false;

  _getUserData() {
    _userId = _auth.currentUser!.uid;
  }

  _prepareToSendMessage() {
    if (_messageController.text.isEmpty) {
      return;
    }

    var message = Message.text(
      _userId,
      widget.contact.uid!,
      _messageController.text,
    );

    _sendMessage(message.from, message.to, message);
    _sendMessage(message.to, message.from, message);
    _messageController.clear();
  }

  _sendMessage(String from, String to, Message msg) {
    _db
        .collection(FirebaseHelpers.collections.messages)
        .doc(from)
        .collection(to)
        .add(msg.toJson());
  }

  _sendPicture() async {
    var selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    var imgName = DateTime.now().millisecondsSinceEpoch.toString();
    var task = _storage
        .child(_userId)
        .child("$imgName.jpg")
        .putFile(File(selectedImage!.path));

    task.snapshotEvents.listen((storageEvent) async {
      if (storageEvent.state == TaskState.running) {
        setState(() {
          _uploadingFile = true;
        });
      } else if (storageEvent.state == TaskState.success) {
        var url = await task.snapshot.ref.getDownloadURL();

        var message = Message.media(_userId, widget.contact.uid!, url);

        _sendMessage(message.from, message.to, message);
        _sendMessage(message.to, message.from, message);

        setState(() {
          _uploadingFile = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _messageController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                  hintText: "Type your message...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  prefixIcon: IconButton(
                    onPressed: _sendPicture,
                    icon: _uploadingFile
                        ? CircularProgressIndicator()
                        : Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: _prepareToSendMessage,
            mini: true,
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
