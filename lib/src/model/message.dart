import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String _from, _to, _type;
  late Timestamp _timestamp;
  String? _message, _mediaUrl;

  Message.text(this._from, this._to, this._message) {
    _type = "text";
    _timestamp = Timestamp.now();
  }

  Message.media(this._from, this._to, this._mediaUrl) {
    _type = "media";
    _timestamp = Timestamp.now();
  }

  Message.fromJson(Map<String, dynamic> json) {
    _from = json["from"];
    _message = json["message"];
    _mediaUrl = json["mediaUrl"];
    _type = json["type"];
    _timestamp = json["timestamp"];
  }

  Message.fromDocument(QueryDocumentSnapshot json) {
    _from = json["from"];
    _message = json["message"];
    _mediaUrl = json["mediaUrl"];
    _type = json["type"];
    _timestamp = json["timestamp"];
  }

  Map<String, dynamic> toJson() {
    return {
      "from": _from,
      "message": _message,
      "mediaUrl": _mediaUrl,
      "type": _type,
      "timestamp": _timestamp
    };
  }

  String get from => _from;

  String get to => _to;

  String get type => _type;

  String get message => _message ?? "";

  String get mediaUrl => _mediaUrl ?? "";

  Timestamp get timestamp => _timestamp;
}
