class User {
  final bool isOnline;
  final String email;
  final String name;
  final String uid;

  User(
      {required this.uid,
      required this.email,
      required this.name,
      required this.isOnline});
}
