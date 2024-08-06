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
