import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';
import 'package:not_whatsapp/src/model/chat.dart';
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

  WhatsappUser _currentUser = WhatsappUser();
  bool _uploadingFile = false;

  _getUserData() async {
    var userId = _auth.currentUser!.uid;
    var userJson = await _db
        .collection(FirebaseHelpers.collections.user)
        .doc(userId)
        .get();

    _currentUser = WhatsappUser.fromJson(userJson.data()!, uid: userId);
  }

  _sendText() {
    if (_messageController.text.isEmpty) {
      return;
    }

    var message = Message.text(
      _currentUser.uid!,
      widget.contact.uid!,
      _messageController.text,
    );

    _sendMessage(message.from, message.to, message);
    _sendMessage(message.to, message.from, message);
    _messageController.clear();
  }

  _sendPicture() async {
    var selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    var imgName = DateTime.now().millisecondsSinceEpoch.toString();
    var task = _storage
        .child(_currentUser.uid!)
        .child("$imgName.jpg")
        .putFile(File(selectedImage!.path));

    task.snapshotEvents.listen((storageEvent) async {
      if (storageEvent.state == TaskState.running) {
        setState(() {
          _uploadingFile = true;
        });
      } else if (storageEvent.state == TaskState.success) {
        var url = await task.snapshot.ref.getDownloadURL();

        var message = Message.media(_currentUser.uid!, widget.contact.uid!, url);

        _sendMessage(message.from, message.to, message);
        _sendMessage(message.to, message.from, message);

        setState(() {
          _uploadingFile = false;
        });
      }
    });
  }

  _sendMessage(String from, String to, Message msg) {
    _db
        .collection(FirebaseHelpers.collections.messages)
        .doc(from)
        .collection(to)
        .add(msg.toJson());

    _saveChat(msg);
  }

  _saveChat(Message message) {
    var chatFrom = Chat(
      from: message.from,
      to: message.to,
      name: widget.contact.name ?? "",
      userPicture: widget.contact.profilePicture ?? "",
      lastMessage: message.message,
      type: message.type,
     );
    chatFrom.save();

    var chatTo = Chat(
      from: message.to,
      to: message.from,
      name: _currentUser.name!,
      userPicture: _currentUser.profilePicture!,
      lastMessage: message.message,
      type: message.type,
    );
    chatTo.save();
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
            onPressed: _sendText,
            mini: true,
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
