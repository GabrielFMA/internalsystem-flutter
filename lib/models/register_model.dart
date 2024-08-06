class RegisterModel {
  String? name;
  String? email;
  String? password;
  String? role;
  bool? isAdmin;
  Map<String, dynamic>? address;
  Map<String, dynamic>? permissions;

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
    final Map<String, dynamic> result = {};

    final entries = [
      MapEntry('name', name),
      MapEntry('email', email),
      MapEntry('role', role),
      MapEntry('isAdmin', isAdmin),
      MapEntry('address', address),
      MapEntry('permissions', permissions),
    ];

    for (var entry in entries) {
      if (entry.value != null) {
        result[entry.key] = entry.value;
      }
    }

    return result;
  }
}
