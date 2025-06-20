import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';
import 'package:not_whatsapp/src/model/whatsapp_user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance.ref(
    FirebaseHelpers.storage.userProfile,
  );

  final _picker = ImagePicker();
  final _nameController = TextEditingController();

  WhatsappUser? user;
  XFile? _selectedImage;
  String _profilePictureUrl = "";
  bool _uploadingFile = false;

  _selectImage({bool fromCamera = true}) async {
    final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
    _selectedImage = await _picker.pickImage(source: source);
    _uploadImage();
  }

  _getUserData() async {
    var userId = _auth.currentUser!.uid;
    var userJson = await _db
        .collection(FirebaseHelpers.collections.user)
        .doc(userId)
        .get();

    user = WhatsappUser.fromJson(userJson.data()!, uid: userId);

    setState(() {
      _nameController.text = user?.name ?? "";
      _profilePictureUrl = user?.profilePicture ?? "";
    });
  }

  _uploadImage() {
    var task = _storage
        .child("${user?.uid}.jpg")
        .putFile(File(_selectedImage!.path));

    task.snapshotEvents.listen((storageEvent) async {
      if (storageEvent.state == TaskState.running) {
        setState(() {
          _uploadingFile = true;
        });
      } else if (storageEvent.state == TaskState.success) {
        var url = await task.snapshot.ref.getDownloadURL();
        user!.profilePicture = url;

        _updateUser();

        setState(() {
          _profilePictureUrl = url;
          _uploadingFile = false;
        });
      }
    });
  }

  _updateUser() {
    user!.name = _nameController.text;

    _db.collection(FirebaseHelpers.collections.user)
        .doc(user!.uid)
        .update(user!.toJson());
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Settings")),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: _uploadingFile ? CircularProgressIndicator() : Container(),
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: _profilePictureUrl.isNotEmpty
                      ? NetworkImage(_profilePictureUrl)
                      : null,
                  backgroundColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => _selectImage(),
                      child: Text("Camera"),
                    ),
                    TextButton(
                      onPressed: () => _selectImage(fromCamera: false),
                      child: Text("Gallery"),
                    ),
                  ],
                ),
                TextField(
                  autofocus: true,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                SizedBox(child: Container(height: 10)),
                ElevatedButton(
                  onPressed: _updateUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
