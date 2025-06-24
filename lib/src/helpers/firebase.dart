class FirebaseHelpers {
  static FirebaseHelpersCollections collections =
      const FirebaseHelpersCollections();
  static FirebaseHelpersStorage storage = const FirebaseHelpersStorage();
}

class FirebaseHelpersCollections {
  const FirebaseHelpersCollections();

  String get user => "Whatsapp-User";

  String get messages => "Whatsapp-Messages";

  String get chats => "Whatsapp-Chats";

  String get lastChat => "last_chats";
}

class FirebaseHelpersStorage {
  const FirebaseHelpersStorage();

  String get userProfile => "whatsapp/userProfile";

  String get messagePicture => "whatsapp/messagePicture";
}
