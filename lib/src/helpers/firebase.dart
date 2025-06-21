class FirebaseHelpers {
  static FirebaseHelpersCollections collections =
      const FirebaseHelpersCollections();
  static FirebaseHelpersStorage storage = const FirebaseHelpersStorage();
}

class FirebaseHelpersCollections {
  const FirebaseHelpersCollections();

  String get user => "Whatsapp-User";

  String get messages => "Whatsapp-Messages";
}

class FirebaseHelpersStorage {
  const FirebaseHelpersStorage();

  String get userProfile => "whatsapp/userProfile";
}
