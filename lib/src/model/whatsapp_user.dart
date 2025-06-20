class WhatsappUser {
  String? uid, name, email, password, profilePicture;

  WhatsappUser({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.profilePicture,
  });

  WhatsappUser.fromJson(Map<String, dynamic> json, {this.uid}) {
    name = json["name"];
    email = json["email"];
    profilePicture = json["profilePicture"];
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "profilePicture": profilePicture};
  }
}
