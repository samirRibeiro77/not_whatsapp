class Chat {
  final String _name;
  final String _lastMessage;
  final String _userPicture;

  Chat(this._name, this._lastMessage, this._userPicture);

  String get userPicture => _userPicture;

  String get lastMessage => _lastMessage;

  String get name => _name;
}