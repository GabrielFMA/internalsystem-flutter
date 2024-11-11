class AuthModel {
  final String? id;
  final String? name;
  final Map? permissions;
  String? email;
  String? password;

  AuthModel({
    this.id,
    this.name,
    this.email,
    this.permissions,
  });
}