class User {
  User({
    required this.name,
    required this.email,
    required this.uid,
    this.isOnline,
  });

  String name;
  String email;
  String uid;
  bool? isOnline = false;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      email: json["email"],
      uid: json["uid"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
    };
  }
}
