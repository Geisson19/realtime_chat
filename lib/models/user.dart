class User {
  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.isOnline,
  });

  String name;
  String email;
  String uid;
  bool isOnline = false;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      email: json["email"],
      uid: json["uid"],
      isOnline: json["isOnline"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "isOnline": isOnline,
    };
  }
}
