class FirebaseHelpers {
  static FirebaseHelpersCollections collections = const FirebaseHelpersCollections();
  static FirebaseHelpersStorage storage = const FirebaseHelpersStorage();
}

class FirebaseHelpersCollections {
  const FirebaseHelpersCollections();
  String get user => "Whatsapp-User";
}

class FirebaseHelpersStorage {
  const FirebaseHelpersStorage();
  String get userProfile => "whatsapp/userProfile";
}