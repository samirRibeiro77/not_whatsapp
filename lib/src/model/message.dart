class Message {
  late String _from, _to, _type;
  String? _message, _mediaUrl;

  Message.text(this._from, this._to, this._message) {
    _type = "text";
  }

  Message.media(this._from, this._to, this._mediaUrl) {
    _type = "media";
  }

  Message.fromJson(Map<String, dynamic> json) {
    _from = json["from"];
    _message = json["message"];
    _mediaUrl = json["mediaUrl"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    return {
      "from": _from,
      "message": _message,
      "mediaUrl": _mediaUrl,
      "type": _type,
    };
  }

  String get from => _from;

  String get to => _to;

  String get type => _type;

  String get message => _message ?? "";

  String get mediaUrl => _mediaUrl ?? "";
}
