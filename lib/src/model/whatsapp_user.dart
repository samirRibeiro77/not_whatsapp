class WhatsappUser {
  String? name, email, password;

  WhatsappUser({this.name, this.email, this.password});


  WhatsappUser.fromJson(Map<String, dynamic> json){
    this.name = json["name"];
    this.email = json["email"];
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email};
  }
}
