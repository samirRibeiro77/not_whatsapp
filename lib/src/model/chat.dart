import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:not_whatsapp/src/helpers/firebase.dart';

class Chat {
  late String from;
  late String to;
  late String userPicture;
  late String name;
  late final String _lastMessage;
  late final String _type;

  Chat({
    required this.from,
    required this.to,
    required this.userPicture,
    required this.name,
    required String lastMessage,
    required String type
  }) {
    _lastMessage = lastMessage;
    _type = type;
  }

  Chat.fromJson(Map<String, dynamic> json) {
    from = json["from"];
    to = json["to"];
    userPicture = json["userPicture"];
    name = json["name"];
    _lastMessage = json["lastMessage"];
    _type = json["type"];
  }

  Chat.fromDocument(QueryDocumentSnapshot json) {
    from = json["from"];
    to = json["to"];
    userPicture = json["userPicture"];
    name = json["name"];
    _lastMessage = json["lastMessage"];
    _type = json["type"];
  }

  void save() async {
    await FirebaseFirestore.instance
        .collection(FirebaseHelpers.collections.chats)
        .doc(from)
        .collection(FirebaseHelpers.collections.lastChat)
        .doc(to)
        .set(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      "from": from,
      "to": to,
      "name": name,
      "lastMessage": _lastMessage,
      "type": _type,
      "userPicture": userPicture,
    };
  }

  String get lastMessage => _lastMessage;

  String get type => _type;
}
