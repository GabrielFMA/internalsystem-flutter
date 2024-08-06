class UpdateModel {
  final String? name;
  final String? email;
  final String? role;
  final bool? isAdmin;
  final Map<String, dynamic>? address;
  final Map<String, dynamic>? permissions;

  UpdateModel({
    this.name,
    this.email,
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
