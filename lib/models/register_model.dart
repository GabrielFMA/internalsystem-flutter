class RegisterModel {
  final String? name;
  final String? email;
  final String? password;
  final String? role;
  final bool? isAdmin;

  RegisterModel({
    this.name,
    this.email,
    this.password,
    this.role,
    this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'isAdmin': isAdmin,
    };
  }
}
