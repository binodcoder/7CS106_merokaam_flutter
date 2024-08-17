class User {
  int? id;
  String email;
  String name;
  int? phone;
  String password;
  String? role;
  DateTime? createdAt;

  User({
    this.id,
    required this.email,
    required this.name,
    this.phone,
    required this.password,
    this.role,
    this.createdAt,
  });
}
