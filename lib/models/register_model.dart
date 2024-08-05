class RegisterModel {
  final String? name;
  final String? email;
  final String? password;
  final String? role;
  final bool? isAdmin;
  final Map<String, dynamic>? address;
  final Map<String, dynamic>? permissions;

  RegisterModel({
    this.name,
    this.email,
    this.password,
    this.role,
    this.isAdmin,
    this.address,
    this.permissions,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'isAdmin': isAdmin,
      'address': address,
    };
  }
}
