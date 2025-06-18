import 'package:not_whatsapp/src/model/whatsapp_user.dart';

class Validator {
  static String validateUser(WhatsappUser user) {
    if (user.name!.isEmpty || user.name!.length < 3) {
      return "Name needs o have more than 3 characters";
    }
    if (user.email!.isEmpty || !user.email!.contains('@')) {
      return "Email is not valid";
    }
    if (user.password!.isEmpty || user.password!.length < 6) {
      return "Password needs o have more than 6 characters";
    }
    return "";
  }
}