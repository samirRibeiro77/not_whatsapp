import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _picker = ImagePicker();
  final _nameController = TextEditingController();

  XFile? _selectedImage;

  Future _recoveryImage({bool fromCamera = true}) async {
    final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
    _selectedImage = await _picker.pickImage(source: source);
    setState(() {});
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
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/flutter-first-app-sjr77.firebasestorage.app/o/whatsapp%2FuserProfile%2Fperfil5.jpg?alt=media&token=a51de80c-0055-4af8-ad77-bf232ac4f888",
                  ),
                  backgroundColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () => _recoveryImage(), child: Text("Camera")),
                    TextButton(onPressed: () => _recoveryImage(fromCamera: false), child: Text("Gallery")),
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
                  onPressed: () {},
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
